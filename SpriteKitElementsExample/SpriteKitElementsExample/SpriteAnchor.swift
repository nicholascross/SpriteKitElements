//
//  SpriteAnchor.swift
//  SpriteKitElementsExample
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit

@objc class SpriteAnchor : SpriteElement {
    
    let anchorPoint: SpriteAnchorPoint
    
    init(anchor: SpriteAnchorPoint) {
        self.anchorPoint = anchor
    }
    
    func didChangeSize(oldSize: CGSize, node: SKNode) {
        if let scene = node.scene {
            self.anchorPoint.updatePosition(node, scene: scene)
        }
    }
    
    func didAttach(node: SKNode, inScene scene:SpriteElementScene) {
        self.anchorPoint.updatePosition(node, scene: scene)
    }

}

enum SpriteAnchorPoint {
    case LeadingEdge(CGFloat)
    case TrailingEdge(CGFloat)
    case TopEdge(CGFloat)
    case BottomEdge(CGFloat)
    case Center(CGFloat, CGFloat)
    
    func updatePosition(node: SKNode, scene: SKScene) {
        switch(self) {
        case LeadingEdge(let x):
            node.position = CGPoint(x: x, y: node.position.y)
        case TrailingEdge(let x):
            node.position = CGPoint(x: scene.size.width - x, y: node.position.y)
        case TopEdge(let y):
            node.position = CGPoint(x: node.position.x, y: scene.size.height - y)
        case BottomEdge(let y):
            node.position = CGPoint(x: node.position.x, y: y)
        case Center(let x, let y):
            node.position = CGPoint(x: scene.size.width / 2 + x, y: scene.size.height / 2 + y)
        }
    }
}