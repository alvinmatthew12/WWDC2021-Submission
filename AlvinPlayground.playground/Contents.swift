//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
let scene = GameScene(size: sceneView.frame.size)
sceneView.ignoresSiblingOrder = true
sceneView.showsFPS = true
sceneView.showsNodeCount = true

sceneView.presentScene(scene)

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true
