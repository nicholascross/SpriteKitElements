//
//  SpriteAnchor.swift
//  SpriteKitElementsExample
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit
import SpriteKitElements

class SpriteAnchor : SpriteElement {
    
    let anchorPoint: SpriteAnchorPoint
    
    init(anchor: SpriteAnchorPoint) {
        self.anchorPoint = anchor
    }
    
    func didChange(size oldSize: CGSize, node: SKNode) {
        if let scene = node.scene {
            self.anchorPoint.updatePosition(node, scene: scene)
        }
    }
    
    func didAttach(toNode node: SKNode, inScene scene:SpriteElementScene) {
        self.anchorPoint.updatePosition(node, scene: scene)
    }

}

enum SpriteAnchorPoint {
    case leadingEdge(CGFloat)
    case trailingEdge(CGFloat)
    case topEdge(CGFloat)
    case bottomEdge(CGFloat)
    case center(CGFloat, CGFloat)
    
    func updatePosition(_ node: SKNode, scene: SKScene) {
        switch(self) {
        case .leadingEdge(let x):
            node.position = CGPoint(x: x, y: node.position.y)
        case .trailingEdge(let x):
            node.position = CGPoint(x: scene.size.width - x, y: node.position.y)
        case .topEdge(let y):
            node.position = CGPoint(x: node.position.x, y: scene.size.height - y)
        case .bottomEdge(let y):
            node.position = CGPoint(x: node.position.x, y: y)
        case .center(let x, let y):
            node.position = CGPoint(x: scene.size.width / 2 + x, y: scene.size.height / 2 + y)
        }
    }
}
