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
    func update(atTime currentTime: NSTimeInterval, delta: NSTimeInterval, node: SKNode)

    func didEvaluateActions(_ node: SKNode)

    func didSimulatePhysics(_ node: SKNode)

    func didApplyConstraints(_ node: SKNode)

    func didFinishUpdate(_ node: SKNode)

    func didMove(toView view: SKView!, node: SKNode)

    func willMove(fromView view: SKView!, node: SKNode)

    func didChange(size oldSize: CGSize, node: SKNode)
    
    func didBegin(contact contact: SKPhysicsContact, node: SKNode)
    
    func didEnd(contact contact: SKPhysicsContact, node: SKNode)
```

# SpriteEssence (class)

In order to maximise reuse of elements you should avoid maintaining state in the element where possible.

If maintaining per node state is necessary for the behaviour you are implementing you can use the SpriteEssence class to maintain additional state for your element unique to the node the element is currently handling in a type safe manner.

# Example

Any SKSpriteNode with this element attached will progressively change colour as it collides with other nodes that have the same attached element.  You can see this in action in the example project.

```swift
import Foundation
import SpriteKit

class ColourElement : SpriteElement {
    
    let hue = SpriteEssence<CGFloat>()
    
    func didAttach(toNode node: SKNode, inScene scene: SpriteElementScene) {
        node.physicsBody?.contactTestBitMask = 1;
    }
    
    func didBegin(contact: SKPhysicsContact, node: SKNode) {
        if let h = hue[node] {
            hue[node] = h + 0.05
        }
        else {
            hue[node] = 0
        }
        
        if let spriteNode = node as? SKSpriteNode, let h = hue[node] {
            if h > 0.9 {
                hue[node] = 0
            }
            
            spriteNode.color = UIColor(hue: h, saturation: 1, brightness: 0.9, alpha: 1)
        }
    }
    
}
```
