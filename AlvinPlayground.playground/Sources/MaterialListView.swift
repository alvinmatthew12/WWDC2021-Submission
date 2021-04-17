import UIKit

public class MaterialListImageButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: 40, height: 40)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        self.setImage(UIImage(named: "List"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

public class MaterialListView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    let list: [String] = ["Gold", "Silver", "Copper", "Lithium", "Plastic", "Nickel", "Cobalt", "Lead", "Aluminium"]
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.systemYellow.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 10
        
        let title = UILabel()
        title.text = "Material List"
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
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        self.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(MaterialListItemCell.self, forCellReuseIdentifier: "Cell")
    }
    
    @objc func close(sender: UIButton) {
        self.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MaterialListItemCell
        if list[indexPath.row] == "Plastic" {
            cell.rawImage.image = UIImage(named: "\(list[indexPath.row])Material")
            cell.label.text = list[indexPath.row]
            cell.pickaxeImage.isHidden = true
        } else {
            cell.rawImage.image = UIImage(named: "\(list[indexPath.row])Raw")
            cell.materialImage.image = UIImage(named: "\(list[indexPath.row])Material")
            cell.label.text = list[indexPath.row]
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

class MaterialListItemCell: UITableViewCell {
    
    var rawImage = UIImageView()
    var materialImage = UIImageView()
    var label = UILabel()
    let pickaxeImage = UIImageView()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    
        rawImage.contentMode = .scaleAspectFit
        self.addSubview(rawImage)
        rawImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        rawImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        rawImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        rawImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rawImage.translatesAutoresizingMaskIntoConstraints = false
        
        pickaxeImage.image = UIImage(named: "Pickaxe (1)")
        pickaxeImage.contentMode = .scaleAspectFit
        self.addSubview(pickaxeImage)
        pickaxeImage.leadingAnchor.constraint(equalTo: rawImage.trailingAnchor, constant: 15).isActive = true
        pickaxeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pickaxeImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        pickaxeImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
        pickaxeImage.translatesAutoresizingMaskIntoConstraints = false
        pickaxeImage.image = UIImage(named: "Pickaxe (1)")
        
        materialImage.contentMode = .scaleAspectFit
        self.addSubview(materialImage)
        materialImage.leadingAnchor.constraint(equalTo: pickaxeImage.trailingAnchor, constant: 15).isActive = true
        materialImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        materialImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        materialImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        materialImage.translatesAutoresizingMaskIntoConstraints = false
        
        label.textAlignment = .right
        self.addSubview(label)
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
