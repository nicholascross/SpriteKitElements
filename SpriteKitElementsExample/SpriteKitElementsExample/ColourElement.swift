//
//  ColourElement.swift
//  SpriteKitElementsExample
//
//  Created by Nicholas Cross on 16/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit

@objc class ColourElement : SpriteElement {
    
    let hue = SpriteEssence<CGFloat>()
    
    func didAttach(node: SKNode, inScene scene: SpriteElementScene) {
        node.physicsBody?.contactTestBitMask = 1;
    }
    
    func didBeginContact(contact: SKPhysicsContact, node: SKNode) {
        if let h = hue[node] {
            hue[node] = h + 0.05
        }
        else {
            hue[node] = 0
        }
        
        if let spriteNode = node as? SKSpriteNode, let h = hue[node] {
            if h > 0.9 {
                hue[node] = 0
            }
            
            spriteNode.color = UIColor(hue: h, saturation: 1, brightness: 0.9, alpha: 1)
        }
    }
    
}