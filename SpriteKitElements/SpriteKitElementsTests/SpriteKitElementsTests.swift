//
//  SpriteKitElementsTests.swift
//  SpriteKitElementsTests
//
//  Created by Nicholas Cross on 29/10/2016.
//  Copyright © 2016 Nicholas Cross. All rights reserved.
//

import XCTest
import SpriteKit
@testable import SpriteKitElements

class SpriteKitElementsTests: XCTestCase {

    private var elementScene: SpriteElementScene!
    private var node: SKNode!
    private var element: MockElement!

    override func setUp() {
        super.setUp()

        elementScene = SpriteElementScene()
        node = SKNode()
        element = MockElement()

        elementScene.attachElement(element, toNode: node)
    }

    func testUpdate() {
        elementScene.update(0)

        XCTAssert(element.didUpdateElement, "Expected update element to be called")
    }

    func testAttach() {
        XCTAssert(element.didAttachToElement, "Expected attach element to be called")
    }

    func testEvalActions() {
        elementScene.didEvaluateActions()

        XCTAssert(element.didAttachToElement, "Expected didEvaluateActions to be called")
    }

    func testSimPhysics() {
        elementScene.didSimulatePhysics()

        XCTAssert(element.didSimulatePhysicsForElement, "Expected didSimulatePhysics to be called")
    }

    func testApplyConstraints() {
        elementScene.didApplyConstraints()

        XCTAssert(element.didApplyConstraintsForElement, "Expected didApplyConstraints to be called")
    }

    func testFinishUpdate() {
        elementScene.didFinishUpdate()

        XCTAssert(element.didFinishUpdateForElement, "Expected didFinishUpdate to be called")
    }

    #if !os(OSX)

    func testWillMove() {
        elementScene.willMove(from: SKView())

        XCTAssert(element.willMoveElement, "Expected willMove(fromView) to be called")
    }

    func testDidMove() {
        elementScene.didMove(to: SKView())

        XCTAssert(element.didMoveElement, "Expected didMove(toView) to be called")
    }

    //TODO: Remove this - These tests are failing on travis ci

    #endif

    func testChangeSize() {
        elementScene.didChangeSize(CGSize(width: 0, height: 0))

        XCTAssert(element.didChangeSizeOfElement, "Expected didChangeSize to be called")
    }

    //TODO: Restore contact tests, this will require refactoring the element scene to extract another dependency

    func testDetach() {
        elementScene.detachElement(element, fromNode: node)
        elementScene.update(0)

        XCTAssert(!element.didUpdateElement, "Expected element to be detached before update was called")
    }

    func testNodeMemoyManagement() {
        weak var weakNode = node
        node = nil
        XCTAssertNil(weakNode, "Expected node to be released")
    }

    func testElementMemoyManagement() {
        weak var weekElement = element
        element = nil
        XCTAssertNotNil(weekElement, "Expected element to be retained because it is still attached to a node")

        node = nil
        elementScene.update(0)
        XCTAssertNil(weekElement, "Expected element to be released when node is deallocated after update")
    }

    func testElementReaping() {
        weak var weekElement = element
        element = nil
        XCTAssertNotNil(weekElement, "Expected element to be retained because it is still attached to a node")

        elementScene.update(0)
        XCTAssertNotNil(weekElement, "Expected element to be retained because it is still attached to a node")

        elementScene.update(1)
        XCTAssertNotNil(weekElement, "Expected element to be retained, the scene has not reached the reaping interval")

        node = nil
        elementScene.update(6)
        XCTAssertNil(weekElement, "Expected element to be released because the scene has passed the reaping interval")
    }

    func testEnumeratePerformance() {
        var nodes: [SKNode] = [SKNode]()

        for _ in 0..<500 {
            let node = SKNode()
            node.position = CGPoint(x: Int(arc4random_uniform(1000)), y: 0)
            nodes.append(node)
            elementScene.attachElement(element, toNode: node)
        }

        measure {
            for index in 0..<60 {
                self.elementScene.update(TimeInterval(index))
            }
        }
    }
}

private class MockElement: SpriteElement {
    var didUpdateElement = false
    var didAttachToElement = false
    var didEvaluateActionsForElement = false
    var didSimulatePhysicsForElement = false
    var didApplyConstraintsForElement = false
    var didFinishUpdateForElement = false
    var didMoveElement = false
    var willMoveElement = false
    var didChangeSizeOfElement = false
    var didBeginContactForElement = false
    var didEndContactForElement = false

    func update(atTime currentTime: TimeInterval, delta: TimeInterval, node: SKNode) {
        didUpdateElement = true
    }

    func didAttach(toNode node: SKNode, inScene scene: SpriteElementScene) {
        didAttachToElement = true
    }

    func didEvaluateActions(_ node: SKNode) {
        didEvaluateActionsForElement = true
    }

    func didSimulatePhysics(_ node: SKNode) {
        didSimulatePhysicsForElement = true
    }

    func didApplyConstraints(_ node: SKNode) {
        didApplyConstraintsForElement = true
    }

    func didFinishUpdate(_ node: SKNode) {
        didFinishUpdateForElement = true
    }

    func didMove(toView view: SKView, node: SKNode) {
        didMoveElement = true
    }

    func willMove(fromView view: SKView, node: SKNode) {
        willMoveElement = true
    }

    func didChange(size oldSize: CGSize, node: SKNode) {
        didChangeSizeOfElement = true
    }

    func didBegin(contact: SKPhysicsContact, node: SKNode) {
        didBeginContactForElement = true
    }

    func didEnd(contact: SKPhysicsContact, node: SKNode) {
        didEndContactForElement = true
    }
}
