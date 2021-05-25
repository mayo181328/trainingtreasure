//
//  PracticeFinishedViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/03.

import UIKit
import RealmSwift
import AVFoundation

class PracticeFinishedViewController: UIViewController ,AVAudioPlayerDelegate,ButtonTapDelegate{
    
    var answerPoint : Int = 0
    var totalQuiz : Int!
    var nowCoin : Int!
    var QuizNumber : Int!
    
    var player : AVAudioPlayer!
    
    var quizName : String!
    var quizType : Int!
    var storyMode = false
    
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!
    
    @IBOutlet weak var PointLabel: UILabel!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var getLabel: UILabel!
    @IBOutlet weak var storyNextButton: UIButton!
    @IBOutlet weak var againButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    
    override func viewDidLoad() {
        if storyMode == true {
            topBar.isHidden = true
            underBar.isHidden = true
            cancelButton.isHidden = true
            againButton.isHidden = true
            
        }else if storyMode == false {
            underBar.delegate = self
            writeTopBar()
            storyNextButton.isHidden = true
        }
        super.viewDidLoad()
 
//        得点を表示
        let calc1 = 40 * answerPoint/(totalQuiz + 1)
        let score = calc1 + 60
        PointLabel.text = String(score)
        
        //        得点に応じてテキストを表示
                if score >= 100 {
                    messageImage.image = UIImage(named: "Perfect")
                }else if score >= 90 {
                    messageImage.image = UIImage(named: "FANTASTIC")
                }else if score >= 80 {
                    messageImage.image = UIImage(named: "GREAT")
                } else if score >= 70 {
                    messageImage.image = UIImage(named: "Nice")
                } else if score <= 69{
                    messageImage.image = UIImage(named: "Good")
                }  else {
                    print("error")
                }
        
        get()
        
        getLabel.text = "\(String(answerPoint))Coinと\(String(answerPoint))Pointの経験値を手に入れた"
        
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
    
    @IBAction func AgainButton(_ sender: Any) {
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
        if quizType == 3{
            self.performSegue(withIdentifier: "Segue3", sender: nil)
        }else if quizType == 4 {
            self.performSegue(withIdentifier: "Segue4", sender: nil)
        }
    }
    
    //    値渡し
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "Segue3") {
                let NCViewController = segue.destination as! FreeQuiz3QuestionViewController
                NCViewController.quizName = quizName
                NCViewController.quizType = quizType
            }else if (segue.identifier == "Segue4") {
                let NCViewController = segue.destination as! FreeQuiz4QuestionViewController
                NCViewController.quizName = quizName
                NCViewController.quizType = quizType
            } else if (segue.identifier == "StorySegue") {
                let NCViewController = segue.destination as! PracticeWordQuestionViewController
                NCViewController.storyMode = storyMode
            }
        }
    func get()  {
        let realm = try! Realm()
        var nextData = Player()
        
        
        let newData = realm.objects(Player.self).last

        
        try! realm.write {
            newData?.MyCoin = newData!.MyCoin + answerPoint * 3
            newData?.MyScore = newData!.MyScore + answerPoint
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
    try!realm.write{
        playerData!.MySystemNumber = playerData!.MySystemNumber + 1
    }
        self.performSegue(withIdentifier: "StorySegue", sender: nil)
    }
}

