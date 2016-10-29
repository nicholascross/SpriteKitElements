//
//  SpriteElementReference.swift
//  SpriteKitElements
//
//  Created by Nicholas Cross on 12/04/2015.
//  Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit

class SpriteElementReference {
    fileprivate weak var value : SpriteElement?
    
    init (value: SpriteElement) {
        self.value = value
    }
    
    var element: SpriteElement? {
        return self.value
    }
}
