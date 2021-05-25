//
//  HomeShopViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/11/23.
//

import UIKit
import AVFoundation
import RealmSwift

class HomeShopViewController: UIViewController , AVAudioPlayerDelegate,ButtonTapDelegate ,CancelTapDelegate{
    
    var player : AVAudioPlayer!
    
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!
    
    @IBOutlet weak var cancelBarView: CancelBarView!
    
    var shopName : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        underBar.delegate = self
        writePreparationCancelBar()
        writeCancelBar()
        writeTopBar()
        cancelBarView.delegate = self
    }
    
    var messageArrayPreparation = [String]()
    func writePreparationCancelBar(){
        cancelBarView.Label.text = "Tips"
        for _ in 0...10 {
        let random = Int.random(in: 0...MessageArray.count - 1)
        for i2 in MessageArray[random]{
        messageArrayPreparation.append(i2)
            }
        }
    }
    var messageNumber = 0
    func writeCancelBar(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if self.messageNumber < 10 {
            self.cancelBarView.Label.text = self.messageArrayPreparation[self.messageNumber]
                self.writeCancelBar()
                self.messageNumber += 1
            }else if self.messageNumber == 10 {
                self.cancelBarView.Label.text = "いかりを10回押すと…!?"
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        BGMplayer.stop()
        startBGM()
    }    
    
    @IBAction func ShopHeadButton(_ sender: Any) {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = Float(0.1 * SoundData!.Effect )
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
        shopName = "head"
        self.performSegue(withIdentifier: "Segue", sender: nil)
    }
    
    @IBAction func ShopBodyButton(_ sender: Any) {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = Float(0.1 * SoundData!.Effect )
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
        shopName = "body"
        self.performSegue(withIdentifier: "Segue", sender: nil)
        
    }
    
    //    値渡し
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "Segue") {
                let NCViewController = segue.destination as! HomeShopHeadViewController
                NCViewController.shopName = shopName
            }
        }
    
    
    func startBGM(){
//                BGM
                let url = Bundle.main.bundleURL.appendingPathComponent("wearBGM.mp3")
                        do {
                            try BGMplayer = AVAudioPlayer(contentsOf: url)
                            BGMplayer.volume = 0.05
                        } catch {
                            print("Error")
                        }
                        BGMplayer!.play()
                        BGMplayer!.numberOfLoops = -1
    }
    
    //    トップバーに書き込む関数
       func writeTopBar() {
        let realm = try!Realm()
        let playerData = realm.objects(Player.self)
        
        let myLevel = playerData.last!.MyScore  / 10
        
        topBar.LevelLabel.text = "Lv.\(myLevel)"
        topBar.NameLabel.text = String(playerData.last?.MyName ?? "名前がありません")
        topBar.coinLabel.text = String(playerData.last?.MyCoin ?? 0)
        topBar.JewelLabel.text = String(playerData.last?.MyJewel ?? 0)
        topBar.StageLabel.text = String(playerData.last?.MyStage ?? "Japan")
        }
    func practiceButtonTap() {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = Float(0.1 * SoundData!.Effect )
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
        let NVController = self.storyboard?.instantiateViewController(withIdentifier: "PracticeViewController") as! PracticeViewController
        NVController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        NVController.modalPresentationStyle = .fullScreen
        startMainBGM()
        self.present(NVController, animated: true, completion: nil)
    }
    func storyButtonTap() {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = Float(0.1 * SoundData!.Effect )
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
        let NVController = self.storyboard?.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController
        NVController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        NVController.modalPresentationStyle = .fullScreen
        startAdventureBGM()
        self.present(NVController, animated: true, completion: nil)
    }
    func homeButtonTap() {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = Float(0.1 * SoundData!.Effect )
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
        let NVController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        NVController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        NVController.modalPresentationStyle = .fullScreen
        startMainBGM()
        self.present(NVController, animated: true, completion: nil)
    }
    func gachaButtonTap() {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = Float(0.1 * SoundData!.Effect )
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
        let NVController = self.storyboard?.instantiateViewController(withIdentifier: "GachaViewController") as! GachaViewController
        NVController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        NVController.modalPresentationStyle = .fullScreen
        startMainBGM()
        self.present(NVController, animated: true, completion: nil)
    }
    
    func startMainBGM(){
//                BGM
                let url = Bundle.main.bundleURL.appendingPathComponent("mainBGM.mp3")
        do {
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            try BGMplayer = AVAudioPlayer(contentsOf: url)
            BGMplayer.volume = Float(0.05 * SoundData!.BGM)
        } catch {
            print("Error")
        }
        BGMplayer!.play()
        BGMplayer!.numberOfLoops = -1
    }
    
    func startAdventureBGM(){
//                BGM
                let url = Bundle.main.bundleURL.appendingPathComponent("adventureBGM.mp3")
                        do {
                            let realm = try!Realm()
                            let SoundData = realm.objects(Player.self).last
                            try BGMplayer = AVAudioPlayer(contentsOf: url)
                            BGMplayer.volume = Float(0.05 * SoundData!.BGM)
                        } catch {
                            print("Error")
                        }
                        BGMplayer!.play()
                        BGMplayer!.numberOfLoops = -1
    }

    func CancelButtonTap() {
        let soundURL  = Bundle.main.url(forResource: "cancel", withExtension: "mp3")
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
        self.performSegue(withIdentifier: "BackSegue", sender: nil)
    }
}
