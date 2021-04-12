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
