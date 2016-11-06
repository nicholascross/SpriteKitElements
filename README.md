# SpriteKitElements
![build status](https://travis-ci.org/nicholascross/SpriteKitElements.svg?branch=master)
![code coverage](https://img.shields.io/codecov/c/github/nicholascross/SpriteKitElements.svg)
[![carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) 
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/SpriteKitElements.svg)](https://cocoapods.org/pods/SpriteKitElements) 
[![GitHub release](https://img.shields.io/github/release/nicholascross/SpriteKitElements.svg)](https://github.com/nicholascross/SpriteKitElements/releases) 
![Swift 3.0.x](https://img.shields.io/badge/Swift-3.0.x-orange.svg) 
![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20OS%20X%20%7C%20tvOS%20-lightgrey.svg)

A small swift framework for attaching additional functionality to any SKNode with out the need to sub class.  This means you can design your scene in Xcode and attach reusable behaviours to any SKNode such as SKLightNode, SKEmitterNode, etc

# SpriteElementScene (class)

You must use the custom `SKScene` sub class `SpriteElementScene` but you can attach elements to any SKNode without sub classing.

You can attach an element to a node in your scene using the `func attachElement(element: SpriteElement, toNode node: SKNode)` method of `SpriteElementScene`

# SpriteElement (protocol)

Implement any of the optional methods in this interface to perform specific actions on a node during the scene life cycle.

```swift
    //Called when an element is first attached to a node
    func didAttach(toNode node: SKNode, inScene scene:SpriteElementScene)
    
    //Called during scene update, delta is the time since the last scene update
    func update(atTime currentTime: TimeInterval, delta: TimeInterval, node: SKNode)

    func didEvaluateActions(_ node: SKNode)

    func didSimulatePhysics(_ node: SKNode)

    func didApplyConstraints(_ node: SKNode)

    func didFinishUpdate(_ node: SKNode)

    func didMove(toView view: SKView, node: SKNode)

    func willMove(fromView view: SKView, node: SKNode)

    func didChange(size oldSize: CGSize, node: SKNode)

    func didBegin(contact: SKPhysicsContact, node: SKNode)
    
    func didEnd(contact: SKPhysicsContact, node: SKNode)
```

# SpriteEssence (class)

In order to maximise reuse of elements you should avoid maintaining state in the element where possible.

If maintaining per node state is necessary for the behaviour you are implementing you can use the SpriteEssence class to maintain additional state for your element unique to the node the element is currently handling in a type safe manner.

# Example

Source code for this example can be found [here](https://github.com/nicholascross/SpriteKitElementsExample)

## Contact began
Any SKSpriteNode with this element attached will progressively change colour as it collides with other nodes that have the same attached element.  You can see this in action in the example project.
```swift
import Foundation
import SpriteKit
import SpriteKitElements

class ColorElement : SpriteElement {
    
    let hue = SpriteEssence<CGFloat>()
    
    func createBody() -> SKPhysicsBody {
        let body = SKPhysicsBody(circleOfRadius: 40)
        body.categoryBitMask = 1
        body.contactTestBitMask = 1
        body.collisionBitMask = 1
        body.affectedByGravity = true
        return body;
    }
    
    func didAttach(toNode node: SKNode, inScene scene: SpriteElementScene) {
        hue[node] = 0
        node.physicsBody = createBody()
    }
    
    func didBegin(contact: SKPhysicsContact, node: SKNode) {
        if let shapeNode = node as? SKShapeNode, let h = hue[node] {
            if h > 0.9 {
                hue[node] = 0
            }
            else {
                hue[node] = h + 0.05
            }
            
            shapeNode.strokeColor = UIColor(hue: h, saturation: 1, brightness: 0.9, alpha: 1)
        }
    }

}
```

## Element attached and scene update
Any sprite node whose y position is less than -500 will be removed from the scene
```swift
class RemoveOffScreen: SpriteElement {
    
    let timeInterval = SpriteEssence<TimeInterval>()
    
    func didAttach(toNode node: SKNode, inScene scene: SpriteElementScene) {
        timeInterval[node] = 0
    }
    
    func update(atTime currentTime: TimeInterval, delta: TimeInterval, node: SKNode) {
        guard currentTime > timeInterval[node]! + 1 else {
            //This does not need to be done on every frame
            return
        }
        
        timeInterval[node] = currentTime
        
        if node.position.y < -500 {
            node.removeFromParent()
        }
    }
}
```
