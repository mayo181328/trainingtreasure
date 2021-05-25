//
//  PracticeWeakQuestionViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/11/23.
//

import UIKit
import AVFoundation
import RealmSwift

class PracticeWeakQuestionViewController: UIViewController ,AVAudioPlayerDelegate{

    var player : AVAudioPlayer!
    var point: Int = 0
    var QuizNumber : Int = 0
    var userAnswer : String!
    var firstAnswer : Bool = true
    var totalweakQuizList : Int?
    var numberCount : Int = 0
    var under10Array = [Quiz]()
    var upper10Array = [Quiz]()
    
    var weakQuizList = [Quiz]()
    var quizBrain = WordQuiz()
    
    @IBOutlet weak var QuizNumberLabel: UILabel!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    
    @IBOutlet weak var SoundImage: UIImageView!
    
    @IBOutlet weak var mobImage: UIImageView!
    @IBOutlet weak var avatarView: AvatarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar()
        startBGM()
        numberCount = 0
        
        //        ポイント初期化
                point = 0
        
        
        let realm = try!Realm()
        let weakData = realm.objects(Player.self).last?.weakList
        var weakDateArray : [String] = [String]()
        
        for i in 0...weakData!.count - 1 {
            weakDateArray.append(weakData![i].weakQuiz)
         }
        //        同じ問題を消す
                let orderedSet: NSOrderedSet = NSOrderedSet(array: weakDateArray)
                    weakDateArray = orderedSet.array as! [String]
        //        検索
        for i in  0...quizBrain.QuizList.count - 1{
            for i2 in 0...quizBrain.QuizList[i].count - 1 {
                for i3 in 0...quizBrain.QuizList[i][i2].count - 1 {
                    for w in weakDateArray {
                        if quizBrain.QuizList[i][i2][i3].answer == w {
                            weakQuizList.append(quizBrain.QuizList[i][i2][i3])
                            let string = quizBrain.QuizList[i][i2][i3].answer
                            let results = realm.objects(Player.self).filter("ANY weakList.weakQuiz == %@",string)
                            
                                    try! realm.write(){
                                        for r in results {
                                            r.weakList.removeAll()
                                        }
                                    }
                        }
                    }
                }
            }
        }
        
        weakQuizList.randomElement()
        if weakQuizList.count >= 10 {
            for i in 0...9 {
                under10Array.append(weakQuizList[i])
            }
            for i in 10...weakQuizList.count - 1{
                upper10Array.append(weakQuizList[i])
            }
        }else if weakQuizList.count < 10{
            for i in 0...weakQuizList.count - 1 {
                under10Array.append(weakQuizList[i])
            }
        }
        
        //            苦手配列に入れる
        for i in upper10Array {
            let playerData = realm.objects(Player.self).last
            let weak = WeakList()
            weak.weakQuiz = i.answer
                    try!realm.write{
                        playerData?.weakList.append(weak)
                    }
        }
        
        if weakQuizList.count > 0 {
            totalweakQuizList = under10Array.count
        }else{
            print("error")
        }
        showQuiz()
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
    
    func get()  {
        let realm = try! Realm()
        let Data = realm.objects(Player.self).last
        try! realm.write {
            Data?.WordCount = Data!.WordCount  + 1
        }
    }
    
    @IBAction func tapButton (_ sender: UIButton)  {

//        正解の場合
        if userAnswer == sender.currentTitle {
            get()
            sender.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            Button1.isEnabled = false
            Button2.isEnabled = false
            Button3.isEnabled = false

//            最初に正当すると得点
            if firstAnswer == true {
                point += 1
            }

            //            音を鳴らす
            let soundURL  = Bundle.main.url(forResource: "correct_answer", withExtension: "mp3")
//            出された問題を削除
            under10Array.remove(at: under10Array.count - 1)
            do{
                let realm = try!Realm()
                let SoundData = realm.objects(Player.self).last
                player = try AVAudioPlayer(contentsOf: soundURL!)
                player.delegate = self
                player.volume = Float(0.2 * SoundData!.Effect)
                player?.play()

            }catch{
                print(error)
            }
//            何問目か判定
//            最後以外の場合
            if 0 < under10Array.count  {
//                次の問題を表示
                QuizNumber += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.showQuiz()
                }
//                最後の場合
            }else if numberCount == 10 {
//                次の画面に遷移
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.mainstartBGM()
                self.performSegue(withIdentifier: "Segue", sender: nil)
                }
            } else {
//                次の画面に遷移
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.mainstartBGM()
                self.performSegue(withIdentifier: "Segue", sender: nil)
                }
            }
