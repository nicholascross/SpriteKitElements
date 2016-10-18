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
    func didAttach(toNode node: SKNode, inScene scene:SpriteElementScene) {
        print("didAttach")
    }
    
    func update(atTime currentTime: TimeInterval, delta: TimeInterval, node: SKNode){
        print("update currentTime:\(currentTime) delta:\(delta)")
    }
    
    func didEvaluateActions(_ node: SKNode){
        print("didEvaluateActions")
    }
    
    func didSimulatePhysics(_ node: SKNode){
        print("didSimulatePhysics")
    }
    
    func didApplyConstraints(_ node: SKNode){
        print("didApplyConstraints")
    }
    
    func didFinishUpdate(_ node: SKNode){
        print("didFinishUpdate")
    }
    
    func didMove(toView view: SKView, node: SKNode){
        print("didMoveToView")
    }
    
    func willMove(fromView view: SKView, node: SKNode){
        print("willMoveFromView")
    }
    
    func didChange(size oldSize: CGSize, node: SKNode){
        print("didChangeSize")
    }

}
