//
//  PracticeWordQuestionViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/11/23.
//

import UIKit
import AVFoundation
import RealmSwift

class PracticeWordQuestionViewController: UIViewController, AVAudioPlayerDelegate {
    
    var player : AVAudioPlayer!
    var point: Int = 0
    var CellIndex : IndexPath!
    var QuizNumber : Int = 0
    var QuizArray : [Quiz] = []
    var quizBrain = WordQuiz()
    var randomNumber : Int!
    var userAnswer : String!
    var firstAnswer : Bool = true
    var checkLastQuestionBool : Bool = false
    var totalQuizCount : Int?
    var storyMode : Bool = false
    var storyRandom :Int!
    
    @IBOutlet weak var Background: UIImageView!
    @IBOutlet weak var QuizNumberLabel: UILabel!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    
    
    @IBOutlet weak var SoundImage: UIImageView!
    
    @IBOutlet weak var mobImage: UIImageView!
    @IBOutlet weak var avatarView: AvatarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BGMplayer.stop()
        avatar()
        startBGM()
        
        
       //カスタマイズViewを追加
       self.view.addSubview(avatarView)
        
        
        
//        ポイント初期化
        point = 0
//        Cellの番号に合わせて問題を代入
        if storyMode == false{
        QuizArray = quizBrain.QuizList[CellIndex.section][CellIndex.row]
        }else if storyMode == true{
            let realm = try!Realm()
            let cheack = realm.objects(Player.self).last
            switch cheack?.MyStage {
            case "Japan":
                Background.image = UIImage(named: "Japan_background")
                if cheack?.MySystemNumber == 1 {
                    
//                    食事
                storyRandom = Int.random(in: 0...11)
                QuizArray = quizBrain.QuizList[0][storyRandom]
                }else if cheack?.MySystemNumber == 3 {
//                    生き物
                    storyRandom = Int.random(in: 0...7)
                    QuizArray = quizBrain.QuizList[1][storyRandom]
                }else if cheack?.MySystemNumber == 5 {
//                    自然
                    storyRandom = Int.random(in: 0...2)
                    QuizArray = quizBrain.QuizList[5][storyRandom]
                }

            case "China":
                Background.image = UIImage(named: "China_background")
                if cheack?.MySystemNumber == 1 {
//                    職業
                storyRandom = Int.random(in: 0...5)
                QuizArray = quizBrain.QuizList[4][storyRandom]
                }else if cheack?.MySystemNumber == 3 {
//                    時間
                    storyRandom = Int.random(in: 0...2)
                    QuizArray = quizBrain.QuizList[8][storyRandom]
                }else if cheack?.MySystemNumber == 5 {
                    //                    食事
                    storyRandom = Int.random(in: 0...11)
                    QuizArray = quizBrain.QuizList[0][storyRandom]
                }
            case "Australia":
                Background.image = UIImage(named: "Australia_background")
                if cheack?.MySystemNumber == 1 {
//                    身の回り
                storyRandom = Int.random(in: 0...11)
                QuizArray = quizBrain.QuizList[2][storyRandom]
                }else if cheack?.MySystemNumber == 3 {
                    //                    生き物
                storyRandom = Int.random(in: 0...7)
                QuizArray = quizBrain.QuizList[1][storyRandom]
                }else if cheack?.MySystemNumber == 5 {
                    //                    時間
                                        storyRandom = Int.random(in: 0...2)
                                        QuizArray = quizBrain.QuizList[8][storyRandom]
                }
            case "India":
                Background.image = UIImage(named: "India_background")
                if cheack?.MySystemNumber == 1 {
                    //                    食事
                    storyRandom = Int.random(in: 0...11)
                    QuizArray = quizBrain.QuizList[0][storyRandom]
                }else if cheack?.MySystemNumber == 3 {
                    //                    職業
                                    storyRandom = Int.random(in: 0...5)
                                    QuizArray = quizBrain.QuizList[4][storyRandom]
                }else if cheack?.MySystemNumber == 5 {
                    //                    自然
                                        storyRandom = Int.random(in: 0...2)
                                        QuizArray = quizBrain.QuizList[5][storyRandom]
                }
            case "Africa":
                Background.image = UIImage(named: "Africa_background")
                if cheack?.MySystemNumber == 1 {
                    //                    職業
                                    storyRandom = Int.random(in: 0...5)
                                    QuizArray = quizBrain.QuizList[4][storyRandom]
                }else if cheack?.MySystemNumber == 3 {
//                    人と生活
                    storyRandom = Int.random(in: 0...2)
                    QuizArray = quizBrain.QuizList[6][storyRandom]
                }else if cheack?.MySystemNumber == 5 {
                    //                    生き物
                                        storyRandom = Int.random(in: 0...7)
                                        QuizArray = quizBrain.QuizList[1][storyRandom]
                }
            case "Europa":
                Background.image = UIImage(named: "Europa_background")
                if cheack?.MySystemNumber == 1 {
                    //                    動詞
                                        storyRandom = Int.random(in: 0...7)
                                        QuizArray = quizBrain.QuizList[10][storyRandom]
                }else if cheack?.MySystemNumber == 3 {
//                    学校
                    storyRandom = Int.random(in: 0...7)
                    QuizArray = quizBrain.QuizList[3][storyRandom]
                }else if cheack?.MySystemNumber == 5 {
                    //                    身の回り
                                    storyRandom = Int.random(in: 0...11)
                                    QuizArray = quizBrain.QuizList[2][storyRandom]
                }
            case "America":
                Background.image = UIImage(named: "America_background")
                if cheack?.MySystemNumber == 1 {
//                    算数
                storyRandom = Int.random(in: 0...2)
                QuizArray = quizBrain.QuizList[9][storyRandom]
                }else if cheack?.MySystemNumber == 3 {
                    //                    旅
                                    storyRandom = Int.random(in: 0...3)
                                    QuizArray = quizBrain.QuizList[7][storyRandom]
                }else if cheack?.MySystemNumber == 5 {
                    //                    学校
                                        storyRandom = Int.random(in: 0...7)
                                        QuizArray = quizBrain.QuizList[3][storyRandom]
                }
            case "Brazil":
                Background.image = UIImage(named: "Brazil_background")
                if cheack?.MySystemNumber == 1 {
                    //                    身の回り
                                    storyRandom = Int.random(in: 0...11)
                                    QuizArray = quizBrain.QuizList[2][storyRandom]
                }else if cheack?.MySystemNumber == 3 {
                    //                    動詞
                                        storyRandom = Int.random(in: 0...7)
                                        QuizArray = quizBrain.QuizList[10][storyRandom]
                }else if cheack?.MySystemNumber == 5 {
                    //                    人と生活
                                        storyRandom = Int.random(in: 0...2)
                                        QuizArray = quizBrain.QuizList[6][storyRandom]
                }
            case "SouthPole":
                Background.image = UIImage(named: "SouthPole_background")
                if cheack?.MySystemNumber == 1 {
//                    旅
                storyRandom = Int.random(in: 0...3)
                QuizArray = quizBrain.QuizList[7][storyRandom]
                }else if cheack?.MySystemNumber == 3 {
                    //                    身の回り
                                    storyRandom = Int.random(in: 0...11)
                                    QuizArray = quizBrain.QuizList[2][storyRandom]
                }else if cheack?.MySystemNumber == 5 {
                    //                    状態
                    storyRandom = Int.random(in: 0...4)
                                        QuizArray = quizBrain.QuizList[11][storyRandom]
                }
            case "Cosmo":
                Background.image = UIImage(named: "Cosmo_background")
                if cheack?.MySystemNumber == 1 {
                    //                    算数
                                    storyRandom = Int.random(in: 0...2)
                                    QuizArray = quizBrain.QuizList[9][storyRandom]
                }else if cheack?.MySystemNumber == 3 {
//                    動詞
                    storyRandom = Int.random(in: 0...7)
                    QuizArray = quizBrain.QuizList[10][storyRandom]
                }else if cheack?.MySystemNumber == 5 {
//                    状態
                    storyRandom = Int.random(in: 0...4)
                    QuizArray = quizBrain.QuizList[11][storyRandom]
                }
            default:
                print("error")
            }
            
        }
        totalQuizCount = QuizArray.count
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
            if 0 < QuizArray.count  {
//                次の問題を表示
                QuizNumber += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.showQuiz()
                }
//                最後の場合
            }else{
//                次の画面に遷移
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if self.storyMode == false {
                    self.checkLastQuiz()
                    self.mainstartBGM()
                    }
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
            let realm = try! Realm()
            var playerData = realm.objects(Player.self).last
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
        if storyMode == true {
            let realm = try!Realm()
            let cheack = realm.objects(Player.self).last
            switch cheack?.MyStage {
            case "Japan":
                if cheack?.MyStageNumber == 5 {
                    mobImage.image = UIImage(named: "Japan_boss")
                }else if cheack!.MyStageNumber <= 4 {
                    let mobNumber = Int.random(in: 0..<JapanMobArray.count)
                    mobImage.image = UIImage(named: JapanMobArray[mobNumber])
                }
            case "China":
                if cheack?.MyStageNumber == 5 {
                    mobImage.image = UIImage(named: "China_boss")
                }else if cheack!.MyStageNumber <= 4 {
                    let mobNumber = Int.random(in: 0..<ChinaMobArray.count)
                    mobImage.image = UIImage(named: ChinaMobArray[mobNumber])
                }
            case "Australia":
                if cheack?.MyStageNumber == 5 {
                    mobImage.image = UIImage(named: "Australia_boss")
                }else if cheack!.MyStageNumber <= 4 {
                    let mobNumber = Int.random(in: 0..<AustraliaMobArray.count)
                    mobImage.image = UIImage(named: AustraliaMobArray[mobNumber])
                }
            case "India":
                if cheack?.MyStageNumber == 5 {
                    mobImage.image = UIImage(named: "India_boss")
                }else if cheack!.MyStageNumber <= 4 {
                    let mobNumber = Int.random(in: 0..<IndiaMobArray.count)
                    mobImage.image = UIImage(named: IndiaMobArray[mobNumber])
                }
            case "Africa":
                if cheack?.MyStageNumber == 5 {
                    mobImage.image = UIImage(named: "Africa_boss")
                }else if cheack!.MyStageNumber <= 4 {
                    let mobNumber = Int.random(in: 0..<AfricaMobArray.count)
                    mobImage.image = UIImage(named: AfricaMobArray[mobNumber])
                }
            case "Europa":
                if cheack?.MyStageNumber == 5 {
                    mobImage.image = UIImage(named: "Europa_boss")
                }else if cheack!.MyStageNumber <= 4 {
                    let mobNumber = Int.random(in: 0..<EuropaMobArray.count)
                    mobImage.image = UIImage(named: EuropaMobArray[mobNumber])
                }
            case "America":
                if cheack?.MyStageNumber == 5 {
                    mobImage.image = UIImage(named: "Europa_boss")
                }else if cheack!.MyStageNumber <= 4 {
                    let mobNumber = Int.random(in: 0..<EuropaMobArray.count)
                    mobImage.image = UIImage(named: EuropaMobArray[mobNumber])
                }
            case "Brazil":
                if cheack?.MyStageNumber == 5 {
                    mobImage.image = UIImage(named: "Brazil_boss")
                }else if cheack!.MyStageNumber <= 4 {
                    let mobNumber = Int.random(in: 0..<BrazilMobArray.count)
                    mobImage.image = UIImage(named: BrazilMobArray[mobNumber])
                }
            case "South Pole":
                if cheack?.MyStageNumber == 5 {
                    mobImage.image = UIImage(named: "SouthPole_boss")
                }else if cheack!.MyStageNumber <= 4 {
                    let mobNumber = Int.random(in: 0..<SouthPoleMobArray.count)
                    mobImage.image = UIImage(named: SouthPoleMobArray[mobNumber])
                }
            case "Cosmo":
                if cheack?.MyStageNumber == 5 {
                    mobImage.image = UIImage(named: "Cosmo_boss")
                }else if cheack!.MyStageNumber <= 4 {
                    let mobNumber = Int.random(in: 0..<CosmoMobArray.count)
                    mobImage.image = UIImage(named: CosmoMobArray[mobNumber])
                }
            default:
                print("error")
            }
        }else if storyMode == false {
            let allMobNumber = Int.random(in: 0..<enemyMobArray.count)
            mobImage.image = UIImage(named: enemyMobArray[allMobNumber])
        }
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
        QuizNumberLabel.text = "\(QuizNumber + 1)/\(String(describing: totalQuizCount!))問目"
//        ランダムな数字を生成
        randomNumber = Int.random(in: 0..<QuizArray.count)
//        ボタンに画像をセット
        Button1.setImage(UIImage(named: QuizArray[randomNumber].section1)?.withRenderingMode( UIImage.RenderingMode.alwaysOriginal), for: .normal)
        Button2.setImage(UIImage(named: QuizArray[randomNumber].section2)?.withRenderingMode( UIImage.RenderingMode.alwaysOriginal), for: .normal)
        Button3.setImage(UIImage(named: QuizArray[randomNumber].section3)?.withRenderingMode( UIImage.RenderingMode.alwaysOriginal), for: .normal)
//        正誤判定用ボタン名の生成
        Button1.setTitle(QuizArray[randomNumber].section1, for: .normal) as? String
        Button2.setTitle(QuizArray[randomNumber].section2, for: .normal) as? String
        Button3.setTitle(QuizArray[randomNumber].section3, for: .normal) as? String
//        問題音声関数を起動
        Sound(random: randomNumber)
//        答えを変数に代入
        userAnswer = QuizArray[randomNumber].answer
    }
    
