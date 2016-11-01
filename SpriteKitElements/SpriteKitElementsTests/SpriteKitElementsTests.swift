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
    
    var elementScene: SpriteElementScene!
    var node: SKNode!
    var element: MockElement!
    
    override func setUp() {
        super.setUp()
        
        elementScene = SpriteElementScene()
        node = SKNode()
        element = MockElement()
        
        elementScene.nodeInvolvedInContact = { [unowned self]
            node, _ in
            return node == self.node
        }
        
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
    
    func testWillMove() {
        elementScene.willMove(from: SKView())
        
        XCTAssert(element.willMoveElement, "Expected willMove(fromView) to be called")
    }
    
    func testDidMove() {
        elementScene.didMove(to: SKView())
        
        XCTAssert(element.didMoveElement, "Expected didMove(toView) to be called")
    }
    
    func testChangeSize() {
        elementScene.didChangeSize(CGSize(width: 0, height: 0))
        
        XCTAssert(element.didChangeSizeOfElement, "Expected didChangeSize to be called")
    }
    
    func testBeginContact() {
        elementScene.didBegin(SKPhysicsContact())
        XCTAssert(element.didBeginContactForElement, "Expected didBegin to be called")
    }
    
    func testEndContact() {
        elementScene.didEnd(SKPhysicsContact())
        
        XCTAssert(element.didEndContactForElement, "Expected didEnd to be called")
    }
    
    func testDetach() {
        elementScene.detachElement(element, fromNode: node)
        elementScene.update(0)
        
        XCTAssert(!element.didUpdateElement, "Expected element to be detached before update was called")
    }
    
    func testNodeMemoyManagement() {
        weak var n = node
        node = nil
        XCTAssert(n == nil, "Expected node to be released")
    }
    
    func testElementMemoyManagement() {
        weak var e = element
        element = nil
        XCTAssert(e != nil, "Expected element to be retained because it is still attached to a node")
        
        node = nil
        elementScene.update(0)
        XCTAssert(e == nil, "Expected element to be released when node is deallocated after update")
    }
    
    func testElementReaping() {
        weak var e = element
        element = nil
        XCTAssert(e != nil, "Expected element to be retained because it is still attached to a node")
        
        elementScene.update(0)
        XCTAssert(e != nil, "Expected element to be retained because it is still attached to a node")
        
        node = nil
        elementScene.update(2)
        XCTAssert(e != nil, "Expected element to be retained because the scene has not reached the reaping interval")
        
        elementScene.update(6)
        XCTAssert(e == nil, "Expected element to be released because the scene has passed the reaping interval")
    }
}

class MockElement : SpriteElement {
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
    
    func didAttach(toNode node: SKNode, inScene scene:SpriteElementScene) {
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
