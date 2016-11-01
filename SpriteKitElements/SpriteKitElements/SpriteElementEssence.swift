//
//  SpriteElementEssence.swift
//  SpriteKitElementsExample
//
//  Created by Nicholas Cross on 16/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit
import WeakDictionary

fileprivate var essences: WeakKeyDictionary<SKNode, SpriteEssenceVessel> = WeakKeyDictionary<SKNode, SpriteEssenceVessel>(withValuesRetainedByKey: true)

public func reapEssences() {
    essences.reap()
}

open class SpriteEssence<Essence> {
    
    private let key: String
    
    
    public init() {
        key = UUID().uuidString
    }
    
    public init(key: String) {
        self.key = key
    }
    
    public subscript(node: SKNode) -> Essence? {
        get {
            if let vessel = essences[node] {
                return vessel[key] as? Essence
            }
            
            return nil
        }
        
        set {
            if let vessel = essences[node] {
                vessel[key] = newValue
            }
            else {
                let vessel = SpriteEssenceVessel()
                essences[node] = vessel
                vessel[key] = newValue
            }
        }
    }
}

private class SpriteEssenceVessel {
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
