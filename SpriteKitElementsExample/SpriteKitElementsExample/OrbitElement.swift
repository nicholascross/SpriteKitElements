//
//  OrbitElement.swift
//  SpriteKitElementsExample
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit

@objc class OrbitElement : SpriteElement {
    
    var radius: CGFloat = 180
    var period = 4.0;
    
    //note that elements that maintain internal state it cannot always be shared between nodes and behave as intended

    func update(currentTime: NSTimeInterval, delta: NSTimeInterval, node: SKNode){
        if let node = node.childNodeWithName("orbit") {
            updateParticlePosition(node, currentTime: currentTime, delta: delta)
        }
    }
    
    func updateParticlePosition(particle: SKNode, currentTime: NSTimeInterval, delta: NSTimeInterval) {
        let orbit = (Double(currentTime) % period) / period
        let angle: CGFloat = CGFloat(orbit * M_PI * 2)
        particle.position = CGPoint(x: cos(angle) * radius, y: sin(angle) * radius)
    }

    
}