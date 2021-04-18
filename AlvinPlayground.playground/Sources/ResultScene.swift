import PlaygroundSupport
import Foundation
import SpriteKit

public class ResultScene: SKScene {
    
    public override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMove(to view: SKView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.backgroundColor = .white
            
            let phoneImage = UIImageView()
            phoneImage.image = UIImage(named: "Phone")
            self.view?.addSubview(phoneImage)
            phoneImage.centerYAnchor.constraint(equalTo: self.view!.centerYAnchor).isActive = true
            phoneImage.leadingAnchor.constraint(equalTo: self.view!.leadingAnchor, constant: 50).isActive = true
            phoneImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
            phoneImage.heightAnchor.constraint(equalToConstant: 320).isActive = true
            phoneImage.translatesAutoresizingMaskIntoConstraints = false
            
            let heading = UILabel()
            heading.text = "You Obtained"
            self.view?.addSubview(heading)
            heading.topAnchor.constraint(equalTo: self.view!.topAnchor, constant: 30).isActive = true
            heading.leadingAnchor.constraint(equalTo: phoneImage.trailingAnchor, constant: 25).isActive = true
            heading.translatesAutoresizingMaskIntoConstraints = false
            
            let comLabel = UILabel()
            comLabel.font = UIFont.boldSystemFont(ofSize: 21)
            comLabel.text = "Communication Tool"
            self.view?.addSubview(comLabel)
            comLabel.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 15).isActive = true
            comLabel.leadingAnchor.constraint(equalTo: phoneImage.trailingAnchor, constant: 25).isActive = true
            comLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let mobLabel = UILabel()
            mobLabel.text = "Mobile Phone"
            self.view?.addSubview(mobLabel)
            mobLabel.topAnchor.constraint(equalTo: comLabel.bottomAnchor, constant: 5).isActive = true
            mobLabel.leadingAnchor.constraint(equalTo: phoneImage.trailingAnchor, constant: 25).isActive = true
            mobLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let descLabel = UILabel()
            descLabel.numberOfLines = 0
            descLabel.textAlignment = .justified
            descLabel.font = UIFont.systemFont(ofSize: 14)
            descLabel.text = "Mobile phone is a wireless handheld device that allows users to make and receive calls. While the earliest generation of mobile phones could only make and receive calls, today’s mobile phones do a lot more, accommodating web browsers, games, cameras, video players, navigational systems and social media. \n\nMobile phone has become basic human need that almost everyone has. Various people use mobile phone to communicate and exchange information. Therefore, as the users, we must be wise in using it. For example, instead of spreading hate or false information, we can use it to broaden our knowledge and connection, hone skills and develop ourselves."
            self.view?.addSubview(descLabel)
            descLabel.topAnchor.constraint(equalTo: mobLabel.bottomAnchor, constant: 25).isActive = true
            descLabel.leadingAnchor.constraint(equalTo: phoneImage.trailingAnchor, constant: 25).isActive = true
            descLabel.trailingAnchor.constraint(equalTo: self.view!.trailingAnchor, constant: -25).isActive = true
            descLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let button = UIButton()
            button.setTitle("Play Again", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.titleLabel?.textColor = .white
            button.backgroundColor = .systemYellow
            button.layer.masksToBounds = true
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 2.0
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
            self.view?.addSubview(button)
            button.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 25).isActive = true
            button.leadingAnchor.constraint(equalTo: phoneImage.trailingAnchor, constant: 25).isActive = true
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
            button.heightAnchor.constraint(equalToConstant: 45).isActive = true
            button.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @objc func buttonAction(sender: UIButton) {
        for view in self.view!.subviews {
            view.removeFromSuperview()
        }
        self.view?.stopBgSound()
        let scene = StartScene(size: self.frame.size)
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        self.view?.presentScene(scene, transition: transition)
    }
}
