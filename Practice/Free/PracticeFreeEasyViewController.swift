//
//  PracticeFreeEasyViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/03.
//

import UIKit
import AVFoundation
import RealmSwift

class PracticeFreeEasyViewController: UIViewController ,ButtonTapDelegate, AVAudioPlayerDelegate ,CancelTapDelegate{

    
    
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!
    
    @IBOutlet weak var cancelBarView: CancelBarView!
    
    @IBOutlet weak var jokyoButton: UIButton!
    var player : AVAudioPlayer!
    
    var quizName : String!
    var quizType : Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        jokyoButton.isEnabled = false
        underBar.delegate = self
        writeTopBar()
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
    
    @IBAction func countryButton(_ sender: Any) {
        quizName = "country"
        quizType = 4
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
        self.performSegue(withIdentifier: "Segue", sender: nil)
    }
    
    @IBAction func sportButton(_ sender: Any) {
        quizName = "sport"
        quizType = 4
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
        self.performSegue(withIdentifier: "Segue", sender: nil)
    }
    
    @IBAction func cookButton(_ sender: Any) {
        quizName = "cook"
        quizType = 4
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
        self.performSegue(withIdentifier: "Segue", sender: nil)
    }
    
    @IBAction func circumstanceButton(_ sender: Any) {
//        状況
        quizName = "circumstance"
        quizType = 3
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
        self.performSegue(withIdentifier: "Segue", sender: nil)
    }
    
    @IBAction func occupationButton(_ sender: Any) {
//        職業
        quizName = "occupation"
        quizType = 4
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
        self.performSegue(withIdentifier: "Segue", sender: nil)
    }

    
    //    値渡し
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "Segue") {
                let NCViewController = segue.destination as! PracticeExplanationViewController
                NCViewController.quizName = quizName
                NCViewController.quizType = quizType
            }
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
//    アンダーバーに書き込み
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
        self.dismiss(animated: true, completion: nil)
    }
}
