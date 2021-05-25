//
//  PracticeExplanationViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/03.
//

import UIKit
import AVFoundation
import RealmSwift

class PracticeExplanationViewController: UIViewController , AVAudioPlayerDelegate,ButtonTapDelegate{
    
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!
    @IBOutlet weak var textFild: UITextView!
    
    var quizName : String!
    var quizType : Int!
    var storyMode = false
    
    var player : AVAudioPlayer!
    
    @IBOutlet weak var cancelBar: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if storyMode == true {
            cancelBar.isHidden = true
            topBar.isHidden = true
            underBar.isHidden = true
            let realm = try!Realm()
            let cheack = realm.objects(Player.self).last
            switch cheack?.MyStage {
            case "Japan":
                if cheack?.MySystemNumber == 2 {
                    quizName = "occupation"
                    quizType = 4
                }else if cheack?.MySystemNumber == 4 {
                    quizName = "country"
                    quizType = 4
                }
            case "China":
                if cheack?.MySystemNumber == 2 {
                    quizName = "cook"
                    quizType = 4
                }else if cheack?.MySystemNumber == 4 {
                    quizName = "sport"
                    quizType = 4
                }
            case "Australia":
                if cheack?.MySystemNumber == 2 {
                    quizName = "occupation"
                    quizType = 4
                }else if cheack?.MySystemNumber == 4 {
                    quizName = "accent"
                    quizType = 3
                }
            case "India":
                if cheack?.MySystemNumber == 2 {
                    quizName = "circumstance"
                    quizType = 3
                }else if cheack?.MySystemNumber == 4 {
                    quizName = "dishes"
                    quizType = 3
                }
            case "Africa":
                if cheack?.MySystemNumber == 2 {
                    quizName = "bag"
                    quizType = 3
                }else if cheack?.MySystemNumber == 4 {
                    quizName = "country"
                    quizType = 4
                }
            case "Europa":
                if cheack?.MySystemNumber == 2 {
                    quizName = "time"
                    quizType = 3
                }else if cheack?.MySystemNumber == 4 {
                    quizName = "accent"
                    quizType = 3
                }
            case "America":
                if cheack?.MySystemNumber == 2 {
                    quizName = "dishes"
                    quizType = 3
                }else if cheack?.MySystemNumber == 4 {
                    quizName = "shopping"
                    quizType = 8
                }
            case "Brazil":
                if cheack?.MySystemNumber == 2 {
                    quizName = "bag"
                    quizType = 3
                }else if cheack?.MySystemNumber == 4 {
                    quizName = "guide"
                    quizType = 0
                }
            case "南極":
                if cheack?.MySystemNumber == 2 {
                    quizName = "time"
                    quizType = 3
                }else if cheack?.MySystemNumber == 4 {
                    quizName = "math"
                    quizType = 4
                }
            case "宇宙":
                if cheack?.MySystemNumber == 2 {
                    quizName = "shopping"
                    quizType = 8
                }else if cheack?.MySystemNumber == 4 {
                    quizName = "guide"
                    quizType = 0
                }
            default:
                print("error")
            }
        }else if storyMode == false {
            underBar.delegate = self
            writeTopBar()
        }
        textSet()
    }
    
    @IBAction func startButton(_ sender: Any) {
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
        }else if quizType == 0{
            let randomInt = Int.random(in: 1..<6)
            
            if randomInt = 1{
                self.performSegue(withIdentifier: "SegueA", sender: nil)
            } else if randomInt = 2{
                self.performSegue(withIdentifier: "SegueB", sender: nil)
            } else if randomInt = 3{
                self.performSegue(withIdentifier: "SegueC", sender: nil)
            } else if randomInt = 4{
                self.performSegue(withIdentifier: "SegueD", sender: nil)
            } else if randomInt = 5{
                self.performSegue(withIdentifier: "SegueE", sender: nil)
            }
            
            }else if quizType == 8 {
                self.performSegue(withIdentifier: "Segue8", sender: nil)
            }
    }
    
    @IBAction func backButton(_ sender: Any) {
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
    
    func textSet() {
        if quizName == "country"{
            textFild.text = "音声で、さまざまな「国名」が読み上げられます。正解だと思う国旗をタップしよう！"
        }else if quizName == "sport"{
            textFild.text = "音声で、さまざまな「スポーツ」の説明が読み上げられます。正解だと思うスポーツをタップしよう！"
        }else if quizName == "cook"{
            textFild.text = "音声で、さまざまな「食べ物」の説明が読み上げられます。正解だと思う食べ物をタップしよう！"
        }else if quizName == "circumstance"{
            textFild.text = "音声で、さまざまな「職業(おしごと)」の説明が読み上げられます。正解だと思う職業(おしごと)をタップしよう！"
        }else if quizName == "occupation"{
            textFild.text = "音声で、「誰が何をしているか」などの説明が読み上げられます。正解だと思うイラストをタップしよう！"
        }else if quizName == "dishes"{
            textFild.text = "音声で、さまざまな料理の「組み合わせ」が説明されます。正解だと思う食事の組み合わせを見つけ、タップしよう！"
        }else if quizName == "bag"{
            textFild.text = "音声で、「カバンの中には何が入っているか」が説明されます。正解だと思うカバンの中身を見つけ出し、タップしよう！入っている物の数にも注意だ！"
        }else if quizName == "accent"{
            textFild.text = "音声で、英単語が読み上げられます。正しい「アクセント(強く読まれるときろ)」の位置をみつけ、タップしよう！アクセントがあるところには、上に「しるし」がついてあるぞ！どこが強く読まれているか、良く聞いてみよう。"
        }else if quizName == "guide"{
            textFild.text = "音声で、スタート地点からゴールまでの道の説明がされます。到着した場所はどこか、正解だと思う場所をタップしよう！今自分がどの位置にいるか考えながら解くといいぞ！"
        }else if quizName == "math"{
            textFild.text = "英語で数字の計算問題が読み上げられます。正解だと思う数字を選び、タップしよう！計算を間違わないように注意だ！"
        }else if quizName == "shopping"{
            textFild.text = "音声で、自分が買うものが読み上げられます。正解だと思うものをタップしていこう！選択肢は毎回8つあるぞ！"
        }else if quizName == "time"{
            textFild.text = "音声で、「今の時刻はいつなのか」が説明されます。時刻が正しいと思うイラストをタップしよう！昼か夜かの違いも読み上げられるので注意！"
        }
            
        
        
    }
    

    //    値渡し
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "Segue3") {
                let NCViewController = segue.destination as! FreeQuiz3QuestionViewController
                NCViewController.quizName = quizName
                NCViewController.quizType = quizType
                NCViewController.storyMode = storyMode
            }else if (segue.identifier == "Segue4") {
                let NCViewController = segue.destination as! FreeQuiz4QuestionViewController
                NCViewController.quizName = quizName
                NCViewController.quizType = quizType
                NCViewController.storyMode = storyMode
            }else if (segue.identifier == "Segue8") {
                let NCViewController = segue.destination as! FreeQuiz4QuestionViewController
                NCViewController.quizName = quizName
                NCViewController.quizType = quizType
                NCViewController.storyMode = storyMode
            }else if (segue.identifier == "SegueA") {
                let NCViewController = segue.destination as! FreeQuiz4QuestionViewController
                NCViewController.quizName = quizName
                NCViewController.quizType = quizType
                NCViewController.storyMode = storyMode
            }else if (segue.identifier == "SegueB") {
                let NCViewController = segue.destination as! FreeQuiz4QuestionViewController
                NCViewController.quizName = quizName
                NCViewController.quizType = quizType
                NCViewController.storyMode = storyMode
            }else if (segue.identifier == "SegueC") {
                let NCViewController = segue.destination as! FreeQuiz4QuestionViewController
                NCViewController.quizName = quizName
                NCViewController.quizType = quizType
                NCViewController.storyMode = storyMode
            }else if (segue.identifier == "SegueD") {
                let NCViewController = segue.destination as! FreeQuiz4QuestionViewController
                NCViewController.quizName = quizName
                NCViewController.quizType = quizType
                NCViewController.storyMode = storyMode
            }else if (segue.identifier == "SegueE") {
                let NCViewController = segue.destination as! FreeQuiz4QuestionViewController
                NCViewController.quizName = quizName
                NCViewController.quizType = quizType
                NCViewController.storyMode = storyMode
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
}
