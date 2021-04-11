import Foundation
import SpriteKit
//
//public class Stone: SKNode {
//
//    private var pickaxeTextures: [SKTexture] = []
//    private var pickaxe = SKSpriteNode()
//    private var stone = SKSpriteNode()
//    private var imageName: String = ""
//    
//    public init(imageName: String, stoneSize: CGSize, stonePos: CGPoint) {
//        super.init()
//        
//        self.imageName = imageName
//        
//        pickaxe.position = CGPoint(x: stonePos.x + 20, y: stonePos.y - 5)
//        pickaxe.size = CGSize(width: 40, height: 40)
//        pickaxe.zPosition = 2
//        addChild(pickaxe)
//        
//        for i in 1...5 {
//            pickaxeTextures.append(SKTexture(imageNamed: "Pickaxe (\(i))"))
//        }
//        
//        stone.texture = SKTexture(imageNamed: "\(imageName)s")
//        stone.name = imageName
//        stone.position = stonePos
//        stone.size = stoneSize
//        stone.zPosition = 1
//        stone.isUserInteractionEnabled = true
//        stone.physicsBody = SKPhysicsBody(rectangleOf: stone.size)
//        stone.physicsBody?.affectedByGravity = false
//        stone.physicsBody!.contactTestBitMask = stone.physicsBody!.collisionBitMask
//        addChild(stone)
//    }
//    
//    public required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func animatePickaxed() {
//        pickaxe.run(SKAction.repeatForever(SKAction.animate(with: pickaxeTextures, timePerFrame: 0.1)), withKey: "pickaxed")
//    }
//    
//    func stoneAnimateEnded() {
//        pickaxe.removeAllActions()
//    }
//    
//    public func hitStone() {
//        stone.isUserInteractionEnabled = false
//        if pickaxe.action(forKey: "pickaxed") == nil {
//            animatePickaxed()
//        }
//        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { [self] (time) in
//            stoneAnimateEnded()
//            pickaxe.removeFromParent()
//            transformToMaterial()
//        })
//    }
//    
//    public func transformToMaterial() {
//        stone.texture = SKTexture(imageNamed: imageName)
//        stone.size = CGSize(width: 30, height: 20)
//        stone.isUserInteractionEnabled = false
//        stone.physicsBody = SKPhysicsBody(rectangleOf: stone.size)
//        stone.physicsBody?.affectedByGravity = true
//    }
//}
