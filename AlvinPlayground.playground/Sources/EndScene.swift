import PlaygroundSupport
import Foundation
import SpriteKit

public class EndScene: SKScene, SKPhysicsContactDelegate, MachineProtocol {
    
    var background = SKSpriteNode(imageNamed: "OutsideBG")
    var player = PlayerNode()
    var scientist = ScientistNode(physicBody: true)
    var dialogView = DialogView()
    var inventoryView: InventoryView?
    var inventoryButton: InventoryImageButton?
    var machineView: MachineView?
    var matListView = MaterialListView()
    var matListButton: MaterialListImageButton?
    
    var sceneSize: CGSize
    var isCanMove = true
    var dialogId = 4
    
    var inventory: [String] = []
    
    public init(size: CGSize, inventory: [String] = []) {
        self.inventory = inventory
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
        self.addChild(MachineNode(size: CGSize(width: 60, height: 90), position: (CGPoint(x: frame.size.width - 130, y:  (90 / 2) + 140))))
        self.addChild(player)
        
        scientist.position = CGPoint(x: self.frame.size.width - 100, y: 100)
        scientist.xScale = -1
        self.addChild(scientist)
        
        setupInventoryButton()
        setupMatListButton()
    }
    
    func setupInventoryButton() {
        inventoryButton = InventoryImageButton(frame: CGRect(x: 20, y: (self.view?.frame.height)! - 60, width: 40, height: 40))
        inventoryButton!.addTarget(self, action: #selector(inventoryButtonAction), for: .touchUpInside)
        self.view?.addSubview(inventoryButton!)
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
    
    func setupMachine() {
        machineView = MachineView(frame: CGRect(x: (self.view?.bounds.midX)!, y: (self.view?.bounds.midX)!, width: 500, height: 400), pInventory: inventory)
        machineView?.center = self.view!.center
        machineView?.delegate = self
        self.view?.addSubview(machineView!)
    }
    
    func constructionFinish() {
        for view in self.view!.subviews {
            view.removeFromSuperview()
        }
        let scene = ResultScene(size: self.frame.size)
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        self.view?.presentScene(scene, transition: transition)
    }
    
    
    func setupDialog() {
        isCanMove = false
        dialogView.center = self.view!.center
        dialogView.isUserInteractionEnabled = true
        self.view?.addSubview(dialogView)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchDialogView))
        dialogView.addGestureRecognizer(tap)
        emitDialogs()
    }
    
    @objc func touchDialogView() {
        emitDialogs()
    }
    
    func emitDialogs() {
        dialogId += 1
        if dialogId <= 7 {
            let dialogData = DialogData().dialogs
            let filtered = dialogData.filter { $0.id == dialogId }
            if filtered.count > 0 {
                dialogView.dialogLabel.text = filtered[0].dialog
                dialogView.speaker1.text = filtered[0].speaker1
                dialogView.speaker2.text = filtered[0].speaker2
                dialogView.imageView1.image = UIImage(named: filtered[0].imageName1)
                dialogView.imageView2.image = UIImage(named: filtered[0].imageName2)
            }
        } else {
            dialogView.removeFromSuperview()
            setupMachine()
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        if dialogView.isDescendant(of: self.view!) {
            emitDialogs()
        }
        
        if inventoryView == nil || inventoryView?.isDescendant(of: self.view!) == false {
            if isCanMove && !matListView.isDescendant(of: self.view!) {
                player.movePlayer(location, frame)
            }
        }
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Player" && ((contact.bodyB.node?.name?.contains("Scientist")) == true) {
            collisionBetween(player: contact.bodyA.node!, scientist: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "Player" && ((contact.bodyA.node?.name?.contains("Scientist")) == true){
            collisionBetween(player: contact.bodyB.node!, scientist: contact.bodyA.node!)
        }
    }
    
    func collisionBetween(player: SKNode, scientist: SKNode) {
        player.removeAllActions()
        setupDialog()
    }
}
