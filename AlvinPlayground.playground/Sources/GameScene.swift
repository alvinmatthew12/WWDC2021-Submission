import Foundation
import SpriteKit

public class GameScene: SKScene, SKPhysicsContactDelegate {

    let player = Player()
    var inventoryView: InventoryView?
    var goldStone: Stone?
    var lithiumStone: Stone?
    var sceneSize: CGSize
    
    var inventory: [String] = []
    var isInventoryOpen: Bool = false
    
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
        
        self.addChild(Floor(size: sceneSize))
        self.addChild(Ceiling(size: sceneSize))
        self.addChild(player)
        setupStones()
        setupInventoryButton()
    }
    
    func setupStones() {
        let initialY: CGFloat = (self.view?.bounds.height)!
        
        lithiumStone = Stone(
            imageName: "LithiumStone",
            stoneSize: CGSize(width: 65, height: 65),
            stonePos: CGPoint(x: 100, y: initialY - (65 / 2))
        )
        self.addChild(lithiumStone!)
        
        goldStone = Stone(
            imageName: "GoldStone",
            stoneSize: CGSize(width: 85, height: 60),
            stonePos: CGPoint(x: (frame.size.width / 2) - 30, y: initialY - (60 / 2) + 10)
        )
        self.addChild(goldStone!)
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
        
        if inventoryView == nil || inventoryView?.isDescendant(of: self.view!) == false {
            player.movePlayer(location, frame)
        }
    }
    
    func checkTouchedNode(_ location: CGPoint) {
        let touchedNode = self.nodes(at: location)
        for node in touchedNode {
            if node.name == "LithiumStone" {
                lithiumStone?.hitStone()
            }
            if node.name == "GoldStone" {
                goldStone?.hitStone()
            }
        }
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Player" && ((contact.bodyB.node?.name?.contains("Stone")) != nil) {
            collisionBetween(player: contact.bodyA.node!, stone: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "Player" && ((contact.bodyA.node?.name?.contains("Stone")) != nil){
            collisionBetween(player: contact.bodyB.node!, stone: contact.bodyA.node!)
        }
    }
    
    func collisionBetween(player: SKNode, stone: SKNode) {
        stone.removeFromParent()
        inventory.append(stone.name!)
        self.player.jumpPlayer()
    }
}


import UIKit

// MARK:- InventoryImageButton

public class InventoryImageButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: 40, height: 40)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        self.setImage(UIImage(named: "Bag"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- InventoryView

public class InventoryView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    public var inventory: [String] = []
    
    var collectionViewContainer = UIView()
    var imageViewContainer = UIView()
    var imageView = UIImageView()
    var shortDescContainer = UIView()
    var nameLabel = UILabel()
    var symbolLabel = UILabel()
    var atomicNumLabel = UILabel()
    var atomicMassLabel = UILabel()
    var descTextView = UITextView()
    var collectionView: UICollectionView!
    
    var selectedItems: String?
    
    public init(frame: CGRect, pInventory: [String]) {
        super.init(frame: frame)
        
        for i in 0...23 {
            if pInventory.indices.contains(i) {
                inventory.append(pInventory[i])
            } else {
                inventory.append("")
            }
        }
        
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.systemYellow.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 10
        
        let title = UILabel()
        title.text = "Inventory"
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textColor = .black
        self.addSubview(title)
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let closeButton = UIButton()
        closeButton.setTitle("Close [x]", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        closeButton.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        collectionViewContainer.backgroundColor = .lightGray
        self.addSubview(collectionViewContainer)
        collectionViewContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 56).isActive = true
        collectionViewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        collectionViewContainer.widthAnchor.constraint(equalToConstant: 120).isActive = true
        collectionViewContainer.heightAnchor.constraint(equalToConstant: 320).isActive = true
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        imageViewContainer.backgroundColor = .lightGray
        self.addSubview(imageViewContainer)
        imageViewContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 56).isActive = true
        imageViewContainer.leadingAnchor.constraint(equalTo: collectionViewContainer.trailingAnchor, constant: 20).isActive = true
        imageViewContainer.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageViewContainer.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor, constant: 5).isActive = true
        imageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor, constant: 5).isActive = true
        imageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: -5).isActive = true
        imageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: -5).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        shortDescContainer.backgroundColor = .white
        self.addSubview(shortDescContainer)
        shortDescContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 56).isActive = true
        shortDescContainer.leadingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: 15).isActive = true
        shortDescContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        shortDescContainer.widthAnchor.constraint(equalToConstant: 220).isActive = true
        shortDescContainer.heightAnchor.constraint(equalToConstant: 80).isActive = true
        shortDescContainer.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: shortDescContainer.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: shortDescContainer.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: shortDescContainer.trailingAnchor).isActive = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        symbolLabel.textColor = .black
        symbolLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(symbolLabel)
        symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3).isActive = true
        symbolLabel.leadingAnchor.constraint(equalTo: shortDescContainer.leadingAnchor).isActive = true
        symbolLabel.trailingAnchor.constraint(equalTo: shortDescContainer.trailingAnchor).isActive = true
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        
        atomicNumLabel.textColor = .black
        atomicNumLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(atomicNumLabel)
        atomicNumLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 3).isActive = true
        atomicNumLabel.leadingAnchor.constraint(equalTo: shortDescContainer.leadingAnchor).isActive = true
        atomicNumLabel.trailingAnchor.constraint(equalTo: shortDescContainer.trailingAnchor).isActive = true
        atomicNumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        atomicMassLabel.textColor = .black
        atomicMassLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(atomicMassLabel)
        atomicMassLabel.topAnchor.constraint(equalTo: atomicNumLabel.bottomAnchor, constant: 3).isActive = true
        atomicMassLabel.leadingAnchor.constraint(equalTo: shortDescContainer.leadingAnchor).isActive = true
        atomicMassLabel.trailingAnchor.constraint(equalTo: shortDescContainer.trailingAnchor).isActive = true
        atomicMassLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descTextView.backgroundColor = .lightGray
        descTextView.isEditable = false
        self.addSubview(descTextView)
        descTextView.topAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: 20).isActive = true
        descTextView.leadingAnchor.constraint(equalTo: collectionViewContainer.trailingAnchor, constant: 20).isActive = true
        descTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        descTextView.widthAnchor.constraint(equalToConstant: 330).isActive = true
        descTextView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        descTextView.translatesAutoresizingMaskIntoConstraints = false
        
        selectedItems = inventory[0]
        selectItem()
        
        setupCollectionView()
    }
    
    func selectItem() {
        imageView.image = UIImage(named: inventory[0])
        nameLabel.text = "Lithium"
        symbolLabel.text = "Symbol: Li"
        atomicNumLabel.text = "Atomic Number: 3"
        atomicMassLabel.text = "Atomic Mass: 6.941 u"
        descTextView.text = "DESCRIPTION\n\nLithium is also the first of the alkali metals - like its near kin sodium and potassium, it will react spontaneously to water, though not quite as violently as those other two.\n\nDESCRIPTION\n\nLithium is also the first of the alkali metals - like its near kin sodium and potassium, it will react spontaneously to water, though not quite as violently as those other two.\n\nDESCRIPTION\n\nLithium is also the first of the alkali metals - like its near kin sodium and potassium, it will react spontaneously to water, though not quite as violently as those other two."
    }
    
    @objc func close(sender: UIButton) {
        self.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 39, height: 39)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1

        collectionView = UICollectionView(frame: collectionViewContainer.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(InventoryCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionViewContainer.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: collectionViewContainer.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: collectionViewContainer.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: collectionViewContainer.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: collectionViewContainer.bottomAnchor).isActive = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inventory.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! InventoryCollectionViewCell
        cell.backgroundColor = .lightGray
        
        let inventoryName = inventory[indexPath.item]
        cell.imageView?.image = UIImage(named: inventoryName)
        if inventoryName == selectedItems && inventoryName != "" {
            cell.backgroundColor = .systemTeal
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let inventoryName = inventory[indexPath.item]
        if inventoryName != "" {
            self.imageView.image = UIImage(named: inventoryName)
            self.selectedItems = inventoryName
            self.collectionView.reloadData()
        }
    }
}

