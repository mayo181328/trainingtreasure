//
//  PracticeFreeViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/11/23.
//

import UIKit
import AVFoundation
import RealmSwift

let MessageArray = [["問題は間違えても","正解するまで挑戦できるぞ！"],
                    ["時刻の問題は","「昼か夜か」にも注意だ！"],
                    ["ストーリーを進めると,","EXERCISESに変化が起きるぞ"],
                    ["自分のキャラクターは","いつでも見た目を","変えることができるぞ！"],
                    ["ストーリーをクリアすると","キャラクターの服装や","アクセサリーが増えていくぞ"],
                    ["難しい問題は","WEAKコーナーで対策だ！"],
                    ["Storyの,2週目や3週目を","クリアすることで…！？"],
                    ["設定画面で,BGMや効果音、","ボイスの調整ができるぞ！"],
                    ["キャラクターの名前は","設定画面でいつでも","変えることができるぞ！"],
                    ["ステージの最後には","BOSSが現れるぞ！","倒して豪華報酬をGETだ！"],
                    ["ガシャを引くことで","キャラクターのアイテムが","GETできるぞ！"],
                    ["アクセントの問題は","何回もListen againを","押して聞きなおしてみよう！"],
                    ["fifteenやfiftyなどが","間違いやすいので注意だ！"],
                    ["Storyは,1日1ステージ進めて","毎日挑戦し,クリアを目指そう！"],
                    ["国名は国旗の知識が必要だ！","国旗を調べながら解こう！"],
                    ["カバンの中身問題は","何個入っているかがポイント","数字を聞いて解いてみよう"],
                    ["道案内の問題は","rightとleftがポイントだ！","どちら向きか確認しよう！"],
                    ["WORDは,いつでも","気軽にプレイできる！","しっかりと単語を覚えて","ストーリーに挑戦だ！"],
                    ["ストーリーモードでは","世界を旅する海賊になれる！","全世界制覇を目指して","いざ出発だ！！！"],
]


class PracticeFreeViewController: UIViewController , AVAudioPlayerDelegate,ButtonTapDelegate ,CancelTapDelegate{
    
    
    
    var player : AVAudioPlayer!
    
    
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!
    @IBOutlet weak var cancelBarView: CancelBarView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        underBar.delegate = self
        cancelBarView.delegate = self
        writeTopBar()
        writePreparationCancelBar()
        writeCancelBar()

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
    

    
    @IBAction func Free1Button(_ sender: Any) {
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
        self.performSegue(withIdentifier: "Segue1", sender: nil)
    }
    @IBAction func Free2Button(_ sender: Any) {
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
        self.performSegue(withIdentifier: "Segue2", sender: nil)
    }
    @IBAction func Free3Button(_ sender: Any) {
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
        self.performSegue(withIdentifier: "Segue3", sender: nil)
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
