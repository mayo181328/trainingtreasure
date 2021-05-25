//
//  StoryWordViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/22.
//

import UIKit
import RealmSwift
import AVFoundation

class StoryWordViewController: UIViewController , AVAudioPlayerDelegate{
    
    var player : AVAudioPlayer!
    var storyMode : Bool = true
    
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var Label4: UILabel!
    @IBOutlet weak var Label5: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetLabel()
    }
    

    @IBAction func startButton(_ sender: Any) {
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
        self.performSegue(withIdentifier: "Segue", sender: nil)
    }
    
    //    値渡し
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "Segue") {
                let NCViewController = segue.destination as! PracticeWordQuestionViewController
                NCViewController.storyMode = storyMode
            }
        }
    
    func SetLabel() {
        let realm = try!Realm()
        let cheack = realm.objects(Player.self).last
        print(cheack?.MyStage)
        switch cheack?.MyStage {
        case "Japan":
            Label1.text = "1.食事の英単語"
            Label2.text = "2.職業の演習問題"
            Label3.text = "3.生き物の英単語"
            Label4.text = "4.国名の演習問題"
            Label5.text = "5.自然の英単語"

        case "China":
            Label1.text = "1.お仕事の英単語"
            Label2.text = "2.料理の演習問題"
            Label3.text = "3.時間の英単語"
            Label4.text = "4.スポーツの演習問題"
            Label5.text = "5.食事の英単語"
        case "Australia":
            Label1.text = "1.身の回りの物の英単語"
            Label2.text = "2.職業の演習問題"
            Label3.text = "3.生き物の英単語"
            Label4.text = "4.アクセントの演習問題"
            Label5.text = "5.時間の英単語"
        case "India":
            Label1.text = "1.食事の英単語"
            Label2.text = "2.状況判断の演習問題"
            Label3.text = "3.お仕事の英単語"
            Label4.text = "4.食事の演習問題"
            Label5.text = "5.自然の英単語"
        case "Africa":
            Label1.text = "1.お仕事の英単語"
            Label2.text = "2.カバンの中身の演習問題"
            Label3.text = "3.人と生活の英単語"
            Label4.text = "4.国名の演習問題"
            Label5.text = "5.生き物の英単語"
        case "Europa":
            Label1.text = "1.動詞の英単語"
            Label2.text = "2.時間の演習問題"
            Label3.text = "3.学校の英単語"
            Label4.text = "4.アクセントの演習問題"
            Label5.text = "5.身の回りの物の英単語"
        case "America":
            Label1.text = "1.算数の英単語"
            Label2.text = "2.食事の演習問題"
            Label3.text = "3.旅の英単語"
            Label4.text = "4.買い物の演習問題"
            Label5.text = "5.学校の英単語"
        case "Brazil":
            Label1.text = "1.身の回りの物の英単語"
            Label2.text = "2.カバンの中身の演習問題"
            Label3.text = "3.動詞の英単語"
            Label4.text = "4.道案内の演習問題"
            Label5.text = "5.人と生活の英単語"
        case "南極":
            Label1.text = "1.旅の英単語"
            Label2.text = "2.時間の演習問題"
            Label3.text = "3.身の回りの物の英単語"
            Label4.text = "4.算数の演習問題"
            Label5.text = "5.状態の英単語"
        case "宇宙":
            Label1.text = "1.算数の英単語"
            Label2.text = "2.買い物の演習問題"
            Label3.text = "3.動詞の英単語"
            Label4.text = "4.道案内の演習問題"
            Label5.text = "5.状態の英単語"
        default:
            print("error")
        }
    }

}
