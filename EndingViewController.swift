//
//  EndingViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/05/03.
//

import UIKit
import RealmSwift
import AVFoundation

class EndingViewController: UIViewController {

    
    @IBOutlet weak var textFild: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try!Realm()
        let playerData = realm.objects(Player.self)
        let myName = String(playerData.last?.MyName ?? "名前がありません")
        textFild.text = "（回想）\n\(myName)「旅？世界？？宝！！？」\nお父さん「お？？？なんだかおもしろそうなことになってるな！」\nお母さん「いってみてもいいんじゃないかしら。」\nパスくん「それじゃあ、ボクがおともするよ！」\n\(myName)「うん…行ってみたい！」\nお母さん「くれぐれも、気を付けるのよ」\n\(myName)「わかった。ありがとう！いってきます！！！」\n父「お前に届いたあの宝箱、覚えてるか？」\n\(myName)「もちろん！」\n母「あれはね～、私たちが用意したものだったの！」\n\(myName)＆パスくん「ええ～～～！！？」\n父「あの日、お前を見送ったあとに実は父さんたちも出発してたんだ」\n\(myName)「えっ！？そうなの？」\n母「\(myName)の後ろを追いかけてたのよ～！気がつかなかったでしょ！」\nパスくん「じゃ、じゃあもしかして、ボクにメッセージを送ってきてたのも…」\nジンバル「わしじゃな！ちょいと機能をいじらせてもらったんじゃ」\n母「バミューダ海域なんて本当に危なかったのよ～！」\n\(myName)「たしかにあのメッセージがなかったらやばかったね…」\n父「まあ途中からはお前らのこと追い抜いてたんだけどな！」\n母「うふふ、わざと目立つように動いて、逆に\(myName)に追いかけられる番になってたってわけ！」\nパスくん「だから伝説の海賊の目撃情報がいっぱいあったのか！」\n\(myName)「ねえ、その“伝説の海賊”って一体何なの？」\n父｢ふっふっふ、伝説の海賊っつうのはな、俺らの昔の通り名のことだよ｣\nジンバル｢お主が産まれるずっと昔に、わしら3人で世界中、いや宇宙中を旅してたんじゃ｣\n父「いや～～、やんちゃしてたな！」\n母「うふふ、良くも悪くも有名になっちゃったわね」\nパスくん「い、一体どんなことをしてたんだ…」\n想像して少しこわくなる。\n父「さて、\(myName)。ここまで旅をしてみて、どうだった？」\n\(myName)「うーん、大変なこともたくさんあったけど…。でも、とっても楽しかったよ！」\nパスくん「お宝もたーくさん手に入ったしね！」\n父「はっはっは！そうだな！」\nお父さんが力強く笑い、一呼吸置いてこう言った。\n父「私たち伝説の海賊から\(myName)へ贈るお宝は、その“成長”と“思い出”さ」\n父「この旅を経て、お前たちはとても大きく成長した。それはこうして戦ってみてよくわかったよ」\n\(myName)「成長…！えへへ！」\n母「友だちも大事にできて、冒険もできて、\(myName)ったら、すーっごく大人になった気がするわ～！お母さん嬉しい！」\nお父さんにはガシガシと頭をなでられて、お母さんはぎゅっと抱きしめてくれた。\n久しぶりに感じる家族のぬくもりに、ほっこりしていると、\nパスくん「ええ～！お宝ってそれだけ！？もっと他にないの～！！？」\nじたばたとあばれるパスくん。\n彼のがめつさは、感動シーンでもおかまいなしだった。\n\(myName)「ぱ、パスくん…」\nジンバル「ふむ、さすがといったところじゃな」\n父「はっはっは！！いいじゃないか！お宝を求めるその気持ち！俺は好きだぞ！」\n母「うふふ、形のあるお宝も、もちろん用意してあるわよ～！」\nパスくん「わわっ、なにこれ！とってもきれい！」\nお母さんがくれたのは、きらきらと輝く、小さな箱だった。\n細かい模様がついていて、とっても立派なものだということがすぐにわかった。\n母「これはね、私たちの冒険の思い出をテーマにつくった、世界で一つのオルゴールなの」\n\(myName)「へえ～！オルゴール！」\nパスくん「しかも世界で一つの、伝説の海賊たちがつくったオルゴールだよ！」\n父「はっはっは！すげえお宝だろ？大切にするんだぜ」\n\(myName)＆パスくん「うん！！」\nあばれていたパスくんも、すっかりごきげんになっていた。\n父「…さて！旅も終わったことだ。我が家に帰るとするか～！」\n\(myName)「…うん！！！」\nジンバル「“家に帰るまでが遠足“と言うからのう。最後まで気をつけねばならんぞ」\n母「冒険の終わりをお祝いして、帰ったらごちそう作るからね～！」\n\(myName)＆パスくん「やった～～～！！！」\n\n船に乗り込み、空へと泳ぎ出す。\n\n何千キロと旅をしてきた船が、\n最後に向かう先は決まっている。\nすべてはそこから始まったのだから。\nたくさんのお宝と、ほんのちょっとの勇気を手に入れて\n家族と、そしてともだちと一緒に\nあたたかくて、懐かしい、我が家へと帰っていく。\n"

    }
   
    
    
    
    @IBAction func BackSegue(_ sender: Any) {
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
        let url = Bundle.main.bundleURL.appendingPathComponent("mainBGM.mp3")
                do {
                    let realm = try!Realm()
                    let SoundData = realm.objects(Player.self).last
                    try BGMplayer = AVAudioPlayer(contentsOf: url)
                    player.delegate = self
                    player.volume = Float(0.5 * SoundData!.BGM)
                    player?.play()
                } catch {
                    print("Error")
                }
                BGMplayer!.play()
                BGMplayer!.numberOfLoops = -1
        self.performSegue(withIdentifier: "Segue", sender: nil)
    }

}
