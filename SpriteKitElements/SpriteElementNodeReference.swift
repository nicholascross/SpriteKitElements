//
// Created by Nicholas Cross on 12/04/15.
// Copyright (c) 2015 nacross web. All rights reserved.
//

import Foundation
import SpriteKit

func == (lhs: SpriteElementNodeReference, rhs: SpriteElementNodeReference) -> Bool {
    return lhs.node == rhs.node
}

class SpriteElementNodeReference: Hashable, Equatable {
    fileprivate weak var value : SKNode?
    fileprivate var hash: Int

    init (value: SKNode) {
        self.value = value
        self.hash = value.hashValue
    }

    var node: SKNode? {
        return self.value
    }

    var hashValue: Int {
        return self.hash
    }
}
