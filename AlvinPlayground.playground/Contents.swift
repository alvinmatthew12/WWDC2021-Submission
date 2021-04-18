/*:
 # Welcome !
 Hello, I'm Alvin from Indonesia.
 
 This playground is a simple game to explore and learn about metals and minerals that used to power our phone. The purpose is to help students who like to play games while exploring general knowledge.
 
 
 ## How to Play
 * Tap anywhere to continue the conversation dialogs
 * Tap anywhere to move the player
 * Move the player to any object to interact
 * Tap list button to see the list
 * Tap bag button to see inventory
 * Tap the circle indicator to interact with the materials inside the mine
 * Happy Exploring
*/

import PlaygroundSupport
import SpriteKit

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
let scene = StartScene(size: sceneView.frame.size)
sceneView.ignoresSiblingOrder = true
sceneView.presentScene(scene)

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true
