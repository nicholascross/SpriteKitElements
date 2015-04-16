//
//  SpriteElementEssence.swift
//  SpriteKitElementsExample
//
//  Created by Nicholas Cross on 16/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit

var kSpriteEssence: UInt8 = 0

public class SpriteEssence<Essence> {
    
    let key: String
    
    init() {
        key = NSUUID().UUIDString
    }
    
    init(key: String) {
        self.key = key
    }
    
    public subscript(node: SKNode) -> Essence? {
        get {
            if let vessel = objc_getAssociatedObject(node, &kSpriteEssence) as? SpriteEssenceVessel {
                return vessel[key] as? Essence
            }
            
            return nil
        }
        
        set {
            if let vessel = objc_getAssociatedObject(node, &kSpriteEssence) as? SpriteEssenceVessel {
                vessel[key] = newValue
            }
            else {
                let vessel = SpriteEssenceVessel()
                objc_setAssociatedObject(node, &kSpriteEssence, vessel, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
                vessel[key] = newValue
            }
        }
    }
}

@objc private class SpriteEssenceVessel {
    var essence : [String:Any]
    
    init () {
        self.essence = [String:Any]()
    }
    
    subscript(key: String) -> Any? {
        get {
            return essence[key]
        }
        set {
            essence[key] = newValue
        }
    }
}