//
//  StartMovieViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/10.
//

import UIKit
import AVFoundation
import RealmSwift

class StartMovieViewController: UIViewController , AVAudioPlayerDelegate{
    
    var player : AVAudioPlayer!

    @IBOutlet weak var animationImage: UIImageView!
    @IBOutlet weak var titleImage: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
    }

    @IBAction func StartButton(_ sender: Any) {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = Float(0.1 * SoundData!.Effect ?? 1)
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
        startAdventureBGM()
        self.performSegue(withIdentifier: "Segue", sender: nil)
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
        
    }




}
