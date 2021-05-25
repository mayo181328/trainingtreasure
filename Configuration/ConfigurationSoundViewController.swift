//
//  ConfigurationSoundViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/10.
//


import UIKit
import RealmSwift
import AVFoundation

class ConfigurationSoundViewController: UIViewController , AVAudioPlayerDelegate ,ButtonTapDelegate,CancelTapDelegate{
    
    var player : AVAudioPlayer!
    
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!
    
    @IBOutlet weak var cancelBarView: CancelBarView!
    
    @IBOutlet weak var BGMBig: UIButton!
    @IBOutlet weak var BGMSmall: UIButton!
    @IBOutlet weak var BGMMute: UIButton!
    
    @IBOutlet weak var EffectBig: UIButton!
    @IBOutlet weak var EffectSmall: UIButton!
    @IBOutlet weak var EffectMute: UIButton!
    
    @IBOutlet weak var VoiceBig: UIButton!
    @IBOutlet weak var VoiceSmall: UIButton!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        underBar.delegate = self
        writeTopBar()
        ButtonSet()
        writePreparationCancelBar()
        writeCancelBar()
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
    
    @IBAction func BGMBIGButton(_ sender: Any) {
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
        let realm = try!Realm()
        let SoundData = realm.objects(Player.self).last
        try!realm.write{
            SoundData?.BGM = 1.0
        }
        ButtonSet()
        viewDidLoad()
    }
    @IBAction func BGMSmallButton(_ sender: Any) {
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
        let realm = try!Realm()
        let SoundData = realm.objects(Player.self).last
        try!realm.write{
            SoundData?.BGM = 0.5
        }
        ButtonSet()
        viewDidLoad()
    }
    @IBAction func BGMMuteButton(_ sender: Any) {
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
        let realm = try!Realm()
        let SoundData = realm.objects(Player.self).last
        
        try!realm.write{
            SoundData?.BGM = 0.0
        }
        ButtonSet()
        viewDidLoad()
    }
    @IBAction func EffectBigButton(_ sender: Any) {
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
        let realm = try!Realm()
        let SoundData = realm.objects(Player.self).last
        
        try!realm.write{
            SoundData?.Effect = 1.0
        }
        ButtonSet()
        viewDidLoad()
    }
    @IBAction func EffectSmallButton(_ sender: Any) {
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
        let realm = try!Realm()
        let SoundData = realm.objects(Player.self).last
        
        try!realm.write{
            SoundData?.Effect = 0.5
        }
        ButtonSet()
        viewDidLoad()
    }
    @IBAction func EffectMutButton(_ sender: Any) {
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
        let realm = try!Realm()
        let SoundData = realm.objects(Player.self).last
        
        try!realm.write{
            SoundData?.Effect = 0.0
        }
        ButtonSet()
        viewDidLoad()
    }
    
    @IBAction func VoiceBigButton(_ sender: Any) {
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
        let realm = try!Realm()
        let SoundData = realm.objects(Player.self).last
        
        try!realm.write{
            SoundData?.Voice = 1.0
        }
        ButtonSet()
        viewDidLoad()
    }
    @IBAction func VoiceSmallButton(_ sender: Any) {
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
        let realm = try!Realm()
        let SoundData = realm.objects(Player.self).last
        
        try!realm.write{
            SoundData?.Voice = 0.5
        }
        ButtonSet()
        viewDidLoad()
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
        startMainBGM()
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
        self.present(NVController, animated: true, completion: nil)
    }
    func storyButtonTap() {
        startAdventureBGM()
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
        self.present(NVController, animated: true, completion: nil)
    }
    func homeButtonTap() {
        startMainBGM()
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
        self.present(NVController, animated: true, completion: nil)
    }
    func gachaButtonTap() {
        startMainBGM()
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
        self.present(NVController, animated: true, completion: nil)
    }
    
    func ButtonSet() {
        let realm = try!Realm()
        let SoundData = realm.objects(Player.self).last
        
        switch SoundData?.BGM {
        case 1:
            BGMBig.isEnabled = false
            BGMSmall.isEnabled = true
            BGMMute.isEnabled = true
        case 0.5:
            BGMBig.isEnabled = true
            BGMSmall.isEnabled = false
            BGMMute.isEnabled = true
        case 0:
            BGMBig.isEnabled = true
            BGMSmall.isEnabled = true
            BGMMute.isEnabled = false
        default:
            BGMBig.isEnabled = false
            BGMSmall.isEnabled = true
            BGMMute.isEnabled = true
        }
        
        switch SoundData?.Effect {
        case 1:
            EffectBig.isEnabled = false
            EffectSmall.isEnabled = true
            EffectMute.isEnabled = true
        case 0.5:
            EffectBig.isEnabled = true
            EffectSmall.isEnabled = false
            EffectMute.isEnabled = true
        case 0:
            EffectBig.isEnabled = true
            EffectSmall.isEnabled = true
            EffectMute.isEnabled = false
        default:
            EffectBig.isEnabled = false
            EffectSmall.isEnabled = true
            EffectMute.isEnabled = true
        }
        
        switch SoundData?.Voice {
        case 1:
            VoiceBig.isEnabled = false
            VoiceSmall.isEnabled = true
        case 0.5:
            VoiceBig.isEnabled = true
            VoiceSmall.isEnabled = false
        case 0:
            VoiceBig.isEnabled = true
            VoiceSmall.isEnabled = true
        default:
            VoiceBig.isEnabled = false
            VoiceSmall.isEnabled = true
        }
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
        self.performSegue(withIdentifier: "Segue", sender: nil)
    }
}
