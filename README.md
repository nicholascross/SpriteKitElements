# SpriteKitElements
A small swift framework for attaching additional functionality to any SKNode with out the need to sub class.  This means you can design your scene in Xcode and attach reusable behaviours to any SKNode such as SKLightNode, SKEmitterNode, etc

This should be considered experimental, as I am yet to submit a game based on the framework, so there could performance or other limitations in the current version.  Hopefully if people start using this any issues will come to light and can be resolved.  If you would like a more battle tested mechanism I would recommend you check out SpriteKit-Components, I have used this before and it works well and has some features this library will not have such as touch handling.

## Design Goal

1. Simplicity
2. Flexability

It should be a simple matter of implementing only the protocol methods you wish to handle then attaching that element to any number of nodes in your scene.

Node sub classing has been avoided because it would not allow direct attachments to custom node types with out extending each one individually.  Additionally the scene builder in Xcode does not allow custom classes to be specified making the sub classing approach unusable in conjunction.

## Future consideration

1. Stability
2. Performace
3. Swiftness

Stability and performance improvements will be on going and as necessary.

This framework currently uses Objective-C concepts to support optional protocol method implementation and the memory-managment/clean-up makes use of associated objects.  That doesn't seem very swift like but for the sake of simplicity I have chosen to use these concepts for now.

Proposals of alternate approaches are very welcome!

# SpriteElementScene (class)

You must use the custom `SKScene` sub class `SpriteElementScene` but you can attach elements to any SKNode without sub classing.

You can attach an element to a node in your scene using the `func attachElement(element: SpriteElement, toNode node: SKNode)` method of `SpriteElementScene`

# SpriteElement (protocol)

Implement any of the optional methods in this interface to perform specific actions on a node during the scene life cycle.

```swift
	//Called when an element is first attached to a node
    optional func didAttach(node: SKNode, inScene scene:SpriteElementScene)
    
    //Called during scene update, delta is the time since the last scene update
    optional func update(currentTime: NSTimeInterval, delta: NSTimeInterval, node: SKNode)

    optional func didEvaluateActions(node: SKNode)

    optional func didSimulatePhysics(node: SKNode)

    optional func didApplyConstraints(node: SKNode)

    optional func didFinishUpdate(node: SKNode)

    optional func didMoveToView(view: SKView!, node: SKNode)

    optional func willMoveFromView(view: SKView!, node: SKNode)

    optional func didChangeSize(oldSize: CGSize, node: SKNode)
    
    optional func didBeginContact(contact: SKPhysicsContact, node: SKNode)
    
    optional func didEndContact(contact: SKPhysicsContact, node: SKNode)
```

# SpriteEssence (class)

In order to maximise reuse of elements you should avoid maintaining state in the element where possible.

If maintaining per node state is necessary for the behaviour you are implementing you can use the SpriteEssence class to maintain additional state for your element unique to the node the element is currently handling in a type safe manner.

# Example

Any SKSpriteNode with this element attached will progressively change colour as it collides with other nodes that have the same attached element.  You can see this in action in the example project.

```swift
import Foundation
import SpriteKit

@objc class ColourElement : SpriteElement {
    
    let hue = SpriteEssence<CGFloat>()
    
    func didAttach(node: SKNode, inScene scene: SpriteElementScene) {
        node.physicsBody?.contactTestBitMask = 1;
    }
    
    func didBeginContact(contact: SKPhysicsContact, node: SKNode) {
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
