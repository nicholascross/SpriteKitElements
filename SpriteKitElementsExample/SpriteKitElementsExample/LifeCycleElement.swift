//
//  LifeCycleElement.swift
//  SpriteKitElementsExample
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit

@objc class LifeCycleElement : SpriteElement {
    func didAttach(node: SKNode, inScene scene:SpriteElementScene) {
        println("didAttach")
    }
    
    func update(currentTime: NSTimeInterval, delta: NSTimeInterval, node: SKNode){
        println("update currentTime:\(currentTime) delta:\(delta)")
    }
    
    func didEvaluateActions(node: SKNode){
        println("didEvaluateActions")
    }
    
    func didSimulatePhysics(node: SKNode){
        println("didSimulatePhysics")
    }
    
    func didApplyConstraints(node: SKNode){
        println("didApplyConstraints")
    }
    
    func didFinishUpdate(node: SKNode){
        println("didFinishUpdate")
    }
    
    func didMoveToView(view: SKView!, node: SKNode){
        println("didMoveToView")
    }
    
    func willMoveFromView(view: SKView!, node: SKNode){
        println("willMoveFromView")
    }
    
    func didChangeSize(oldSize: CGSize, node: SKNode){
        println("didChangeSize")
    }

}