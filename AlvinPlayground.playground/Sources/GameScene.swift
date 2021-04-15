import Foundation
import SpriteKit

public class GameScene: SKScene, SKPhysicsContactDelegate {

    var player: PlayerNode!
    var inventoryView: InventoryView?
    var door: DoorNode?
    var gold: MaterialNode?
    var lithium: MaterialNode?
    var aluminium: MaterialNode?
    var cobalt: MaterialNode?
    var sceneSize: CGSize
    
    var inventory: [String] = []
    var isInventoryOpen: Bool = false
    
    var level = 1
    var totalRaws = 0
    
    public override init(size: CGSize) {
        sceneSize = size
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMove(to view: SKView) {
        backgroundColor = .darkGray
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -5.0)
        physicsWorld.contactDelegate = self
        
        door = DoorNode(size: CGSize(width: 130, height: 100), sceneSize: sceneSize)
        
        self.addChild(FloorNode(size: sceneSize))
        self.addChild(CeilingNode(size: sceneSize))
        
        setupLevel()
        setupInventoryButton()
    }
    
    func setupLevel() {
        door?.removeFromParent()
        player = PlayerNode()
        self.addChild(player)
        
        let initialY: CGFloat = (self.view?.bounds.height)!
        
        if level == 1 {
            totalRaws = 4
            lithium = MaterialNode(
                nodeName: "Lithium",
                size: CGSize(width: 65, height: 65),
                position: CGPoint(x: 100, y: initialY - (65 / 2))
            )
            self.addChild(lithium!)
            
            gold = MaterialNode(
                nodeName: "Gold",
                size: CGSize(width: 85, height: 60),
                position: CGPoint(x: (frame.size.width / 2) - 30, y: initialY - (60 / 2) + 10)
            )
            self.addChild(gold!)
            
            aluminium = MaterialNode(
                nodeName: "Aluminium",
                size: CGSize(width: 85, height: 60),
                position: CGPoint(x: (frame.size.width / 2) + 100, y: (60 / 2) + 140),
                physicBody: false
            )
            self.addChild(aluminium!)
            
            cobalt = MaterialNode(
                nodeName: "Cobalt",
                size: CGSize(width: 60, height: 65),
                position: CGPoint(x: frame.size.width - 140, y: initialY - (65 / 2))
            )
            self.addChild(cobalt!)
        }
    }
    
    func setupInventoryButton() {
        let inventoryButton = InventoryImageButton(frame: CGRect(x: 20, y: (self.view?.frame.height)! - 60, width: 40, height: 40))
        inventoryButton.addTarget(self, action: #selector(inventoryButtonAction), for: .touchUpInside)
        self.view?.addSubview(inventoryButton)
    }
    
    @objc func inventoryButtonAction(sender : UIButton) {
        if inventoryView?.isDescendant(of: self.view!) == true {
            inventoryView?.removeFromSuperview()
            isInventoryOpen = false
        } else {
            setupInventory()
            isInventoryOpen = true
        }
    }
    
    func setupInventory() {
        inventoryView = InventoryView(frame: CGRect(x: (self.view?.bounds.midX)!, y: (self.view?.bounds.midX)!, width: 500, height: 400), pInventory: inventory)
        inventoryView?.center = self.view!.center
        self.view?.addSubview(inventoryView!)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        if inventoryView == nil || inventoryView?.isDescendant(of: self.view!) == false {
            checkTouchedNode(location)
        }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let touchedNode = self.nodes(at: location)
        
        if inventoryView == nil || inventoryView?.isDescendant(of: self.view!) == false {
            for node in touchedNode {
                if ((node.name?.contains("Raw")) == true) {
                    return
                }
            }
            player.movePlayer(location, frame)
        }
    }
    
    func checkTouchedNode(_ location: CGPoint) {
        let touchedNode = self.nodes(at: location)
        for node in touchedNode {
            if ((node.name?.contains("Lithium")) == true) {
                lithium?.hitWithPickaxed()
            }
            if ((node.name?.contains("Gold")) == true) {
                gold?.hitWithPickaxed()
            }
            if ((node.name?.contains("Aluminium")) == true) {
                aluminium?.hitWithPickaxed()
            }
            if ((node.name?.contains("Cobalt")) == true) {
                cobalt?.hitWithPickaxed()
            }
        }
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Player" && ((contact.bodyB.node?.name?.contains("Material")) == true) {
            collisionBetween(player: contact.bodyA.node!, material: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "Player" && ((contact.bodyA.node?.name?.contains("Material")) == true){
            collisionBetween(player: contact.bodyB.node!, material: contact.bodyA.node!)
        }
        
        if contact.bodyA.node?.name == "Player" && ((contact.bodyB.node?.name?.contains("Door")) == true) {
            collisionBetween(player: contact.bodyA.node!, door: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "Player" && ((contact.bodyA.node?.name?.contains("Door")) == true){
            collisionBetween(player: contact.bodyB.node!, door: contact.bodyA.node!)
        }
    }
    
    func collisionBetween(player: SKNode, material: SKNode) {
        material.removeFromParent()
        inventory.append(material.name!)
        self.player.jumpPlayer()
        
        totalRaws -= 1
        if totalRaws == 0 {
            self.addChild(door!)
        }
    }
    
    func collisionBetween(player: SKNode, door: SKNode) {
        player.removeFromParent()
        level += 1
        setupLevel()
    }
}

