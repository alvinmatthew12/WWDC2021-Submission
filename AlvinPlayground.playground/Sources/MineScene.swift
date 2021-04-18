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
    var matListView = MaterialListView()
    var matListButton: MaterialListImageButton?
    let obtainedLabel = UILabel()
    var obtainedTimer = Timer()
    
    var sceneSize: CGSize
    var inventory: [String] = []
    
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
        setupMatListButton()
        
        obtainedLabel.text = "👇🏻 You obtained new material"
        obtainedLabel.textColor = .white
        obtainedLabel.isHidden = true
        self.view?.addSubview(obtainedLabel)
        obtainedLabel.leadingAnchor.constraint(equalTo: self.view!.leadingAnchor, constant: 25).isActive = true
        obtainedLabel.bottomAnchor.constraint(equalTo: self.view!.bottomAnchor, constant: -80).isActive = true
        obtainedLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func showObtainedLabel() {
        obtainedLabel.isHidden = false
        obtainedTimer.invalidate()
        obtainedTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: { (timer) in
            self.obtainedLabel.isHidden = true
        })
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
        } else {
            setupInventory()
        }
    }
    
    func setupInventory() {
        inventoryView = InventoryView(frame: CGRect(x: (self.view?.bounds.midX)!, y: (self.view?.bounds.midX)!, width: 500, height: 400), pInventory: inventory)
        inventoryView?.center = self.view!.center
        self.view?.addSubview(inventoryView!)
    }
    
    func setupMatListButton() {
        matListButton = MaterialListImageButton(frame: CGRect(x: 80, y: (self.view?.frame.height)! - 60, width: 40, height: 40))
        matListButton!.addTarget(self, action: #selector(matListButtonAction), for: .touchUpInside)
        self.view?.addSubview(matListButton!)
    }
    
    
    @objc func matListButtonAction(sender : UIButton) {
        if matListView.isDescendant(of: self.view!) == true {
            matListView.removeFromSuperview()
        } else {
            setupMatList()
        }
    }
    
    func setupMatList() {
        matListView = MaterialListView(frame: CGRect(x: (self.view?.bounds.midX)!, y: (self.view?.bounds.midX)!, width: 300, height: 400))
        matListView.center = self.view!.center
        self.view?.addSubview(matListView)
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
            if  !matListView.isDescendant(of: self.view!) {
                for node in touchedNode {
                    if ((node.name?.contains("Raw")) == true) {
                        return
                    }
                }
                player.movePlayer(location, frame)
            }
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
        showObtainedLabel()
        totalRaws -= 1
        if totalRaws == 0 {
            self.addChild(door!)
        }
    }
    
    func collisionBetween(player: SKNode, door: SKNode) {
        player.removeFromParent()
        level += 1
        if level > 2 {
            for view in self.view!.subviews {
                view.removeFromSuperview()
            }
            let scene = EndScene(size: self.frame.size, inventory: self.inventory)
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            self.view?.presentScene(scene, transition: transition)
        } else {
            setupLevel()
        }
    }
}