public class InventoryCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView?
    var label: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: self.bounds)
        imageView!.contentMode = .scaleAspectFit
        contentView.addSubview(imageView!)
        imageView!.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        imageView!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        imageView!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        imageView!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        imageView!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }
}

// MARK:- PlayerNode

public class Player: SKNode {
    
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

// MARK:- CeilingNode

public class Ceiling: SKNode {
    
    public init(size: CGSize) {
        super.init()
        let ceiling = SKSpriteNode(imageNamed: "Ceiling")
        let imageHeight: CGFloat = 137
        ceiling.position = (CGPoint(x: size.width / 2, y: (size.height + 10) - (imageHeight / 2)))
        ceiling.size = CGSize(width: size.width, height: imageHeight)
        ceiling.zPosition = -1
        addChild(ceiling)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK:- FloorNode

public class Floor: SKNode {
    
    public init(size: CGSize) {
        super.init()
        let floor = SKSpriteNode(imageNamed: "Floor")
        let imageHeight: CGFloat = 150
        floor.position = (CGPoint(x: size.width / 2, y: (imageHeight / 2)))
        floor.size = CGSize(width: size.width, height: imageHeight)
        floor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: floor.size.width, height: floor.size.height - 10))
        floor.physicsBody?.isDynamic = false
        floor.physicsBody?.allowsRotation = false
        floor.physicsBody?.affectedByGravity = false
        addChild(floor)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- StoneNode

public class Stone: SKNode {

    private var pickaxeTextures: [SKTexture] = []
    private var pickaxe = SKSpriteNode()
    private var stone = SKSpriteNode()
    private var imageName: String = ""
    
    public init(imageName: String, stoneSize: CGSize, stonePos: CGPoint) {
        super.init()
        
        self.imageName = imageName
        
        pickaxe.position = CGPoint(x: stonePos.x + 20, y: stonePos.y - 5)
        pickaxe.size = CGSize(width: 40, height: 40)
        pickaxe.zPosition = 2
        addChild(pickaxe)
        
        for i in 1...5 {
            pickaxeTextures.append(SKTexture(imageNamed: "Pickaxe (\(i))"))
        }
        
        stone.texture = SKTexture(imageNamed: "\(imageName)s")
        stone.name = imageName
        stone.position = stonePos
        stone.size = stoneSize
        stone.zPosition = 1
        stone.isUserInteractionEnabled = true
        stone.physicsBody = SKPhysicsBody(rectangleOf: stone.size)
        stone.physicsBody?.affectedByGravity = false
        stone.physicsBody!.contactTestBitMask = stone.physicsBody!.collisionBitMask
        addChild(stone)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animatePickaxed() {
        pickaxe.run(SKAction.repeatForever(SKAction.animate(with: pickaxeTextures, timePerFrame: 0.1)), withKey: "pickaxed")
    }
    
    func stoneAnimateEnded() {
        pickaxe.removeAllActions()
    }
    
    public func hitStone() {
        stone.isUserInteractionEnabled = false
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
        stone.texture = SKTexture(imageNamed: imageName)
        stone.size = CGSize(width: 30, height: 20)
        stone.isUserInteractionEnabled = false
        stone.physicsBody = SKPhysicsBody(rectangleOf: stone.size)
        stone.physicsBody?.affectedByGravity = true
    }
}
