import Foundation
import SpriteKit

public class MachineNode: SKNode {
    public init(size: CGSize, position: CGPoint) {
        super.init()
        let machine = SKSpriteNode(imageNamed: "Machine")
        machine.name = "Machine"
        machine.position = position
        machine.size = CGSize(width: size.width, height: size.height)
        machine.zPosition = 1
        machine.xScale = -1
        machine.physicsBody = SKPhysicsBody(rectangleOf: machine.size)
        machine.physicsBody?.isDynamic = false
        machine.physicsBody?.allowsRotation = false
        machine.physicsBody?.affectedByGravity = false
        addChild(machine)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
