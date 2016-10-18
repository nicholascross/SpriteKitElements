//
//  GameScene.swift
//  SpriteKitElementsExample
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import SpriteKit
import SpriteKitElements

class GameScene: SpriteElementScene {

    //Attaching an element to a node does not create a strong reference, if the element is not otherwise retained it will be freed and subsequent element methods will not be called
    fileprivate let topMargin = SpriteAnchor(anchor: SpriteAnchorPoint.topEdge(80))
    fileprivate let bottomMargin = SpriteAnchor(anchor: SpriteAnchorPoint.bottomEdge(80))
    fileprivate let rightMargin = SpriteAnchor(anchor: SpriteAnchorPoint.trailingEdge(80))
    fileprivate let leftMargin = SpriteAnchor(anchor: SpriteAnchorPoint.leadingEdge(80))
    fileprivate let centerPoint = SpriteAnchor(anchor: SpriteAnchorPoint.center(0, 0))
    fileprivate let lifeCycle = LifeCycleElement()
    fileprivate let orbit = OrbitElement()
    fileprivate let colour = ColourElement()
    
    override func didMove(to view: SKView) {
        let topLeftNode = self.childNode(withName: "TopLeft")!
        let bottomLeftNode = self.childNode(withName: "BottomLeft")!
        let topRightNode = self.childNode(withName: "TopRight")!
        let bottomRightNode = self.childNode(withName: "BottomRight")!
        let centerNode = self.childNode(withName: "Center")!

        attachElement(topMargin,toNode: topLeftNode);
        attachElement(leftMargin,toNode: topLeftNode);

        attachElement(bottomMargin, toNode:bottomLeftNode)
        attachElement(leftMargin,toNode: bottomLeftNode)   //You can reuse elements on different nodes
        
        attachElement(centerPoint, toNode: centerNode)
        
        attachElement(topMargin,toNode: topRightNode);
        attachElement(rightMargin,toNode: topRightNode);
        
        attachElement(bottomMargin, toNode:bottomRightNode)
        attachElement(rightMargin,toNode: bottomRightNode)
        
        attachElement(orbit, toNode: centerNode)
        attachElement(orbit, toNode: bottomRightNode)
        attachElement(orbit, toNode: topRightNode)
        
        //log when ever an element method is called
        //attachElement(lifeCycle, toNode: centerNode)
        
        attachElement(colour, toNode: centerNode.childNode(withName: "orbit")!)
        
        for child in children {
            
            if child.name == "debris" {
                attachElement(colour, toNode: child)
            }
        }
        
        self.size = view.frame.size
        
        super.didMove(to: view)
        
        //Note: if we attempted to attach an element after did move to view the element method didMoveToView, didChangeSize would not to be called on the node!
        //attachElement(lifeCycle, toNode: centerNode)

    }
    
}
