//
//  SpriteEssenceTests.swift
//  SpriteKitElements
//
//  Created by Nicholas Cross on 1/11/2016.
//  Copyright © 2016 Nicholas Cross. All rights reserved.
//

import XCTest
import SpriteKit
@testable import SpriteKitElements

class SpriteEssenceTests: XCTestCase {
    
    var elementScene: SpriteElementScene!
    var node: SKNode!
    private var element: MockElement!
    private var anotherElement: AnotherMockElement!
    
    override func setUp() {
        super.setUp()
        
        elementScene = SpriteElementScene()
        node = SKNode()
        element = MockElement()
        anotherElement = AnotherMockElement()
        
        elementScene.attachElement(element, toNode: node)
        elementScene.attachElement(anotherElement, toNode: node)
    }
    
    func testUpdateEssence() {
        elementScene.update(0)
        
        XCTAssert(element.didUpdateElement, "Expected update element to be called")
        XCTAssert(anotherElement.essenceValue! == 30, "Expected essence value to be updated and accessible in other elements")
    }

    func testEssenceReferences() {
        let e1 = SpriteEssence<SKNode>(key: "e")
        let e2 = SpriteEssence<SKNode>(key: "e")
        
        e1[node] = SKNode()
        XCTAssert(e1[node] != nil && e1[node] == e2[node], "Expected essence values to be the same")
    }

    func testMemoryManagement() {
        let e1 = SpriteEssence<SKNode>(key: "e")
        e1[node] = SKNode()
        
        weak var releaseLater = e1[node]
        XCTAssert(releaseLater != nil, "Expected essence value to be retained")
        
        node = nil
        XCTAssert(releaseLater == nil, "Expected essence value to be released")
    }
}

fileprivate class MockElement : SpriteElement {
    var didUpdateElement = false
    
    let essence: SpriteEssence<Int> = SpriteEssence<Int>(key: "asdf")
    
    func update(atTime currentTime: TimeInterval, delta: TimeInterval, node: SKNode) {
        didUpdateElement = true
        essence[node] = 30
    }
    
}

fileprivate class AnotherMockElement : SpriteElement {
    var didUpdateElement = false
    var essenceValue: Int?
    
    let essence: SpriteEssence<Int> = SpriteEssence<Int>(key: "asdf")
    
    func update(atTime currentTime: TimeInterval, delta: TimeInterval, node: SKNode) {
        didUpdateElement = true
        essenceValue = essence[node]
    }
    
}
