//
//  TutorialMovieViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/10.
//

import UIKit
import AVFoundation
import RealmSwift

class TutorialMovieViewController: UIViewController , AVAudioPlayerDelegate{
    
    var player : AVAudioPlayer!
    
    @IBOutlet weak var textFild: UITextView!
    @IBOutlet weak var storyImage: UIImageView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        let realm = try!Realm()
        let playerData = realm.objects(Player.self)
        let myName = String(playerData.last?.MyName ?? "名前がありません")
        super.viewDidLoad()
        startButton.isHidden = true
        storyImage.image = UIImage(named: "storycard1b")
        textFild.text = "\(myName)「ふわぁ～……」\nいつもと変わらない朝。\n今日も平和な一日が始まる…\nと思っていたら、まくらもとには見知らぬ宝箱が！\n\(myName)「なんだろう…これ…」\n手をのばして開けてみる。\nすると…\n？？？「ぷはぁ～～～！！！」\n\(myName)「！？」\n中から変な生物(?)が飛び出してきた！\n\(myName)「なになに！？何が起こったの！？」\n？？？「やあ！ボクの名前は“パス”！パスくんって呼んでね！」\n\(myName)「しゃべった！？」\nよく見ると、お腹にコンパスのようなものがついている…\nパスくん「ん？宝箱の中に入っていた手紙は君当てかな？」\nパスくんは手紙を差し出してきた。\n\(myName)「手紙？一体誰からだろう…」\n"

    }
    
    @IBAction func nextButton(_ sender: Any) {
        let realm = try!Realm()
        let playerData = realm.objects(Player.self)
        let myName = String(playerData.last?.MyName ?? "名前がありません")
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = 0.1
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
        nextButton.isHidden = true
        startButton.isHidden = false
        storyImage.image = UIImage(named: "storycard2b")
        
        textFild.text = "「“冒険の始まり”\n宝箱に入っていた“パスくん”と“船”はキミへのプレゼントだ。\nいっしょに旅に出て、世界中の“宝”を集めるのだ！\n旅が終わるころには、すばらしい“成長”と“出会い”がキミを待っているだろう…。」\n\n\(myName)「旅？世界？？宝！！？」\nお父さん「お？？？なんだかおもしろそうなことになってるな！」\nお母さん「いってみてもいいんじゃないかしら。」\nパスくん「それじゃあ、ボクがおともするよ！」\n\(myName)「うん…行ってみたい！」\nお母さん「くれぐれも、気を付けるのよ気をつけて行ってらっしゃいね～！」\n\(myName)「わかった。ありがとう！いってきます！！！」\n\nこうして、両親に見送られながら、\n\(myName)はパスくんとともに、世界をめぐる旅へ出かけることとなった…。\n\n大冒険の始まりである！\n"
    }
    

    @IBAction func StartButton(_ sender: Any) {
        let soundURL  = Bundle.main.url(forResource: "decision", withExtension: "mp3")
        do{
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = 0.1
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
        self.performSegue(withIdentifier: "Segue", sender: nil)
    }

}
