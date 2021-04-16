import UIKit

public class DialogView: UIView {
    
    var dialogLabel = UILabel()
    var speaker1 = UILabel()
    var speaker2 = UILabel()
    var imageView1 = UIImageView()
    var imageView2 = UIImageView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = CGRect(x: 0, y: 0, width: 500, height: 350)
        
        self.addSubview(imageView1)
        imageView1.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView1.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView1.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -90).isActive = true
        imageView1.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        
        imageView2.transform = CGAffineTransform(scaleX: -1, y: 1)
        self.addSubview(imageView2)
        imageView2.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView2.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView2.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -90).isActive = true
        imageView2.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        
        let container = UIView()
        container.center.x = self.center.x
        container.backgroundColor = .white
        container.layer.masksToBounds = true
        container.layer.borderColor = UIColor.systemYellow.cgColor
        container.layer.borderWidth = 2.0
        container.layer.cornerRadius = 10
        self.addSubview(container)
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.heightAnchor.constraint(equalToConstant: 150).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        container.translatesAutoresizingMaskIntoConstraints = false
        
        speaker1.font = UIFont.boldSystemFont(ofSize: 18)
        container.addSubview(speaker1)
        speaker1.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        speaker1.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15).isActive = true
        speaker1.translatesAutoresizingMaskIntoConstraints = false
        
        speaker2.font = UIFont.boldSystemFont(ofSize: 18)
        container.addSubview(speaker2)
        speaker2.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        speaker2.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15).isActive = true
        speaker2.translatesAutoresizingMaskIntoConstraints = false
        
        dialogLabel.font = UIFont.systemFont(ofSize: 18)
        dialogLabel.numberOfLines = 0
        dialogLabel.textAlignment = .justified
        container.addSubview(dialogLabel)
        dialogLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 50).isActive = true
        dialogLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15).isActive = true
        dialogLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15).isActive = true
        dialogLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

