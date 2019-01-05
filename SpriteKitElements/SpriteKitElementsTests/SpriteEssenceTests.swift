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
        XCTAssertEqual(anotherElement.essenceValue!, 30, "Expected updated value to be accessible in other elements")
    }

    func testEssenceReferences() {
        let essence1 = SpriteEssence<SKNode>(key: "e")
        let essence2 = SpriteEssence<SKNode>(key: "e")

        essence1[node] = SKNode()
        XCTAssertNotNil(essence1[node])
        XCTAssertNotNil(essence2[node])
        XCTAssertEqual(essence1[node], essence2[node], "Expected essence values to be the same")
    }

    func testMemoryManagement() {
        let essence = SpriteEssence<SKNode>(key: "e")
        essence[node] = SKNode()

        weak var releaseLater = essence[node]
        XCTAssertNotNil(releaseLater, "Expected essence value to be retained")

        node = nil
        XCTAssertNil(releaseLater, "Expected essence value to be released")
    }
}

private class MockElement: SpriteElement {
    var didUpdateElement = false

    let essence: SpriteEssence<Int> = SpriteEssence<Int>(key: "asdf")

    func update(atTime currentTime: TimeInterval, delta: TimeInterval, node: SKNode) {
        didUpdateElement = true
        essence[node] = 30
    }

}

private class AnotherMockElement: SpriteElement {
    var didUpdateElement = false
    var essenceValue: Int?

    let essence: SpriteEssence<Int> = SpriteEssence<Int>(key: "asdf")

    func update(atTime currentTime: TimeInterval, delta: TimeInterval, node: SKNode) {
        didUpdateElement = true
        essenceValue = essence[node]
    }

}
