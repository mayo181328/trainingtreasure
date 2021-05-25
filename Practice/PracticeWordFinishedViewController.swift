//
//  PracticeWordFinishedViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/11/23.
//

import UIKit
import RealmSwift
import AVFoundation

class PracticeWordFinishedViewController: UIViewController ,AVAudioPlayerDelegate,ButtonTapDelegate{
    
    var answerPoint : Int = 0
    var totalQuiz : Int!
    var nowCoin : Int!
    var CellIndex : IndexPath!
    var NextIndex : IndexPath!
    var quizBrain = WordQuiz()
    var QuizNumber : Int!
    var checkLastQuestionBool = false
    var storyMode = false
    
    var player : AVAudioPlayer!
    

    
    @IBOutlet weak var PointLabel: UILabel!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var getLabel: UILabel!
    
    @IBOutlet weak var weakButton: UIButton!
    @IBOutlet weak var againButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var storyNextButton: UIButton!
    
    
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if storyMode == true {
            topBar.isHidden = true
            underBar.isHidden = true
            NextButton.isHidden = true
            cancelButton.isHidden = true
            againButton.isHidden = true
            weakButton.isHidden = true
            
        }else if storyMode == false {
            underBar.delegate = self
            
            writeTopBar()
            weakBool()
            storyNextButton.isHidden = true
        }
        
//        得点を表示
        let calc1 = 40 * answerPoint/(totalQuiz + 1)
        let score = calc1 + 60
        PointLabel.text = String(score)
        
//        得点に応じてテキストを表示
        if score >= 100 {
            messageImage.image = UIImage(named: "Perfect")
        }else if score >= 85 {
            messageImage.image = UIImage(named: "Great")
        } else if score >= 70 {
            messageImage.image = UIImage(named: "Nice")
        } else if score <= 69{
            messageImage.image = UIImage(named: "Good")
        }  else {
            print("error")
        }
        
        get()
        
        getLabel.text = "\(String(answerPoint))Coinと\(String(answerPoint))Pointの経験値を手に入れた"
        
        
        if checkLastQuestionBool == true {
            NextButton.isEnabled = false
        } else {
            NextButton.isEnabled = true
        }
        

        
    }
    @IBAction func backButton(_ sender: Any) {
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
            self.performSegue(withIdentifier: "BackSegue", sender: nil)
        
    }
    
    @IBAction func weakButton(_ sender: Any) {
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
        self.performSegue(withIdentifier: "WeakSegue", sender: nil)
    }
    
    
    @IBAction func AgainButton(_ sender: Any) {
        self.performSegue(withIdentifier: "AgainSegue", sender: nil)
    }
    
    @IBAction func toNextButton(_ sender: Any) {
        QuizNumber = CellIndex.row
        QuizNumber += 1
        NextIndex = CellIndex
        NextIndex.row = QuizNumber
        
        self.performSegue(withIdentifier: "NextSegue", sender: nil)

    }
    
    //    値渡し
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "AgainSegue") {
                let NCViewController = segue.destination as! PracticeWordQuestionViewController
                NCViewController.CellIndex = CellIndex
            } else if (segue.identifier == "NextSegue") {
                let NCViewController = segue.destination as! PracticeWordQuestionViewController
                NCViewController.CellIndex = NextIndex
            }else if (segue.identifier == "StorySegue") {
                let NCViewController = segue.destination as! PracticeExplanationViewController
                NCViewController.storyMode = storyMode
            }
        }

    
    
    
    func get()  {
        let realm = try! Realm()
        let newData = realm.objects(Player.self).last
        try! realm.write {
            newData?.MyCoin = newData!.MyCoin + answerPoint * 2
            newData?.MyScore = newData!.MyScore + answerPoint 
        }
    }
    
    //        苦手配列に値がない場合
    func weakBool(){
        let realm = try!Realm()
        let weakData = realm.objects(Player.self).last?.weakList
        if weakData?.last == nil {
            weakButton.isEnabled = false
        } else  {
            weakButton.isEnabled = true
        }
    }
    //    トップバーに書き込む関数
       func writeTopBar() {
        let realm = try!Realm()
        let playerData = realm.objects(Player.self)
        
        let myLevel = playerData.last!.MyScore  / 10
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
        
    @IBAction func storyNextButton(_ sender: Any) {
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

        let realm = try! Realm()
        let playerData = realm.objects(Player.self).last
        if playerData!.MySystemNumber >= 5 {
            try!realm.write{
                playerData!.MySystemNumber = 1
            }
            self.performSegue(withIdentifier: "EndingSegue", sender: nil)
        } else if playerData!.MySystemNumber <= 4{
        try!realm.write{
            playerData?.MySystemNumber = playerData!.MySystemNumber + 1
        }
        self.performSegue(withIdentifier: "StorySegue", sender: nil)
        }
    }
}
