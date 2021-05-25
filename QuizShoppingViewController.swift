//
//  QuizGuideAViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/05/03.
//

import UIKit
import AVFoundation
import RealmSwift

class QuizShoppingViewController: UIViewController, AVAudioPlayerDelegate {
        
        var player : AVAudioPlayer!
        var point: Int = 0
        var QuizNumber : Int = 0
        var QuizArray : [Quiz] = []
        var quizBrainFree = FreeQuiz()
        var randomNumber : Int!
        var userAnswer : String!
        var firstAnswer : Bool = true
        var totalQuizCount : Int?
        var numberCount : Int = 0
        var storyMode = false
        
        
        var quizName : String!
        var quizType : Int!
        
    
    
    @IBOutlet weak var QuizNumberLabel: UILabel!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var Button5: UIButton!
    @IBOutlet weak var Button6: UIButton!
    @IBOutlet weak var Button7: UIButton!
    @IBOutlet weak var Button8: UIButton!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            BGMplayer.stop()
            startBGM()
    //        ポイント初期化
            point = 0
            
            QuizArray = quizBrainFree.shoppingQuizList
            totalQuizCount = QuizArray.count
            showQuiz()
                }
                
        func get()  {
            let realm = try! Realm()
            let Data = realm.objects(Player.self).last
            try! realm.write {
                Data?.ExerciseCount = Data!.ExerciseCount + 1
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
                Button4.isEnabled = false
                Button5.isEnabled = false
                Button6.isEnabled = false
                Button7.isEnabled = false
                Button8.isEnabled = false
                
                
    //            最初に正当すると得点
                if firstAnswer == true {
                    point += 1
                    
                    let realm = try! Realm()
                    let Data = realm.objects(Player.self).last
                    
//                    思考力
                        try! realm.write {
                            let ThinkingKList = ThinkingKnowledgeList()
                            ThinkingKList.Thinking = 1
                            Data?.ThinkingKnowledge.append(ThinkingKList)
                        }
    //                    応用力
                        try! realm.write {
                            let AppliedKList = AppliedKnowledgeList()
                            AppliedKList.Applied = 1
                            Data?.AppliedKnowledge.append(AppliedKList)
                        }
                    
                        print("Error")
                    
                }
    //            音を鳴らす
                let soundURL  = Bundle.main.url(forResource: "correct_answer", withExtension: "mp3")
    //            出された問題を除去
                QuizArray.remove(at: randomNumber)
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
                if numberCount < 5  {
    //                次の問題を表示
                    QuizNumber += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.showQuiz()
                    }
    //                最後の場合
                }else{
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
                    let realm = try! Realm()
                    let Data = realm.objects(Player.self).last
    //                    思考力
                        try! realm.write {
                            let ThinkingKList = ThinkingKnowledgeList()
                            ThinkingKList.Thinking = 0
                            Data?.ThinkingKnowledge.append(ThinkingKList)
                        }
    //                    応用力
                        try! realm.write {
                            let AppliedKList = AppliedKnowledgeList()
                            AppliedKList.Applied = 0
                            Data?.AppliedKnowledge.append(AppliedKList)
                        }
    //            得点判定をリセット
                    firstAnswer = false
                }
                
    //            苦手配列に入れる
                let realm = try! Realm()
                let playerData = realm.objects(Player.self).last
                let weak = WeakList()
                weak.weakQuiz = QuizArray[randomNumber].answer
                
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
            
            numberCount += 1
            Button1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            Button2.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            Button3.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            Button4.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            Button5.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            Button6.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            Button7.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            Button8.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            Button1.isEnabled = true
            Button2.isEnabled = true
            Button3.isEnabled = true
            Button4.isEnabled = true
            Button5.isEnabled = true
            Button6.isEnabled = true
            Button7.isEnabled = true
            Button8.isEnabled = true
            
    //        得点判定オン
            firstAnswer = true
    //        問題番号表示
            QuizNumberLabel.text = "\(QuizNumber + 1)/5問目"
    //        ランダムな数字を生成
            randomNumber = Int.random(in: 0..<QuizArray.count)
    //        ボタンに画像をセット
            Button1.setImage(UIImage(named:QuizArray[randomNumber].section1)?.withRenderingMode( UIImage.RenderingMode.alwaysOriginal), for: .normal)
            Button2.setImage(UIImage(named: QuizArray[randomNumber].section2)?.withRenderingMode( UIImage.RenderingMode.alwaysOriginal), for: .normal)
            Button3.setImage(UIImage(named: QuizArray[randomNumber].section3)?.withRenderingMode( UIImage.RenderingMode.alwaysOriginal), for: .normal)
            Button4.setImage(UIImage(named:QuizArray[randomNumber].section4)?.withRenderingMode( UIImage.RenderingMode.alwaysOriginal), for: .normal)
            Button5.setImage(UIImage(named: QuizArray[randomNumber].section5)?.withRenderingMode( UIImage.RenderingMode.alwaysOriginal), for: .normal)
            Button6.setImage(UIImage(named: QuizArray[randomNumber].section6)?.withRenderingMode( UIImage.RenderingMode.alwaysOriginal), for: .normal)
            Button7.setImage(UIImage(named:QuizArray[randomNumber].section7)?.withRenderingMode( UIImage.RenderingMode.alwaysOriginal), for: .normal)
            Button8.setImage(UIImage(named:QuizArray[randomNumber].section8)?.withRenderingMode( UIImage.RenderingMode.alwaysOriginal), for: .normal)
            
            
    //        正誤判定用ボタン名の生成
            Button1.setTitle(QuizArray[randomNumber].section1, for: .normal) as? String
            Button2.setTitle(QuizArray[randomNumber].section2, for: .normal) as? String
            Button3.setTitle(QuizArray[randomNumber].section3, for: .normal) as? String
            Button4.setTitle(QuizArray[randomNumber].section4, for: .normal) as? String
            Button5.setTitle(QuizArray[randomNumber].section5, for: .normal) as? String
            Button6.setTitle(QuizArray[randomNumber].section6, for: .normal) as? String
            Button7.setTitle(QuizArray[randomNumber].section7, for: .normal) as? String
            Button8.setTitle(QuizArray[randomNumber].section8, for: .normal) as? String
            
    //        問題音声関数を起動
            Sound(random: randomNumber)
    //        答えを変数に代入
            userAnswer = QuizArray[randomNumber].answer
        }
        
    //    問題音声関数
        func Sound(random:Int) {
            
            let soundURL  = Bundle.main.url(forResource: "\(QuizArray[randomNumber].sound)", withExtension: "mp3")
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
            
        }
    //    問題音声再起動ボタン
       
    @IBAction func Again(_ sender: Any) {
            Sound(random: randomNumber)
        }
    //    次の画面に値を渡す
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "Segue") {
                let  NextVC = segue.destination as! PracticeFinishedViewController
                NextVC.answerPoint = point
                NextVC.totalQuiz = QuizNumber
                NextVC.quizName = quizName
                NextVC.quizType = quizType
                NextVC.storyMode = storyMode
            }
        }
    
        func startBGM(){
            var url :String!
    //                BGM
                do {
                    let url = Bundle.main.bundleURL.appendingPathComponent("shoppingBGM.mp3")
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
            if storyMode == true{
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
            }else if storyMode == false{
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
            
    }
