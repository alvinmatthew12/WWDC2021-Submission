import PlaygroundSupport
import Foundation
import SpriteKit

public class StartScene: SKScene, SKPhysicsContactDelegate {
    
    var background = SKSpriteNode(imageNamed: "OutsideBG")
    var player = PlayerNode()
    var scientist = ScientistNode()
    
    var sceneSize: CGSize
    
    public override init(size: CGSize) {
        sceneSize = size
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: -5.0)
        physicsWorld.contactDelegate = self
        
        background.zPosition = -1
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.isUserInteractionEnabled = false
        addChild(background)
        
        self.addChild(FloorNode(size: sceneSize))
        self.addChild(DoorNode(size: CGSize(width: 130, height: 100), sceneSize: sceneSize))
        self.addChild(player)
        
        scientist.position = CGPoint(x: 250, y: 100)
        scientist.xScale = -1
        self.addChild(scientist)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        player.movePlayer(location, frame)
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Player" && ((contact.bodyB.node?.name?.contains("Door")) == true) {
            collisionBetween(player: contact.bodyA.node!, door: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "Player" && ((contact.bodyA.node?.name?.contains("Door")) == true){
            collisionBetween(player: contact.bodyB.node!, door: contact.bodyA.node!)
        }
    }
    
    func collisionBetween(player: SKNode, door: SKNode) {
        player.removeFromParent()
        let scene = MineScene(size: self.frame.size)
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        self.view?.presentScene(scene, transition: transition)
    }
}
