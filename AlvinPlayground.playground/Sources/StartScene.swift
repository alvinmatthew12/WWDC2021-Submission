import PlaygroundSupport
import Foundation
import SpriteKit

public class StartScene: SKScene, SKPhysicsContactDelegate {
    
    var background = SKSpriteNode(imageNamed: "OutsideBG")
    var player = PlayerNode()
    var scientist = ScientistNode()
    var dialogView = DialogView()
    var startButton = UIButton()
    var matListView = MaterialListView()
    var matListButton: MaterialListImageButton?
    
    var sceneSize: CGSize
    var isCanMove = false
    var dialogId = 0
    
    public override init(size: CGSize) {
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
        self.addChild(DoorNode(size: CGSize(width: 130, height: 100), sceneSize: sceneSize))
        self.addChild(player)
        
        scientist.position = CGPoint(x: 250, y: 100)
        scientist.xScale = -1
        self.addChild(scientist)
        
        startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 180, height: 75))
        startButton.center = self.view!.center
        startButton.center.y = self.view!.center.y - 30
        startButton.setTitle("START", for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        startButton.titleLabel?.textColor = .white
        startButton.backgroundColor = .systemYellow
        startButton.layer.masksToBounds = true
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.layer.borderWidth = 2.0
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view?.addSubview(self.startButton)
        }
    }
    
    @objc func startButtonAction(sender : UIButton) {
        startButton.removeFromSuperview()
        setupDialog()
    }
    
    func setupDialog() {
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
        if dialogId <= 4 {
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
            isCanMove = true
            setupMatListButton()
            setupMatList()
        }
    }
    
    func setupMatListButton() {
        matListButton = MaterialListImageButton(frame: CGRect(x: 20, y: (self.view?.frame.height)! - 60, width: 40, height: 40))
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
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        if dialogView.isDescendant(of: self.view!) {
            emitDialogs()
        }
        if isCanMove && !matListView.isDescendant(of: self.view!) {
            if matListView.isDescendant(of: self.view!) == false {
                player.movePlayer(location, frame)
            }
        }
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Player" && ((contact.bodyB.node?.name?.contains("Door")) == true) {
            collisionBetween(player: contact.bodyA.node!, door: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "Player" && ((contact.bodyA.node?.name?.contains("Door")) == true){
            collisionBetween(player: contact.bodyB.node!, door: contact.bodyA.node!)
        }
    }
    
    func collisionBetween(player: SKNode, door: SKNode) {
        player.removeFromParent()
        for view in self.view!.subviews {
            view.removeFromSuperview()
        }
        let scene = MineScene(size: self.frame.size)
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        self.view?.presentScene(scene, transition: transition)
    }
}
