//
//  GameScene.swift
//  SpriteKitElementsExample
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import SpriteKit

class GameScene: SpriteElementScene {

    //Attaching an element to a node does not create a strong reference, if the element is not otherwise retained it will be freed and subsequent element methods will not be called
    private let topMargin = SpriteAnchor(anchor: SpriteAnchorPoint.TopEdge(80))
    private let bottomMargin = SpriteAnchor(anchor: SpriteAnchorPoint.BottomEdge(80))
    private let rightMargin = SpriteAnchor(anchor: SpriteAnchorPoint.TrailingEdge(80))
    private let leftMargin = SpriteAnchor(anchor: SpriteAnchorPoint.LeadingEdge(80))
    private let centerPoint = SpriteAnchor(anchor: SpriteAnchorPoint.Center(0, 0))
    private let lifeCycle = LifeCycleElement()
    private let orbit = OrbitElement()
    private let colour = ColourElement()
    
    override func didMoveToView(view: SKView) {
        let topLeftNode = self.childNodeWithName("TopLeft")!
        let bottomLeftNode = self.childNodeWithName("BottomLeft")!
        let topRightNode = self.childNodeWithName("TopRight")!
        let bottomRightNode = self.childNodeWithName("BottomRight")!
        let centerNode = self.childNodeWithName("Center")!

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
        
        attachElement(colour, toNode: centerNode.childNodeWithName("orbit")!)
        
        for child in children {
            
            if let node = child as? SKNode where  node.name == "debris" {
                attachElement(colour, toNode: node)
            }
        }
        
        self.size = view.frame.size
        
        super.didMoveToView(view)
        
        //Note: if we attempted to attach an element after did move to view the element method didMoveToView, didChangeSize would not to be called on the node!
        //attachElement(lifeCycle, toNode: centerNode)

    }
    
}
