//
//  TutorialNamedViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/10.
//

import UIKit
import AVFoundation
import RealmSwift

class TutorialNamedViewController: UIViewController , AVAudioPlayerDelegate, UITextFieldDelegate{
    
    var player : AVAudioPlayer!
    
    @IBOutlet weak var namedText: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var avatarView: AvatarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namedText.delegate = self
        avatar()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // キーボードを閉じる
            textField.resignFirstResponder()
            return true
        }
    
    @IBAction func OkButton(_ sender: Any) {
        if namedText.text!.count >= 1 && namedText.text!.count <= 10 {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = 0.1
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
            let realm = try! Realm()
            let playerData = realm.objects(Player.self).last
        try!realm.write{
            playerData!.MyName = namedText.text!
        }
            self.performSegue(withIdentifier: "Segue", sender: nil)
        } else if namedText.text!.count == 0 {
            alertLabel.text = "名前を入力してください"
        }else if namedText.text!.count >= 11{
            alertLabel.text = "長すぎます"
        } else {
            print("error")
        }
        
        
    }
    func avatar() {
     let realm = try!Realm()
     let playerData = realm.objects(Player.self).last
     
     avatarView.skinImage.image = UIImage(named: (playerData?.MySkinNow) as! String)
     avatarView.eyeImage.image = UIImage(named: (playerData?.MyEyesNow) as! String)
     avatarView.mouthImage.image = UIImage(named: (playerData?.MyMouthNow)as! String)
     avatarView.bodyImage.image = UIImage(named: (playerData?.MyBodyNow)as! String)
     avatarView.headImage.image = UIImage(named: (playerData?.MyHeadNow)as! String)
     }

}
