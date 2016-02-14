//
//  SpriteElementScene.swift
//  SpriteKitElements
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit

public class SpriteElementScene : SKScene, SKPhysicsContactDelegate {

    private var lastUpdateTime: NSTimeInterval?
    private var attachedElements: [SpriteElementNodeReference: [SpriteElementReference]] = [:]

    public func attachElement(element: SpriteElement, toNode node: SKNode) {
       
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

        element.didAttach(node, inScene: self)
    }
    
    public func detachElement(element: SpriteElement, fromNode node: SKNode) {
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
       
    private func _enumerateSpriteElements(callback: (element: SpriteElement, node: SKNode)->()) {
        for (nodeRef, elements) in self.attachedElements {
            if let node = nodeRef.node {
                for elementReference in elements {
                    if let element = elementReference.element {
                        callback(element: element, node: node)
                    }

                }
            }
        }
    }
    
    public override func update(currentTime: NSTimeInterval) {
        var delta: NSTimeInterval = 0
        
        if let lastUpdateTime = self.lastUpdateTime {
            delta = currentTime - lastUpdateTime
        }
        
        self.lastUpdateTime = currentTime

        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.update(currentTime, delta:delta, node: node)
            return
        }
    }
    
    public override func didEvaluateActions() {
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didEvaluateActions(node)
            return
        }
    }
    
    public override func didSimulatePhysics(){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didSimulatePhysics(node)
            return
        }
    }
    
    public override func didApplyConstraints(){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didApplyConstraints(node)
            return
        }
    }

    public override func didFinishUpdate(){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didFinishUpdate(node)
            return
        }
    }
    
    public override func didMoveToView(view: SKView){
        physicsWorld.contactDelegate = self;
        
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didMoveToView(view, node: node)
            return
        }
    }
    
    public override func willMoveFromView(view: SKView){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.willMoveFromView(view, node: node)
            return
        }
    }
    
    public override func didChangeSize(oldSize: CGSize){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
           element.didChangeSize(oldSize, node: node)
            return
        }
    }
    
    public func didBeginContact(contact: SKPhysicsContact) {
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            if let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node where nodeA.isEqualToNode(node) || nodeB.isEqualToNode(node) {
                element.didBeginContact(contact, node: node)
            }
            return
        }
    }

    public func didEndContact(contact: SKPhysicsContact) {
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            if let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node where nodeA.isEqualToNode(node) || nodeB.isEqualToNode(node) {
                element.didEndContact(contact, node: node)
            }
            return
        }
    }
}