import Foundation
import SpriteKit

public class MaterialNode: SKNode {

    private var pickaxeTextures: [SKTexture] = []
    private var pickaxe = SKSpriteNode()
    private var material = SKSpriteNode()
    private var indicator = SKShapeNode()
    private var nodeName: String = ""
    
    public init(nodeName: String, size: CGSize, position: CGPoint, physicBody: Bool = true, skipRaw: Bool = false) {
        super.init()
        
        self.nodeName = nodeName
        
        pickaxe.position = CGPoint(x: position.x + 20, y: position.y - 5)
        pickaxe.size = CGSize(width: 40, height: 40)
        pickaxe.zPosition = 3
        addChild(pickaxe)
        
        for i in 1...5 {
            pickaxeTextures.append(SKTexture(imageNamed: "Pickaxe (\(i))"))
        }
        
        material.texture = SKTexture(imageNamed: "\(nodeName)Raw")
        material.name = "\(nodeName)Raw"
        material.position = position
        material.size = size
        material.zPosition = 1
        material.isUserInteractionEnabled = true
        if(physicBody) {
            material.physicsBody = SKPhysicsBody(rectangleOf: material.size)
            material.physicsBody?.affectedByGravity = false
            material.physicsBody!.contactTestBitMask = material.physicsBody!.collisionBitMask
            material.physicsBody?.affectedByGravity = false
        }
        addChild(material)
        
        indicator.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 20, height: 20), cornerRadius: 50).cgPath
        indicator.position = CGPoint(x: material.position.x - 10, y: material.position.y - 10)
        indicator.fillColor = UIColor.lightGray
        indicator.strokeColor = UIColor.gray
        indicator.lineWidth = 2
        indicator.zPosition = 2
        indicator.alpha = 0.7
        addChild(indicator)
        
        if skipRaw {
            indicator.removeFromParent()
            transformToMaterial()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animatePickaxed() {
        pickaxe.run(SKAction.repeatForever(SKAction.animate(with: pickaxeTextures, timePerFrame: 0.1)), withKey: "pickaxed")
        indicator.removeFromParent()
    }
    
    func stoneAnimateEnded() {
        pickaxe.removeAllActions()
    }
    
    public func hitWithPickaxed() {
        material.isUserInteractionEnabled = false
        if pickaxe.action(forKey: "pickaxed") == nil {
            animatePickaxed()
        }
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { [self] (time) in
            stoneAnimateEnded()
            pickaxe.removeFromParent()
            transformToMaterial()
        })
    }
    
    public func transformToMaterial() {
        material.isUserInteractionEnabled = false
        material.zPosition = 3
        material.name = "\(nodeName)Material"
        material.texture = SKTexture(imageNamed: "\(nodeName)Material")
        material.size = CGSize(width: 30, height: 20)
        material.physicsBody = SKPhysicsBody(rectangleOf: material.size)
        material.physicsBody?.affectedByGravity = true
    }
}
