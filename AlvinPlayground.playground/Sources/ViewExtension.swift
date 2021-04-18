import UIKit
import AVFoundation

var bgSoundURI: URL?
var bgAudioPlayer = AVAudioPlayer()

extension UIView {
    func playBgSound(){
        bgSoundURI = URL(fileURLWithPath: Bundle.main.path(forResource: "BGM", ofType: "mp3") ?? "")
        do {
            guard let uri = bgSoundURI else {return}
            bgAudioPlayer = try AVAudioPlayer(contentsOf: uri)
            bgAudioPlayer.numberOfLoops = -1
            bgAudioPlayer.play()
        } catch {
            print("Can't play BGM")
        }
    }
    
    func stopBgSound() {
        bgAudioPlayer.stop()
    }
}
