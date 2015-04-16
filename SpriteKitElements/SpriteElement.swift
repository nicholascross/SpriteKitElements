//
//  SpriteElement.swift
//  SpriteKitElements
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit

@objc public protocol SpriteElement {

    optional func didAttach(node: SKNode, inScene scene:SpriteElementScene)

    optional func update(currentTime: NSTimeInterval, delta: NSTimeInterval, node: SKNode)

    optional func didEvaluateActions(node: SKNode)

    optional func didSimulatePhysics(node: SKNode)

    optional func didApplyConstraints(node: SKNode)

    optional func didFinishUpdate(node: SKNode)

    optional func didMoveToView(view: SKView!, node: SKNode)

    optional func willMoveFromView(view: SKView!, node: SKNode)

    optional func didChangeSize(oldSize: CGSize, node: SKNode)

    optional func didBeginContact(contact: SKPhysicsContact, node: SKNode)
    
    optional func didEndContact(contact: SKPhysicsContact, node: SKNode)
}
