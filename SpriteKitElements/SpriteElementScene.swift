//
//  SpriteElementScene.swift
//  SpriteKitElements
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit

class SpriteElementScene : SKScene {

    var lastUpdateTime: NSTimeInterval?
    var attachedElements: [SpriteElementNodeReference: [SpriteElementReference]] = [:]
    
    func attachElement(element: SpriteElement, toNode node: SKNode) {
       
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

        element.didAttach?(node, inScene: self)
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
    
    override func update(currentTime: NSTimeInterval) {
        var delta: NSTimeInterval = 0
        
        if let lastUpdateTime = self.lastUpdateTime {
            delta = currentTime - lastUpdateTime
        }
        
        self.lastUpdateTime = currentTime

        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.update?(currentTime, delta:delta, node: node)
            return
        }
    }
    
    override func didEvaluateActions() {
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didEvaluateActions?(node)
            return
        }
    }
    
    override func didSimulatePhysics(){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didSimulatePhysics?(node)
            return
        }
    }
    
    override func didApplyConstraints(){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didApplyConstraints?(node)
            return
        }
    }

    override func didFinishUpdate(){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didFinishUpdate?(node)
            return
        }
    }
    
    override func didMoveToView(view: SKView){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.didMoveToView?(view, node: node)
            return
        }
    }
    
    override func willMoveFromView(view: SKView){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
            element.willMoveFromView?(view, node: node)
            return
        }
    }
    
    override func didChangeSize(oldSize: CGSize){
        _enumerateSpriteElements() { (element: SpriteElement, node: SKNode) in
           element.didChangeSize?(oldSize, node: node)
            return
        }
    }

    
}