//
//  PracticeViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/11/23.
//

import UIKit
import RealmSwift
import AVFoundation

var BGMplayer : AVAudioPlayer!


class PracticeViewController: UIViewController, AVAudioPlayerDelegate ,ButtonTapDelegate{
    
    
    
    var player : AVAudioPlayer!

    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!
    
    
    @IBOutlet weak var weakButton: UIButton!
    
    var AVplayer : AVAudioPlayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        underBar.delegate = self
        writeTopBar()
        weakBool()
    }

    
    
    @IBAction func FreeButton(_ sender: Any) {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            AVplayer = try AVAudioPlayer(contentsOf: soundURL!)
            AVplayer.volume = Float(0.1 * SoundData!.Effect)
            AVplayer.delegate = self
            AVplayer?.play()
        }catch{
            print(error)
        }
        self.performSegue(withIdentifier: "SegueF", sender: nil)
    }
    
    @IBAction func WeakButton(_ sender: Any) {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            AVplayer = try AVAudioPlayer(contentsOf: soundURL!)
            AVplayer.volume = Float(0.1 * SoundData!.Effect)
            AVplayer.delegate = self
            AVplayer?.play()
        }catch{
            print(error)
        }
        self.performSegue(withIdentifier: "SegueWeak", sender: nil)
    }
    
    @IBAction func WordButton(_ sender: Any) {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            AVplayer = try AVAudioPlayer(contentsOf: soundURL!)
            AVplayer.volume = Float(0.1 * SoundData!.Effect)
            AVplayer.delegate = self
            AVplayer?.play()
        }catch{
            print(error)
        }
        self.performSegue(withIdentifier: "SegueW", sender: nil)
    }
    
        
//    トップバーに書き込む関数
   func writeTopBar() {
    let realm = try!Realm()
    realm.objects(Player.self)
    let playerData = realm.objects(Player.self)
    

    
    var myLevel = playerData.last!.MyScore  / 10
    print(playerData.last!.MyScore  / 10,playerData.last!.MyScore)
    
    topBar.LevelLabel.text = "Lv.\(myLevel)"
    topBar.NameLabel.text = String(playerData.last?.MyName ?? "名前がありません")
    topBar.coinLabel.text = String(playerData.last?.MyCoin ?? 0)
    topBar.JewelLabel.text = String(playerData.last?.MyJewel ?? 0)
    topBar.StageLabel.text = String(playerData.last?.MyStage ?? "Japan")
    }
    //        苦手配列に値がない場合
    func weakBool(){
        let realm = try!Realm()
        realm.objects(Player.self)
        let weakData = realm.objects(Player.self).last?.weakList
        if weakData?.last == nil {
            weakButton.isEnabled = false
        } else  {
            weakButton.isEnabled = true
        }
    }
    
    
    func practiceButtonTap() {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = Float(0.1 * SoundData!.Effect)
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
        let NVController = self.storyboard?.instantiateViewController(withIdentifier: "PracticeViewController") as! PracticeViewController
        NVController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        NVController.modalPresentationStyle = .fullScreen
        self.present(NVController, animated: true, completion: nil)
    }
    func storyButtonTap() {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = Float(0.1 * SoundData!.Effect)
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
        let NVController = self.storyboard?.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController
        NVController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        NVController.modalPresentationStyle = .fullScreen
        self.present(NVController, animated: true, completion: nil)
    }
    func homeButtonTap() {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = Float(0.1 * SoundData!.Effect)
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
        let NVController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        NVController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        NVController.modalPresentationStyle = .fullScreen
        self.present(NVController, animated: true, completion: nil)
    }
    func gachaButtonTap() {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = Float(0.1 * SoundData!.Effect)
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
        let NVController = self.storyboard?.instantiateViewController(withIdentifier: "GachaViewController") as! GachaViewController
        NVController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        NVController.modalPresentationStyle = .fullScreen
        self.present(NVController, animated: true, completion: nil)
    }
    
}