//    問題音声関数
    func Sound(random:Int) {
        
        let soundURL  = Bundle.main.url(forResource: "\(QuizArray[randomNumber].answer)", withExtension: "mp3")
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
        Sound(random: randomNumber)
    }
//    次の画面に値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Segue") {
            let  NextVC = segue.destination as! PracticeWordFinishedViewController
            NextVC.answerPoint = point
            NextVC.totalQuiz = QuizNumber
            NextVC.CellIndex = CellIndex
            NextVC.checkLastQuestionBool = checkLastQuestionBool
            NextVC.storyMode = storyMode
        }
    }
    
    func checkLastQuiz() {
        if quizBrain.QuizList[CellIndex.section].count == CellIndex.row + 1 {
            checkLastQuestionBool = true
        } else {
            checkLastQuestionBool = false
        }
        
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
        }
        BGMplayer!.play()
        BGMplayer!.numberOfLoops = -1
    }
    func startBGM(){
        
        let realm = try!Realm()
        let playerDate = realm.objects(Player.self).last
        if storyMode == true {
            if playerDate?.MyStageNumber == 5 {
        //                BGM
                        let url = Bundle.main.bundleURL.appendingPathComponent("bossBGM.mp3")
                                do {
                                    let realm = try!Realm()
                                    let SoundData = realm.objects(Player.self).last
                                    try BGMplayer = AVAudioPlayer(contentsOf: url)
                                    BGMplayer.volume = Float(0.05 * SoundData!.BGM)
                                } catch {
                                    print("Error")
                                }
                                } else if playerDate!.MyStageNumber < 5{
        if playerDate?.MyStage == "Japan" {
            //                BGM
                            let url = Bundle.main.bundleURL.appendingPathComponent("JapanBGM.mp3")
                                    do {
                                        let realm = try!Realm()
                                        let SoundData = realm.objects(Player.self).last
                                        try BGMplayer = AVAudioPlayer(contentsOf: url)
                                        BGMplayer.volume = Float(0.05 * SoundData!.BGM)
                                    } catch {
                                        print("Error")
                                    }
        } else if playerDate?.MyStage == "China"{
            //                BGM
                            let url = Bundle.main.bundleURL.appendingPathComponent("ChinaBGM.mp3")
                                    do {
                                        let realm = try!Realm()
                                        let SoundData = realm.objects(Player.self).last
                                        try BGMplayer = AVAudioPlayer(contentsOf: url)
                                        BGMplayer.volume = Float(0.05 * SoundData!.BGM)
                                    } catch {
                                        print("Error")
                                    }
        } else if playerDate?.MyStage == "Australia"{
            //                BGM
                            let url = Bundle.main.bundleURL.appendingPathComponent("AustraliaBGM.mp3")
                                    do {
                                        let realm = try!Realm()
                                        let SoundData = realm.objects(Player.self).last
                                        try BGMplayer = AVAudioPlayer(contentsOf: url)
                                        BGMplayer.volume = Float(0.05 * SoundData!.BGM)
                                    } catch {
                                        print("Error")
                                    }
        }else if playerDate?.MyStage == "India"{
            //                BGM
                            let url = Bundle.main.bundleURL.appendingPathComponent("IndiaBGM.mp3")
                                    do {
                                        let realm = try!Realm()
                                        let SoundData = realm.objects(Player.self).last
                                        try BGMplayer = AVAudioPlayer(contentsOf: url)
                                        BGMplayer.volume = Float(0.05 * SoundData!.BGM)
                                    } catch {
                                        print("Error")
                                    }
        }else if playerDate?.MyStage == "Africa"{
            //                BGM
                            let url = Bundle.main.bundleURL.appendingPathComponent("AfricaBGM.mp3")
                                    do {
                                        let realm = try!Realm()
                                        let SoundData = realm.objects(Player.self).last
                                        try BGMplayer = AVAudioPlayer(contentsOf: url)
                                        BGMplayer.volume = Float(0.05 * SoundData!.BGM)
                                    } catch {
                                        print("Error")
                                    }
        }else if playerDate?.MyStage == "Europa"{
            //                BGM
                            let url = Bundle.main.bundleURL.appendingPathComponent("EuropaBGM.mp3")
                                    do {
                                        let realm = try!Realm()
                                        let SoundData = realm.objects(Player.self).last
                                        try BGMplayer = AVAudioPlayer(contentsOf: url)
                                        BGMplayer.volume = Float(0.05 * SoundData!.BGM)
                                    } catch {
                                        print("Error")
                                    }
        }else if playerDate?.MyStage == "America"{
            //                BGM
                            let url = Bundle.main.bundleURL.appendingPathComponent("AmericaBGM.mp3")
                                    do {
                                        let realm = try!Realm()
                                        let SoundData = realm.objects(Player.self).last
                                        try BGMplayer = AVAudioPlayer(contentsOf: url)
                                        BGMplayer.volume = Float(0.05 * SoundData!.BGM)
                                    } catch {
                                        print("Error")
                                    }
        }else if playerDate?.MyStage == "Brazil"{
            //                BGM
                            let url = Bundle.main.bundleURL.appendingPathComponent("BrazilBGM.mp3")
                                    do {
                                        let realm = try!Realm()
                                        let SoundData = realm.objects(Player.self).last
                                        try BGMplayer = AVAudioPlayer(contentsOf: url)
                                        BGMplayer.volume = Float(0.05 * SoundData!.BGM)
                                    } catch {
                                        print("Error")
                                    }
        }else if playerDate?.MyStage == "SouthPole"{
            //                BGM
                            let url = Bundle.main.bundleURL.appendingPathComponent("SouthPoleBGM.mp3")
                                    do {
                                        let realm = try!Realm()
                                        let SoundData = realm.objects(Player.self).last
                                        try BGMplayer = AVAudioPlayer(contentsOf: url)
                                        BGMplayer.volume = Float(0.05 * SoundData!.BGM)
                                    } catch {
                                        print("Error")
                                    }
        }else if playerDate?.MyStage == "universe"{
            //                BGM
                            let url = Bundle.main.bundleURL.appendingPathComponent("universeBGM.mp3")
                                    do {
                                        let realm = try!Realm()
                                        let SoundData = realm.objects(Player.self).last
                                        try BGMplayer = AVAudioPlayer(contentsOf: url)
                                        BGMplayer.volume = Float(0.05 * SoundData!.BGM)
                                    } catch {
                                        print("Error")
                                        }
                                    }
                                }
        }else if storyMode == false {
    //                BGM
                    let url = Bundle.main.bundleURL.appendingPathComponent("worldBGM.mp3")
                            do {
                                let realm = try!Realm()
                                let SoundData = realm.objects(Player.self).last
                                try BGMplayer = AVAudioPlayer(contentsOf: url)
                                BGMplayer.volume = Float(0.05 * SoundData!.BGM)
                            } catch {
                                print("Error")
                            }
    }
        BGMplayer!.play()
        BGMplayer!.numberOfLoops = -1
        }
}
