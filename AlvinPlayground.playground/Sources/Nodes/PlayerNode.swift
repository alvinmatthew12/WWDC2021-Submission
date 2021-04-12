import Foundation
import SpriteKit

public class PlayerNode: SKNode {
    
    private var playerWalkTextures: [SKTexture] = []
    private var playerJumpTextures: [SKTexture] = []
    private var player = SKSpriteNode()
    
    public override init() {
        super.init()
        player = SKSpriteNode(imageNamed: "Player")
        player.name = "Player"
        player.position = CGPoint(x: 100, y: 100)
        player.size = CGSize(width: 50, height: 50)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody!.contactTestBitMask = player.physicsBody!.collisionBitMask
        player.zPosition = 15
        addChild(player)
        
        for i in 1...5 {
            playerWalkTextures.append(SKTexture(imageNamed: "Walk (\(i))"))
        }
        
        for i in 1...7 {
            playerJumpTextures.append(SKTexture(imageNamed: "Jump (\(i))"))
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animatePlayerWalk() {
        player.run(SKAction.repeatForever(SKAction.animate(with: playerWalkTextures, timePerFrame: 0.1)), withKey: "walkingPlayer")
    }
    
    func animatePlayerJump() {
        let jumpAction = SKAction.animate(with: playerJumpTextures, timePerFrame: 0.1)
        let doneAction = SKAction.run({ [weak self] in
            self?.playerMoveEnded()
        })
        let sequence = SKAction.sequence([jumpAction, doneAction])
        player.run(sequence)
    }

    func playerMoveEnded() {
        player.removeAllActions()
        player.texture = SKTexture(imageNamed: "Player")
    }
    
    public func jumpPlayer() {
        animatePlayerJump()
    }

    public func movePlayer(_ location: CGPoint, _ frame: CGRect) {
        var multiplierForDirection: CGFloat
        let playerSpeed = frame.size.width / 3.0

        let moveDifference = CGPoint(x: location.x - player.position.x, y: player.position.y) // player.position.y
        let distanceToMove = sqrt(moveDifference.x * moveDifference.x) //  + moveDifference.y * moveDifference.y

        let moveDuration = distanceToMove / playerSpeed
        if location.x > player.frame.midX {
            multiplierForDirection = 1.0
        } else {
            multiplierForDirection = -1.0
        }
        player.xScale = abs(player.xScale) * multiplierForDirection
        if player.action(forKey: "walkingPlayer") == nil {
            animatePlayerWalk()
        }
        
        let moveAction = SKAction.moveTo(x: location.x, duration:(TimeInterval(moveDuration)))
        let doneAction = SKAction.run({ [weak self] in
            self?.playerMoveEnded()
        })

        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        player.run(moveActionWithDone, withKey:"playerMoving")
    }
}
