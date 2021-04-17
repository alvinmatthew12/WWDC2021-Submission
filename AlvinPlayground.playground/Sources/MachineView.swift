import UIKit

// MARK:- InventoryView

public class MachineView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    public var inventory: [String] = []
    
    let invCollectionViewContainer = UIView()
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let symbolLabel = UILabel()
    let atomicNumLabel = UILabel()
    var invCollectionView: UICollectionView!
    let inventoryContainer = UIView()
    var selectedInventoryItem: String?
    
    let machineContainer = UIView()
    let constructButton = MachineButton(label: "Construct")
    let transferAllButton = MachineButton(label: "Transfer All")
    let transferButton = MachineButton(label: "Transfer")
    let goldItem = MachineItemView(name: "Gold", imageName: "GoldMaterial")
    let lithiumItem = MachineItemView(name: "Lithium", imageName: "LithiumMaterial")
    let silverItem = MachineItemView(name: "Silver", imageName: "SilverMaterial")
    let copperItem = MachineItemView(name: "Copper", imageName: "CopperMaterial")
    let aluminiumItem = MachineItemView(name: "Aluminium", imageName: "AluminiumMaterial")
    let leadItem = MachineItemView(name: "Lead", imageName: "LeadMaterial")
    let nickelItem = MachineItemView(name: "Nickel", imageName: "NickelMaterial")
    let cobaltItem = MachineItemView(name: "Cobalt", imageName: "CobaltMaterial")
    let plasticItem = MachineItemView(name: "Plastic", imageName: "PlasticMaterial")
    
    var itemReady: Int = 0
    
    public init(frame: CGRect, pInventory: [String]) {
        super.init(frame: frame)
        for i in 0...9 {
            if pInventory.indices.contains(i) {
                inventory.append(pInventory[i])
            } else {
                inventory.append("")
            }
        }
        setupInventory()
        setupMachine()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup Inventory
    
    func setupInventory() {
        inventoryContainer.backgroundColor = .white
        inventoryContainer.layer.masksToBounds = true
        inventoryContainer.layer.borderColor = UIColor.systemYellow.cgColor
        inventoryContainer.layer.borderWidth = 2.0
        inventoryContainer.layer.cornerRadius = 10
        self.addSubview(inventoryContainer)
        inventoryContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        inventoryContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        inventoryContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        inventoryContainer.widthAnchor.constraint(equalToConstant: 160).isActive = true
        inventoryContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let title = UILabel()
        title.text = "Inventory"
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textColor = .black
        inventoryContainer.addSubview(title)
        title.topAnchor.constraint(equalTo: inventoryContainer.topAnchor, constant: 20).isActive = true
        title.leadingAnchor.constraint(equalTo: inventoryContainer.leadingAnchor, constant: 20).isActive = true
        title.translatesAutoresizingMaskIntoConstraints = false
        
        invCollectionViewContainer.backgroundColor = .lightGray
        inventoryContainer.addSubview(invCollectionViewContainer)
        invCollectionViewContainer.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15).isActive = true
        invCollectionViewContainer.leadingAnchor.constraint(equalTo: inventoryContainer.leadingAnchor, constant: 20).isActive = true
        invCollectionViewContainer.trailingAnchor.constraint(equalTo: inventoryContainer.trailingAnchor, constant: -20).isActive = true
        invCollectionViewContainer.heightAnchor.constraint(equalToConstant: 120).isActive = true
        invCollectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        
        let imageViewContainer = UIView()
        imageViewContainer.backgroundColor = .lightGray
        inventoryContainer.addSubview(imageViewContainer)
        imageViewContainer.topAnchor.constraint(equalTo: invCollectionViewContainer.bottomAnchor, constant:15).isActive = true
        imageViewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        imageViewContainer.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageViewContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        inventoryContainer.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor, constant: 5).isActive = true
        imageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor, constant: 5).isActive = true
        imageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: -5).isActive = true
        imageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: -5).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let shortDescContainer = UIView()
        shortDescContainer.backgroundColor = .white
        inventoryContainer.addSubview(shortDescContainer)
        shortDescContainer.topAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: 15).isActive = true
        shortDescContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        shortDescContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        shortDescContainer.heightAnchor.constraint(equalToConstant: 65).isActive = true
        shortDescContainer.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        inventoryContainer.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: shortDescContainer.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: shortDescContainer.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: shortDescContainer.trailingAnchor).isActive = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        symbolLabel.textColor = .black
        symbolLabel.font = UIFont.systemFont(ofSize: 13)
        inventoryContainer.addSubview(symbolLabel)
        symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3).isActive = true
        symbolLabel.leadingAnchor.constraint(equalTo: shortDescContainer.leadingAnchor).isActive = true
        symbolLabel.trailingAnchor.constraint(equalTo: shortDescContainer.trailingAnchor).isActive = true
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        
        atomicNumLabel.textColor = .black
        atomicNumLabel.font = UIFont.systemFont(ofSize: 13)
        inventoryContainer.addSubview(atomicNumLabel)
        atomicNumLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 3).isActive = true
        atomicNumLabel.leadingAnchor.constraint(equalTo: shortDescContainer.leadingAnchor).isActive = true
        atomicNumLabel.trailingAnchor.constraint(equalTo: shortDescContainer.trailingAnchor).isActive = true
        atomicNumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        transferButton.addTarget(self, action: #selector(transferButtonAction), for: .touchUpInside)
        inventoryContainer.addSubview(transferButton)
        transferButton.leadingAnchor.constraint(equalTo: inventoryContainer.leadingAnchor, constant: 20).isActive = true
        transferButton.trailingAnchor.constraint(equalTo: inventoryContainer.trailingAnchor, constant: -20).isActive = true
        transferButton.bottomAnchor.constraint(equalTo: inventoryContainer.bottomAnchor, constant: -20).isActive = true
        transferButton.centerXAnchor.constraint(equalTo: inventoryContainer.centerXAnchor).isActive = true
        transferButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        transferButton.translatesAutoresizingMaskIntoConstraints = false
        
        selectedInventoryItem = inventory[0]
        selectInventoryItem()
        setupCollectionView()
    }
    
    @objc func transferButtonAction(sender : UIButton) {
        if let item = selectedInventoryItem {
            let inventIndex = inventory.firstIndex(of: item)
            if let index = inventIndex {
                showMachineItemImage()
                inventory[index] = ""
                if index + 1 < 9 {
                    selectedInventoryItem = inventory[index + 1]
                    selectInventoryItem()
                }
                itemReady += 1
                if itemReady == 9 {
                    constructButton.isHidden = false
                    transferButton.removeFromSuperview()
                    transferAllButton.removeFromSuperview()
                    selectedInventoryItem = ""
                    selectInventoryItem()
                }
                invCollectionView.reloadData()
            }
        }
    }
    
    func showMachineItemImage() {
        if selectedInventoryItem == goldItem.imageView.restorationIdentifier {
            goldItem.imageView.isHidden = false
        } else if selectedInventoryItem == silverItem.imageView.restorationIdentifier {
            silverItem.imageView.isHidden = false
        } else if selectedInventoryItem == copperItem.imageView.restorationIdentifier {
            copperItem.imageView.isHidden = false
        } else if selectedInventoryItem == lithiumItem.imageView.restorationIdentifier {
            lithiumItem.imageView.isHidden = false
        } else if selectedInventoryItem == aluminiumItem.imageView.restorationIdentifier {
            aluminiumItem.imageView.isHidden = false
        } else if selectedInventoryItem == leadItem.imageView.restorationIdentifier {
            leadItem.imageView.isHidden = false
        } else if selectedInventoryItem == nickelItem.imageView.restorationIdentifier {
            nickelItem.imageView.isHidden = false
        } else if selectedInventoryItem == cobaltItem.imageView.restorationIdentifier {
            cobaltItem.imageView.isHidden = false
        } else if selectedInventoryItem == plasticItem.imageView.restorationIdentifier {
            plasticItem.imageView.isHidden = false
        }
    }
    
    func selectInventoryItem() {
        imageView.image = UIImage(named: selectedInventoryItem!)
        let materialsData = MaterialData().materials
        let filtered = materialsData.filter { $0.key == selectedInventoryItem! }
        if filtered.count > 0 {
            let mat = filtered[0]
            nameLabel.text = mat.name
            symbolLabel.text = "Symbol: \(mat.symbol)"
            atomicNumLabel.text = "Atomic Num: \(mat.atomicNumber)"
        } else {
            nameLabel.text = ""
            symbolLabel.text = ""
            atomicNumLabel.text = ""
        }
    }
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 39, height: 39)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1

        invCollectionView = UICollectionView(frame: invCollectionViewContainer.frame, collectionViewLayout: layout)
        invCollectionView.dataSource = self
        invCollectionView.delegate = self
        invCollectionView.register(InventoryCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        invCollectionViewContainer.addSubview(invCollectionView)
        invCollectionView.topAnchor.constraint(equalTo: invCollectionViewContainer.topAnchor).isActive = true
        invCollectionView.leadingAnchor.constraint(equalTo: invCollectionViewContainer.leadingAnchor).isActive = true
        invCollectionView.trailingAnchor.constraint(equalTo: invCollectionViewContainer.trailingAnchor).isActive = true
        invCollectionView.bottomAnchor.constraint(equalTo: invCollectionViewContainer.bottomAnchor).isActive = true
        invCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inventory.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! InventoryCollectionViewCell
        cell.backgroundColor = .lightGray
        
        let inventoryName = inventory[indexPath.item]
        cell.imageView?.image = UIImage(named: inventoryName)
        if inventoryName == selectedInventoryItem && inventoryName != "" {
            cell.backgroundColor = .systemTeal
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let inventoryName = inventory[indexPath.item]
        if inventoryName != "" {
            imageView.image = UIImage(named: inventoryName)
            selectedInventoryItem = inventoryName
            selectInventoryItem()
            collectionView.reloadData()
        }
    }
    
    
    //MARK:- Setup Machine
    
    func setupMachine() {
        machineContainer.backgroundColor = .white
        machineContainer.layer.masksToBounds = true
        machineContainer.layer.borderColor = UIColor.systemYellow.cgColor
        machineContainer.layer.borderWidth = 2.0
        machineContainer.layer.cornerRadius = 10
        self.addSubview(machineContainer)
        machineContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        machineContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        machineContainer.leadingAnchor.constraint(equalTo: inventoryContainer.trailingAnchor, constant: 15).isActive = true
        machineContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        machineContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let title = UILabel()
        title.text = "Machine"
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textColor = .black
        machineContainer.addSubview(title)
        title.topAnchor.constraint(equalTo: machineContainer.topAnchor, constant: 20).isActive = true
        title.leadingAnchor.constraint(equalTo: machineContainer.leadingAnchor, constant: 20).isActive = true
        title.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(goldItem)
        goldItem.topAnchor.constraint(equalTo: title.topAnchor, constant: 25).isActive = true
        goldItem.widthAnchor.constraint(equalToConstant: 30).isActive = true
        goldItem.heightAnchor.constraint(equalToConstant: 50).isActive = true
        goldItem.centerXAnchor.constraint(equalTo: machineContainer.centerXAnchor).isActive = true
        goldItem.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(lithiumItem)
        lithiumItem.topAnchor.constraint(equalTo: goldItem.bottomAnchor, constant: 10).isActive = true
        lithiumItem.widthAnchor.constraint(equalToConstant: 30).isActive = true
        lithiumItem.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lithiumItem.centerXAnchor.constraint(equalTo: machineContainer.centerXAnchor).isActive = true
        lithiumItem.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(silverItem)
        silverItem.topAnchor.constraint(equalTo: goldItem.bottomAnchor).isActive = true
        silverItem.widthAnchor.constraint(equalToConstant: 30).isActive = true
        silverItem.heightAnchor.constraint(equalToConstant: 50).isActive = true
        silverItem.trailingAnchor.constraint(equalTo: goldItem.leadingAnchor, constant: -30).isActive = true
        silverItem.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(copperItem)
        copperItem.topAnchor.constraint(equalTo: goldItem.bottomAnchor).isActive = true
        copperItem.widthAnchor.constraint(equalToConstant: 30).isActive = true
        copperItem.heightAnchor.constraint(equalToConstant: 50).isActive = true
        copperItem.leadingAnchor.constraint(equalTo: goldItem.trailingAnchor, constant: 30).isActive = true
        copperItem.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(leadItem)
        leadItem.topAnchor.constraint(equalTo: silverItem.bottomAnchor, constant: 20).isActive = true
        leadItem.widthAnchor.constraint(equalToConstant: 30).isActive = true
        leadItem.heightAnchor.constraint(equalToConstant: 50).isActive = true
        leadItem.trailingAnchor.constraint(equalTo: silverItem.leadingAnchor, constant: -30).isActive = true
        leadItem.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(aluminiumItem)
        aluminiumItem.topAnchor.constraint(equalTo: copperItem.bottomAnchor, constant: 20).isActive = true
        aluminiumItem.widthAnchor.constraint(equalToConstant: 30).isActive = true
        aluminiumItem.heightAnchor.constraint(equalToConstant: 50).isActive = true
        aluminiumItem.leadingAnchor.constraint(equalTo: copperItem.trailingAnchor, constant: 30).isActive = true
        aluminiumItem.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(nickelItem)
        nickelItem.topAnchor.constraint(equalTo: leadItem.bottomAnchor, constant: 20).isActive = true
        nickelItem.widthAnchor.constraint(equalToConstant: 30).isActive = true
        nickelItem.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nickelItem.leadingAnchor.constraint(equalTo: leadItem.trailingAnchor, constant: 30).isActive = true
        nickelItem.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(cobaltItem)
        cobaltItem.topAnchor.constraint(equalTo: aluminiumItem.bottomAnchor, constant: 20).isActive = true
        cobaltItem.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cobaltItem.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cobaltItem.trailingAnchor.constraint(equalTo: aluminiumItem.leadingAnchor, constant: -30).isActive = true
        cobaltItem.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(plasticItem)
        plasticItem.topAnchor.constraint(equalTo: nickelItem.bottomAnchor).isActive = true
        plasticItem.widthAnchor.constraint(equalToConstant: 30).isActive = true
        plasticItem.heightAnchor.constraint(equalToConstant: 50).isActive = true
        plasticItem.centerXAnchor.constraint(equalTo: machineContainer.centerXAnchor).isActive = true
        plasticItem.translatesAutoresizingMaskIntoConstraints = false
        
        constructButton.isHidden = true
        constructButton.addTarget(self, action: #selector(constructButtonAction), for: .touchUpInside)
        self.addSubview(constructButton)
        constructButton.centerXAnchor.constraint(equalTo: machineContainer.centerXAnchor).isActive = true
        constructButton.topAnchor.constraint(equalTo: lithiumItem.bottomAnchor, constant: 15).isActive = true
        constructButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        constructButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        constructButton.translatesAutoresizingMaskIntoConstraints = false
        
        transferAllButton.addTarget(self, action: #selector(transferAllButtonAction), for: .touchUpInside)
        machineContainer.addSubview(transferAllButton)
        transferAllButton.leadingAnchor.constraint(equalTo: machineContainer.leadingAnchor, constant: 20).isActive = true
        transferAllButton.bottomAnchor.constraint(equalTo: machineContainer.bottomAnchor, constant: -20).isActive = true
        transferAllButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        transferAllButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        transferAllButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func transferAllButtonAction(sender: UIButton) {
        itemReady = 9
        constructButton.isHidden = false
        transferButton.removeFromSuperview()
        transferAllButton.removeFromSuperview()
        inventory = []
        selectedInventoryItem = ""
        selectInventoryItem()
        for _ in 0...9 {
            inventory.append("")
        }
        goldItem.imageView.isHidden = false
        silverItem.imageView.isHidden = false
        copperItem.imageView.isHidden = false
        lithiumItem.imageView.isHidden = false
        aluminiumItem.imageView.isHidden = false
        leadItem.imageView.isHidden = false
        nickelItem.imageView.isHidden = false
        cobaltItem.imageView.isHidden = false
        plasticItem.imageView.isHidden = false
        invCollectionView.reloadData()
    }
    
    @objc func constructButtonAction(sender: UIButton) {
        constructionLoading()
    }
    
    func constructionLoading() {
        let loadingContainer = UIView()
        loadingContainer.backgroundColor = .gray
        loadingContainer.layer.cornerRadius = 10
        self.addSubview(loadingContainer)
        loadingContainer.centerXAnchor.constraint(equalTo: machineContainer.centerXAnchor).isActive = true
        loadingContainer.topAnchor.constraint(equalTo: lithiumItem.bottomAnchor, constant: 15).isActive = true
        loadingContainer.widthAnchor.constraint(equalToConstant: 140).isActive = true
        loadingContainer.heightAnchor.constraint(equalToConstant: 35).isActive = true
        loadingContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let loadingLabel = UILabel()
        loadingLabel.textColor = .white
        loadingLabel.text = "Constructing..."
        loadingContainer.addSubview(loadingLabel)
        loadingLabel.centerXAnchor.constraint(equalTo: loadingContainer.centerXAnchor).isActive = true
        loadingLabel.centerYAnchor.constraint(equalTo: loadingContainer.centerYAnchor).isActive = true
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
}


class MachineItemView: UIView {
    
    var imageView = UIImageView()
    
    public init(frame: CGRect = CGRect(x: 0, y: 0, width: 30, height: 50), name: String, imageName: String) {
        super.init(frame: frame)
        
        let imageContainer = UIView()
        imageContainer.backgroundColor = .systemGray
        self.addSubview(imageContainer)
        imageContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageContainer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        imageView.isHidden = true
        imageView.restorationIdentifier = imageName
        self.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor, constant: 3).isActive = true
        imageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor, constant: 3).isActive = true
        imageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: -3).isActive = true
        imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -3).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = name
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        self.addSubview(label)
        label.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 5).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MachineButton: UIButton {
    
    public init(label: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        
        self.setTitle(label, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel?.textColor = .white
        self.backgroundColor = .systemYellow
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
