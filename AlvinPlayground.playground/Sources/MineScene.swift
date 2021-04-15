import Foundation
import SpriteKit

public class MineScene: SKScene, SKPhysicsContactDelegate {

    var player: PlayerNode!
    var inventoryView: InventoryView?
    var door: DoorNode?
    var gold: MaterialNode?
    var lithium: MaterialNode?
    var aluminium: MaterialNode?
    var cobalt: MaterialNode?
    var silver: MaterialNode?
    var plastic: MaterialNode?
    var copper: MaterialNode?
    var lead: MaterialNode?
    var nickel: MaterialNode?
    
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
            
        } else if level == 2 {
            totalRaws = 5
            silver = MaterialNode(
                nodeName: "Silver",
                size: CGSize(width: 85, height: 60),
                position: CGPoint(x: 100, y: initialY - (60 / 2))
            )
            self.addChild(silver!)
            
            plastic = MaterialNode(
                nodeName: "Plastic",
                size: CGSize(width: 30, height: 20),
                position: CGPoint(x: 200, y: (20 / 2) + 100),
                physicBody: false,
                skipRaw: true
            )
            self.addChild(plastic!)
            
            copper = MaterialNode(
                nodeName: "Copper",
                size: CGSize(width: 85, height: 60),
                position: CGPoint(x: (frame.size.width / 2) + 100, y: (60 / 2) + 125),
                physicBody: false
            )
            self.addChild(copper!)
            
            lead = MaterialNode(
                nodeName: "Lead",
                size: CGSize(width: 85, height: 60),
                position: CGPoint(x: (frame.size.width / 2) - 30, y: initialY - (60 / 2) + 10)
            )
            self.addChild(lead!)
            
            nickel = MaterialNode(
                nodeName: "Nickel",
                size: CGSize(width: 60, height: 65),
                position: CGPoint(x: frame.size.width - 140, y: initialY - (65 / 2))
            )
            self.addChild(nickel!)
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
            if ((node.name?.contains("Silver")) == true) {
                silver?.hitWithPickaxed()
            }
            if ((node.name?.contains("Copper")) == true) {
                copper?.hitWithPickaxed()
            }
            if ((node.name?.contains("Lead")) == true) {
                lead?.hitWithPickaxed()
            }
            if ((node.name?.contains("Nickel")) == true) {
                nickel?.hitWithPickaxed()
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

