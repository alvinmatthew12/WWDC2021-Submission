import Foundation
import SpriteKit

public class DoorNode: SKNode {
    public init(size: CGSize, sceneSize: CGSize) {
        super.init()
        let door = SKSpriteNode(imageNamed: "Door")
        door.name = "Door"
        door.position = (CGPoint(x: sceneSize.width - 20, y:  (size.height / 2) + 140))
        door.size = CGSize(width: size.width, height: size.height)
        door.zPosition = 1
        door.physicsBody = SKPhysicsBody(rectangleOf: door.size)
        door.physicsBody?.isDynamic = false
        door.physicsBody?.allowsRotation = false
        door.physicsBody?.affectedByGravity = false
        addChild(door)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
