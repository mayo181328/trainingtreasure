//
//  StartupViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/10.
//

import UIKit
import RealmSwift
import AVFoundation

class StartupViewController: UIViewController ,AVAudioPlayerDelegate{
    
    var player : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        tutorialBool()
    }
    
    func tutorialBool() {
        let realm = try!Realm()
        let playerData = realm.objects(Player.self).last
        if playerData == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.performSegue(withIdentifier: "TSegue", sender: nil)
            }
            
        } else if playerData != nil{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.performSegue(withIdentifier: "Segue", sender: nil)
            }
        } else{
            print("Error")
        }
    }

}
