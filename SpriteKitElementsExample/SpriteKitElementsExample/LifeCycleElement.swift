//
//  LifeCycleElement.swift
//  SpriteKitElementsExample
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKitElements
import SpriteKit

@objc class LifeCycleElement : NSObject, SpriteElement {
    func didAttach(node: SKNode, inScene scene:SpriteElementScene) {
        print("didAttach")
    }
    
    func update(currentTime: NSTimeInterval, delta: NSTimeInterval, node: SKNode){
        print("update currentTime:\(currentTime) delta:\(delta)")
    }
    
    func didEvaluateActions(node: SKNode){
        print("didEvaluateActions")
    }
    
    func didSimulatePhysics(node: SKNode){
        print("didSimulatePhysics")
    }
    
    func didApplyConstraints(node: SKNode){
        print("didApplyConstraints")
    }
    
    func didFinishUpdate(node: SKNode){
        print("didFinishUpdate")
    }
    
    func didMoveToView(view: SKView!, node: SKNode){
        print("didMoveToView")
    }
    
    func willMoveFromView(view: SKView!, node: SKNode){
        print("willMoveFromView")
    }
    
    func didChangeSize(oldSize: CGSize, node: SKNode){
        print("didChangeSize")
    }

}