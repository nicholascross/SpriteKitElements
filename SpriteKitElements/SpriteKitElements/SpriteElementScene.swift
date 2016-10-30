//
//  SpriteElementScene.swift
//  SpriteKitElements
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit

open class SpriteElementScene : SKScene, SKPhysicsContactDelegate {

    private var lastUpdateTime: TimeInterval?
    private var attachedElements: [SpriteElementNodeReference: [SpriteElementReference]] = [:]
    
    var nodeInvolvedInContact: (SKNode, SKPhysicsContact) -> Bool = {
        node, contact in
        guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node , nodeA.isEqual(to: node) || nodeB.isEqual(to: node) else {
            return false
        }
        
        return true
    }
    
    open func attachElement(_ element: SpriteElement, toNode node: SKNode) {
       
        let nodeRef = SpriteElementNodeReference(value: node)
        let elementReference = SpriteElementReference(value: element)
        
        if var elements = self.attachedElements[nodeRef] {
            elements.append(SpriteElementReference(value: element))
            self.attachedElements[nodeRef] = elements
        }
        else {
            var elements = [SpriteElementReference]()
            elements.append(elementReference)
            self.attachedElements[nodeRef] = elements
        }

        weak var weakself = self
        weak var weakNodeRef = SpriteElementNodeReference(value: node)
        SpriteElementObjectDeconstructor.registerDeconstructor(node) {
            if let scene = weakself {
                if let ref = weakNodeRef {
                    scene.attachedElements[ref] = nil
                }
            }
        }

        element.didAttach(toNode: node, inScene: self)
    }
    
    open func detachElement(_ element: SpriteElement, fromNode node: SKNode) {
        let nodeRef = SpriteElementNodeReference(value: node)
        if let elements = self.attachedElements[nodeRef] {
            self.attachedElements[nodeRef] = elements.filter({ (ref: SpriteElementReference) -> Bool in
                if let element1 = ref.element {
                    return element1 !== element
                }
                
                return false
            })
        }
    }
       
    private func _enumerateSpriteElements(_ callback: (_ element: SpriteElement, _ node: SKNode)->()) {
        for (nodeRef, elements) in self.attachedElements {
            if let node = nodeRef.node {
                for elementReference in elements {
                    if let element = elementReference.element {
                        callback(element, node)
                    }

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
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            if nodeInvolvedInContact(node, contact) {
                element.didBegin(contact: contact, node: node)
            }
            
            return
        }
    }

    open func didEnd(_ contact: SKPhysicsContact) {
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            if nodeInvolvedInContact(node, contact) {
                element.didEnd(contact: contact, node: node)
            }
            
            return
        }
    }
}
