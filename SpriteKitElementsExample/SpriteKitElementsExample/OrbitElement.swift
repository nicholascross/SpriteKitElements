//
//  OrbitElement.swift
//  SpriteKitElementsExample
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit
import SpriteKitElements

@objc class OrbitElement : NSObject, SpriteElement {
    
    var radius: CGFloat = 180
    var period = 4.0;
    
    //note that elements that maintain internal state it cannot always be shared between nodes and behave as intended

    func update(atTime currentTime: TimeInterval, delta: TimeInterval, node: SKNode){
        if let node = node.childNode(withName: "orbit") {
            updateParticlePosition(node, currentTime: currentTime, delta: delta)
        }
    }
    
    func updateParticlePosition(_ particle: SKNode, currentTime: TimeInterval, delta: TimeInterval) {
        let orbit = (Double(currentTime).truncatingRemainder(dividingBy: period)) / period
        let angle: CGFloat = CGFloat(orbit * M_PI * 2)
        particle.position = CGPoint(x: cos(angle) * radius, y: sin(angle) * radius)
    }

    
}