//            間違っていた場合
        } else {
            sender.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            sender.isEnabled = false
//            最初の答えの場合
            if firstAnswer == true {
//            得点判定をリセット
                firstAnswer = false
            }
//            苦手配列に入れる
            var realm = try! Realm()
            var playerData = realm.objects(Player.self).last
            var weak = WeakList()
            weak.weakQuiz = under10Array[under10Array.count - 1].answer

            try!realm.write{
                playerData?.weakList.append(weak)
            }
//            音を鳴らす
            let soundURL  = Bundle.main.url(forResource: "wrong_answer", withExtension: "mp3")
            do{
                let realm = try!Realm()
                let SoundData = realm.objects(Player.self).last
                player = try AVAudioPlayer(contentsOf: soundURL!)
                player.delegate = self
                player.volume = Float(0.2 * SoundData!.Effect)
                player?.play()
            }catch{
                print(error)
            }
        }
    }
//    問題表示関数
    func showQuiz () {
            let allMobNumber = Int.random(in: 0..<enemyMobArray.count)
            mobImage.image = UIImage(named: enemyMobArray[allMobNumber])
        
        numberCount += 1
//        Button1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        Button2.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        Button3.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        Button1.backgroundColor = .clear
        Button2.backgroundColor = .clear
        Button3.backgroundColor = .clear

        Button1.isEnabled = true
        Button2.isEnabled = true
        Button3.isEnabled = true

//        得点判定オン
        firstAnswer = true
//        問題番号表示
//        QuizNumberLabel.text = "\(QuizNumber + 1)/\(totalweakQuizList)問目"
        QuizNumberLabel.text = "\(QuizNumber + 1)/\(String(describing: totalweakQuizList!))問目"
    
        //        ボタンに画像をセット
        Button1.setImage(UIImage(named: under10Array[under10Array.count - 1].section1)?.withRenderingMode( UIImage.RenderingMode.alwaysOriginal), for: .normal)
                Button2.setImage(UIImage(named: under10Array[under10Array.count - 1].section2)?.withRenderingMode( UIImage.RenderingMode.alwaysOriginal), for: .normal)
                Button3.setImage(UIImage(named: under10Array[under10Array.count - 1].section3)?.withRenderingMode( UIImage.RenderingMode.alwaysOriginal), for: .normal)
//        正誤判定用ボタン名の生成
        Button1.setTitle(under10Array[under10Array.count - 1].section1, for: .normal) as? String
        Button2.setTitle(under10Array[under10Array.count - 1].section2, for: .normal) as? String
        Button3.setTitle(under10Array[under10Array.count - 1].section3, for: .normal) as? String
//        問題音声関数を起動
        Sound(random: under10Array.count - 1)
//        答えを変数に代入
        userAnswer = under10Array[under10Array.count - 1].answer
    }

//    問題音声関数
    func Sound(random:Int) {

            let soundURL  = Bundle.main.url(forResource: "\(under10Array[under10Array.count - 1].answer)", withExtension: "mp3")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                do{
                    let realm = try!Realm()
                    let SoundData = realm.objects(Player.self).last
                    self.player = try AVAudioPlayer(contentsOf: soundURL!)
                    self.player.delegate = self
                    self.player.volume = Float(1.0 * SoundData!.Voice)
                    self.player?.play()
                }catch{
                    print(error)
                }
            }
            SoundImage.image = UIImage(named: "againOn_button.png")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.SoundImage.image = UIImage(named: "againOff_button.png")
            }
        }
    //    問題音声再起動ボタン
    @IBAction func Again(_ sender: Any) {
        Sound(random: under10Array.count - 1)
    }
//    次の画面に値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Segue") {
            let  NextVC = segue.destination as! PracticeWeakFinishedViewController
            NextVC.answerPoint = point
            NextVC.totalQuiz = QuizNumber
        }
    }
    
    func startBGM(){
//                BGM
                let url = Bundle.main.bundleURL.appendingPathComponent("wordBGM.mp3")
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

    func mainstartBGM(){
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
}
