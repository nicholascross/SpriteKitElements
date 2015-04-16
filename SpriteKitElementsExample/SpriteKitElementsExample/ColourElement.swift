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
    
    let red = SpriteEssence<CGFloat>()
    let green = SpriteEssence<CGFloat>()
    let blue = SpriteEssence<CGFloat>()
    
    func didAttach(node: SKNode, inScene scene: SpriteElementScene) {
        node.physicsBody?.contactTestBitMask = 1;
    }
    
    func didBeginContact(contact: SKPhysicsContact, node: SKNode) {
        if let r = red[node], let g = green[node], let b = blue[node] {
            red[node] = r + 0.05
            green[node] = g + 0.1
            blue[node] = b + 0.025
        }
        else {
            red[node] = 0
            green[node] = 0
            blue[node] = 1
        }
        
        if let spriteNode = node as? SKSpriteNode, let r = red[node], let g = green[node], let b = blue[node]  {
            if r > 0.9 {
                red[node] = 0
            }
            
            if g > 0.9 {
                green[node] = 0
            }
            
            if b > 0.9 {
                blue[node] = 0
            }
            
            spriteNode.color = UIColor(red: r, green: g, blue: b, alpha: 1)
        }
    }
    
}