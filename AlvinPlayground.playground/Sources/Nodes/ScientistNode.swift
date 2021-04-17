import Foundation
import SpriteKit

public class ScientistNode: SKNode {
    
    public init(physicBody: Bool = false) {
        super.init()
        let scientist = SKSpriteNode(imageNamed: "Scientist")
        scientist.name = "Scientist"
        scientist.position = CGPoint(x: 100, y: 70)
        scientist.size = CGSize(width: 50, height: 50)
        if physicBody {
            scientist.physicsBody = SKPhysicsBody(rectangleOf: scientist.size)
            scientist.physicsBody?.allowsRotation = false
            scientist.physicsBody?.affectedByGravity = true
            scientist.physicsBody!.contactTestBitMask = scientist.physicsBody!.collisionBitMask
        }
        addChild(scientist)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
