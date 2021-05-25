//
//  TutorialStartupViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/10.
//

import UIKit
import RealmSwift
import AVFoundation

class TutorialStartupViewController: UIViewController {

    @IBOutlet weak var animationImage: UIImageView!
    @IBOutlet weak var titleImage: UIImageView!
    
    var animator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
        startAdventureBGM()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startAdventureBGM(){
//                BGM
                let url = Bundle.main.bundleURL.appendingPathComponent("adventureBGM.mp3")
                        do {
                            try BGMplayer = AVAudioPlayer(contentsOf: url)
                            BGMplayer.volume = 0.05
                        } catch {
                            print("Error")
                        }
                        BGMplayer!.play()
                        BGMplayer!.numberOfLoops = -1
    }

    func startAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        UIImageView.animate(withDuration: 10.0) { () -> Void in
            self.animationImage.frame = CGRect(origin: CGPoint(x: -45, y: 0), size: self.animationImage.bounds.size)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        UIImageView.animate(withDuration: 10.0) { () -> Void in
            self.titleImage.frame = CGRect(origin: CGPoint(x: 20, y: 490), size: self.titleImage.bounds.size)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.1) {
            self.performSegue(withIdentifier: "Segue", sender: nil)
        }
    }
}
