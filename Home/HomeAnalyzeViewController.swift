//
//  HomeAnalyzeViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/27.
//

import UIKit
import RealmSwift
import AVFoundation

class HomeAnalyzeViewController: UIViewController , AVAudioPlayerDelegate,ButtonTapDelegate ,CancelTapDelegate{

    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!
    
    @IBOutlet weak var avatarView: AvatarView!
    
    
    @IBOutlet weak var cancelBarView: CancelBarView!
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var WordCountLabel: UILabel!
    @IBOutlet weak var ExerciseLabel: UILabel!
    
    @IBOutlet weak var ThinkingImage: UIImageView!
    @IBOutlet weak var JudgmentImage: UIImageView!
    @IBOutlet weak var LisningImage: UIImageView!
    @IBOutlet weak var BasicImage: UIImageView!
    @IBOutlet weak var AppliedImage: UIImageView!
    @IBOutlet weak var WordImage: UIImageView!
    
    @IBOutlet weak var RecommendLabel: UILabel!
    
    
    var ThinkingAnalyzeSum : Int = 0
    var JudgmentAnalyzeSum : Int = 0
    var LisningAnalyzeSum : Int = 0
    var BasicAnalyzeSum : Int = 0
    var AppliedAnalyzeSum : Int = 0
    var WordAnalyzeSum : Int = 0
    
    
    var player : AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        underBar.delegate = self
        writeTopBar()
        cancelBarView.delegate = self
        avatar()
        CountedSet()
        DataSet()
        ImageSet()
        RecommendSet()
    }
    
    func RecommendSet() {
        if WordAnalyzeSum < 50{
            RecommendLabel.text = "単語問題だ!!"
            return
        } else if BasicAnalyzeSum < 50{
            RecommendLabel.text = "Easy問題だ!!"
            return
        }else if JudgmentAnalyzeSum < 50{
            RecommendLabel.text = "料理問題だ!!"
            return
        }else if ThinkingAnalyzeSum < 50{
            RecommendLabel.text = "Normal問題だ!!"
            return
        }else if LisningAnalyzeSum < 50{
            RecommendLabel.text = "アクセント問題だ!!"
            return
        }else if AppliedAnalyzeSum < 50{
            RecommendLabel.text = "Hard問題だ!!"
            return
        }else if WordAnalyzeSum < 60{
            RecommendLabel.text = "単語問題だ!!"
            return
        } else if BasicAnalyzeSum < 60{
            RecommendLabel.text = "料理問題だ!!"
            return
        }else if JudgmentAnalyzeSum < 60{
            RecommendLabel.text = "スポーツ問題だ!!"
            return
        }else if ThinkingAnalyzeSum < 60{
            RecommendLabel.text = "食事問題だ!!"
            return
        }else if LisningAnalyzeSum < 60{
            RecommendLabel.text = "アクセント問題だ!!"
            return
        }else if AppliedAnalyzeSum < 60{
            RecommendLabel.text = "食事問題だ!!"
            return
        }else if WordAnalyzeSum < 70{
            RecommendLabel.text = "単語問題だ!!"
            return
        } else if BasicAnalyzeSum < 70{
            RecommendLabel.text = "職業問題だ!!"
            return
        }else if JudgmentAnalyzeSum < 70{
            RecommendLabel.text = "時間問題だ!!"
            return
        }else if ThinkingAnalyzeSum < 70{
            RecommendLabel.text = "カバン問題だ!!"
            return
        }else if LisningAnalyzeSum < 70{
            RecommendLabel.text = "算数問題!!"
            return
        }else if AppliedAnalyzeSum < 70{
            RecommendLabel.text = "カバンの中身問題だ!!"
            return
        }else if WordAnalyzeSum < 80{
            RecommendLabel.text = "単語問題だ!!"
            return
        } else if BasicAnalyzeSum < 80{
            RecommendLabel.text = "国名問題だ!!"
            return
        }else if JudgmentAnalyzeSum < 80{
            RecommendLabel.text = "買い物問題だ!!"
            return
        }else if ThinkingAnalyzeSum < 80{
            RecommendLabel.text = "食事問題とカバン問題だ!!"
            return
        }else if LisningAnalyzeSum < 80{
            RecommendLabel.text = "算数問題だ!!"
            return
        }else if AppliedAnalyzeSum < 80{
            RecommendLabel.text = "算数問題と時間問題だ!!"
            return
        }else if WordAnalyzeSum < 90{
            RecommendLabel.text = "単語問題だ!!"
            return
        } else if BasicAnalyzeSum < 90{
            RecommendLabel.text = "状況判断問題と国名問題だ!!"
            return
        }else if JudgmentAnalyzeSum < 90{
            RecommendLabel.text = "時間問題と買い物問題だ!!"
            return
        }else if ThinkingAnalyzeSum < 90{
            RecommendLabel.text = "道案内問題だ!!"
            return
        }else if LisningAnalyzeSum < 90{
            RecommendLabel.text = "アクセント問題と算数問題だ!!"
            return
        }else if AppliedAnalyzeSum < 90{
            RecommendLabel.text = "買い物問題と道案内問題だ!!"
            return
        }else {
            RecommendLabel.text = "ありません！どの分野もバッチリです！"
            return
        }
    }
    
    func CountedSet(){
        let realm = try!Realm()
        let countData = realm.objects(Player.self)
        DateLabel.text = String(countData.last!.LoginDate.count) + "日"
        let wordText = String(countData.last!.WordCount)
        WordCountLabel.text =  "\(wordText)問"
        let exerciseText = String(countData.last!.ExerciseCount)
        ExerciseLabel.text = "\(exerciseText)問"
    }
    
    func ImageSet()  {
        if ThinkingAnalyzeSum >= 80 {
            ThinkingImage.image = UIImage(named: "ratingS")
        }else if ThinkingAnalyzeSum >= 60{
            ThinkingImage.image = UIImage(named: "ratingA")
        }else if ThinkingAnalyzeSum >= 40 {
            ThinkingImage.image = UIImage(named: "ratingB")
        }else if ThinkingAnalyzeSum < 40{
            ThinkingImage.image = UIImage(named: "ratingC")
        }
        if JudgmentAnalyzeSum >= 80 {
            JudgmentImage.image = UIImage(named: "ratingS")
        }else if JudgmentAnalyzeSum >= 60{
            JudgmentImage.image = UIImage(named: "ratingA")
        }else if JudgmentAnalyzeSum >= 40 {
            JudgmentImage.image = UIImage(named: "ratingB")
        }else if JudgmentAnalyzeSum < 40{
            JudgmentImage.image = UIImage(named: "ratingC")
        }
        if LisningAnalyzeSum >= 80 {
            LisningImage.image = UIImage(named: "ratingS")
        }else if LisningAnalyzeSum >= 60{
            LisningImage.image = UIImage(named: "ratingA")
        }else if LisningAnalyzeSum >= 40 {
            LisningImage.image = UIImage(named: "ratingB")
        }else if LisningAnalyzeSum < 40{
            LisningImage.image = UIImage(named: "ratingC")
        }
        if BasicAnalyzeSum >= 80 {
            BasicImage.image = UIImage(named: "ratingS")
        }else if BasicAnalyzeSum >= 60{
            BasicImage.image = UIImage(named: "ratingA")
        }else if BasicAnalyzeSum >= 40 {
            BasicImage.image = UIImage(named: "ratingB")
        }else if BasicAnalyzeSum < 40{
            BasicImage.image = UIImage(named: "ratingC")
        }
        if AppliedAnalyzeSum >= 80 {
            AppliedImage.image = UIImage(named: "ratingS")
        }else if AppliedAnalyzeSum >= 60{
            AppliedImage.image = UIImage(named: "ratingA")
        }else if AppliedAnalyzeSum >= 40 {
            AppliedImage.image = UIImage(named: "ratingB")
        }else if AppliedAnalyzeSum < 40{
            AppliedImage.image = UIImage(named: "ratingC")
        }
        if WordAnalyzeSum >= 80 {
            WordImage.image = UIImage(named: "ratingS")
        }else if WordAnalyzeSum >= 60{
            WordImage.image = UIImage(named: "ratingA")
        }else if WordAnalyzeSum >= 40 {
            WordImage.image = UIImage(named: "ratingB")
        }else if WordAnalyzeSum < 40{
            WordImage.image = UIImage(named: "ratingC")
        }
    }
    
    func DataSet(){
        let realm = try!Realm()
        let ThinkingAnalyze = realm.objects(Player.self).last?.ThinkingKnowledge
       
        for i in 0...99{
            var number1 : Int!
            print(i)
            number1 = (ThinkingAnalyze?.count)! - i
            print(number1)
            ThinkingAnalyzeSum += (realm.objects(Player.self).last?.ThinkingKnowledge[number1 - 1])!.Thinking
            print(ThinkingAnalyzeSum)
        }
        
        let JudgmentAnalyze = realm.objects(Player.self).last?.JudgmentKnowledge
        
        for i in 0...99{
            var number2 : Int!
            number2 = (JudgmentAnalyze?.count)! - i
            JudgmentAnalyzeSum += (realm.objects(Player.self).last?.JudgmentKnowledge[number2 - 1])!.Judgment
        }
        
        let LisningAnalyze = realm.objects(Player.self).last?.LisningKnowledge
        
        for i in 0...99{
            var number3 : Int!
            number3 = (LisningAnalyze?.count)! - i
            LisningAnalyzeSum += (realm.objects(Player.self).last?.LisningKnowledge[number3 - 1])!.Lisning
        }
        
        let BasicsAnalyze = realm.objects(Player.self).last?.BasicsKnowledge
        
        for i in 0...99{
            var number4 : Int!
            number4 = (BasicsAnalyze?.count)! - i
            BasicAnalyzeSum += (realm.objects(Player.self).last?.BasicsKnowledge[number4 - 1])!.Basics
        }
        
        let AppliedAnalyze = realm.objects(Player.self).last?.AppliedKnowledge
        
        for i in 0...99{
            var number5 : Int!
            number5 = (AppliedAnalyze?.count)! - i
            AppliedAnalyzeSum += (realm.objects(Player.self).last?.AppliedKnowledge[number5 - 1])!.Applied
        }
        
        let WordAnalyze = realm.objects(Player.self).last?.WordKnowledge
        
        for i in 0...99{
            var number6 : Int!
            number6 = (WordAnalyze?.count)! - i
            WordAnalyzeSum += (realm.objects(Player.self).last?.WordKnowledge[number6 - 1])!.Word
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
