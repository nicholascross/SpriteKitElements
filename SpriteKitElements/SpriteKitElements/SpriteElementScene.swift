//
//  SpriteElementScene.swift
//  SpriteKitElements
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit
import WeakDictionary

open class SpriteElementScene : SKScene, SKPhysicsContactDelegate {

    public var elementReapInterval: TimeInterval = 5
    private var lastReapTime: TimeInterval?
    private var reapingNeeded: Bool = false
    
    private var lastUpdateTime: TimeInterval?
    private var attachedElements: WeakKeyDictionary<SKNode,SpriteElementCollectionBox> = WeakKeyDictionary<SKNode,SpriteElementCollectionBox>(withValuesRetainedByKey: true)
    
    
    
    open func attachElement(_ element: SpriteElement, toNode node: SKNode) {
        if let elements = self.attachedElements[node] {
            elements.attach(element)
            self.attachedElements[node] = elements
        }
        else {
            let elements = SpriteElementCollectionBox()
            elements.attach(element)
            self.attachedElements[node] = elements
        }

        element.didAttach(toNode: node, inScene: self)
    }
    
    open func detachElement(_ element: SpriteElement, fromNode node: SKNode) {
        self.attachedElements[node]?.detach(element)
    }
       
    private func _enumerateSpriteElements(_ callback: (_ element: SpriteElement, _ node: SKNode)->()) {
        for (nodeRef, elementRef) in self.attachedElements {
            guard let elements = elementRef.value?.elements, let node = nodeRef.key else {
                reapingNeeded = true
                continue
            }
            
            for element in elements {
                callback(element, node)
            }
        }
    }
    
    var testContact: (SKPhysicsBody, WeakKeyDictionary<SKNode,SpriteElementCollectionBox>, (_ element: SpriteElement, _ node: SKNode)->()) -> () = {
        body, attachedElements, callback in
        
        guard let node = body.node else {
            return
        }
        
        if node === body.node {
            if let elements = attachedElements[node]?.elements {
                for element in elements {
                    callback(element, node)
                }
            }
        }
    }
    
    open override func update(_ currentTime: TimeInterval) {
        var delta: TimeInterval = 0
        
        if let lastUpdateTime = self.lastUpdateTime {
            delta = currentTime - lastUpdateTime
        }
        
        self.lastUpdateTime = currentTime

        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.update(atTime: currentTime, delta:delta, node: node)
            return
        }
        
        if reapingNeeded && (lastReapTime == nil || currentTime - lastReapTime! > elementReapInterval) {
            self.attachedElements.reap()
            self.lastReapTime = currentTime
        }
        
    }
    
    open override func didEvaluateActions() {
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didEvaluateActions(node)
            return
        }
    }
    
    open override func didSimulatePhysics(){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didSimulatePhysics(node)
            return
        }
    }
    
    open override func didApplyConstraints(){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didApplyConstraints(node)
            return
        }
    }

    open override func didFinishUpdate(){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didFinishUpdate(node)
            return
        }
    }
    
    open override func didMove(to view: SKView){
        physicsWorld.contactDelegate = self;
        
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didMove(toView: view, node: node)
            return
        }
    }
    
    open override func willMove(from view: SKView){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.willMove(fromView: view, node: node)
            return
        }
    }
    
    open override func didChangeSize(_ oldSize: CGSize){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didChange(size: oldSize, node: node)
            return
        }
    }
    
    open func didBegin(_ contact: SKPhysicsContact) {
        testContact(contact.bodyA, attachedElements) {
            element, node in
            element.didBegin(contact: contact, node: node)
        }
        
        testContact(contact.bodyB, attachedElements) {
            element, node in
            element.didBegin(contact: contact, node: node)
        }
    }

    open func didEnd(_ contact: SKPhysicsContact) {
        testContact(contact.bodyA, attachedElements) {
            element, node in
            element.didEnd(contact: contact, node: node)
        }
        
        testContact(contact.bodyB, attachedElements) {
            element, node in
            element.didEnd(contact: contact, node: node)
        }
    }
}

class SpriteElementCollectionBox {
    fileprivate var elements: [SpriteElement] = []
    
    func attach(_ element: SpriteElement) {
        elements.append(element)
    }
    
    func detach(_ element: SpriteElement) {
        elements = elements.filter({ (e: SpriteElement) -> Bool in
            return e !== element
        })
    }
}
