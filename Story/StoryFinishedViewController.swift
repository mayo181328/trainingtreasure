//
//  StoryFinishedViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/22.
//

import UIKit
import RealmSwift
import AVFoundation

class StoryFinishedViewController: UIViewController , AVAudioPlayerDelegate,cancelTapStoryDelegate{
 
    
    
    var player : AVAudioPlayer!
    
    @IBOutlet weak var areaNumber: UILabel!
    @IBOutlet weak var stageNumber: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var areaImage: UIImageView!
    @IBOutlet weak var textFild: UITextView!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    @IBOutlet weak var messageView: ClearMessageView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NextButton.isHidden = true
        cancelButton.isEnabled = false
        dataSet()
        messageView.delegate = self
        textFild.isEditable = false
        
        let realm = try! Realm()
        let playerData = realm.objects(Player.self).last
        try! realm.write {
            playerData?.MyCoin = playerData!.MyCoin + 100
            playerData?.MyScore = playerData!.MyScore + 100
            playerData?.MyJewel = playerData!.MyJewel + 1
        }
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
    }
    

    func dataSet(){
        let realm = try!Realm()
        let playerData = realm.objects(Player.self)
        let myName = String(playerData.last?.MyName ?? "名前がありません")
        if playerData.last!.MyStage == "Japan"{
            areaNumber.text = "1"
            areaLabel.text = String((playerData.last!.MyStage)!)
            areaImage.image = UIImage(named: "Japan_world")
            switch playerData.last!.MyStageNumber{
            case 1:
                stageNumber.text = String(playerData.last!.MyStageNumber)
                areaLabel.text = "東京"
                areaImage.image = UIImage(named: "Japan_world1")
                textFild.text = "\(myName)とパスくんは、なんと、英語のちからでモンスターたちをたおした！\n\(myName)「ほ…ほんとにたおせちゃった！」\nパスくん｢なかなかやるね！これは楽しい冒険になりそうだよ！｣\n\(myName)｢よーし…このままの勢いでどんどん行くぞーっ！｣\nパスくん｢おっとっと、そう焦らないで！初めての冒険だし、そうとう疲れてるんじゃない？｣\n\(myName)「そう言われれば…ふぁ～～あぁ…いっぱい動いて疲れたし、すごく眠い。」\nパスくん「今日はここまでにしようか。一歩一歩、少しずつ進んでいこう！」\n\n※ストーリーモードに挑戦できるのは、一日１エリアまでだ！また明日挑戦しよう。\n"
            case 2:
                stageNumber.text = String(playerData.last!.MyStageNumber)
                areaLabel.text = "愛知"
                areaImage.image = UIImage(named: "Japan_world2")
                textFild.text = "モンスターたちを退治（たいじ）した\(myName)とパスくん。\nしかし、宝箱はモンスターたちが持って行ってしまった…。\nパスくん「あ！コラ！待て～～～！！！」\n\(myName)「行っちゃった…。またモンスターに邪魔されちゃったね」\nパスくん「あいつらなんで邪魔してくるんだ～？？？」\n\(myName)「文句いってもしょうがないか。先に進むしかないよね。」\nパスくん「…うん！それにしても\(myName)、この前よりもおちついていたね！」\n\(myName)「でしょ？やりかたもわかってきたし、パスくんも一緒だから心強いよ！」\nパスくん「ボクたちいいコンビかもしれないね！」\n\(myName)｢そうだね。｣\n\nカタカタ…！\n\n\(myName)「！！！」\nその時、パスくんのお腹の針が動いた！\nパスくん「目的地に針が反応している！次は、えっと…大阪だ！」\n"
            case 3:
                stageNumber.text = String(playerData.last!.MyStageNumber)
                areaLabel.text = "大阪"
                areaImage.image = UIImage(named: "Japan_world3")
                textFild.text = "結局モンスターたちを追い払った\(myName)とパスくん。するとそこの店長が…\n店長「おおきに！あいつらが店の前で邪魔するもんやから、困っとったんや！お礼にうちの自慢の料理食うていき！」\n\(myName)「え！いいんですか！それじゃあお言葉に甘えて…」\n\(myName)&パスくん「うんまぁ～～～いっ！！！」\n\(myName)「タコ焼きにお好み焼きに…おいしいものがいっぱいだ！」\n\(myName)「…ってパスくん、食べ過ぎじゃない？」\nパスくん「えぇ？そうかなぁ？」\n\(myName)「すごいお腹…。」\nパスくん「お腹いっぱいで眠くなってきちゃった…。今日はここまでにしない？」\n\(myName)（こんな調子で大丈夫かなぁ…）\n"
            case 4:
                stageNumber.text = String(playerData.last!.MyStageNumber)
                areaLabel.text = "福岡"
                areaImage.image = UIImage(named: "Japan_world4")
                textFild.text = "\(myName)「空気がキレイなせいか、モンスター達もいきいきしてた気がするなぁ…」\nパスくん「そうだね…一気に疲れちゃった…」\n\(myName)「また襲われないよう、神社にお参りしておこう。」\nぱち、ぱち！\n二回おじぎをして、二回手を叩いた！\nパスくん「モンスターに襲われませんようにー！！！」\n\(myName)「なんだか物騒（ぶっそう）なお願い事だなぁ…」\nパスくん「最後に一回おじぎして、おしまい！」\n\(myName)「二礼二拍手一礼（にれいにはくしゅいちれい）だっけ。神様が守ってくれるといいね！」\n"
            case 5:
                stageNumber.text = String(playerData.last!.MyStageNumber)
                areaLabel.text = "屋久島"
                areaImage.image = UIImage(named: "Japan_world5")
                textFild.text = "ボス「あんたら、良いコンビじゃないか。じゅうぶんだ。そこに宝がある。持っていきな。」\n\(myName)&パスくん「やった～～～！！！」\nボス「宝があるのは日本だけじゃないってのは、知ってるね？」\n\(myName)「うん。これからは世界に旅立つつもりだよ！」\nボス「なら、次の国に行く前に、うちでゆっくり休んでいきな。」\n\(myName)「え！？いいんですか！？ぜひお願いします！」\nパスくん「どんなごちそうが出てくるんだろう…ジュルリ」\n\(myName)「…こら！」\n"
            default:
                print("error")
            }
        }else if playerData.last?.MyStage == "China"{
            areaNumber.text = "2"
            switch playerData.last?.MyStageNumber{
            case 1:
                stageNumber.text = String(playerData.last!.MyStageNumber)
                areaLabel.text = "韓国"
                areaImage.image = UIImage(named: "China_world1")
                textFild.text = "パスくん「船酔いしながら、よく戦えたね…」\n\(myName)「逆に船酔いが吹き飛んだよ！いい運動になった！」\n\(myName)「改めて見てみると、ここはふんいきがちょっと日本に似てるね」\nパスくん「うん！韓国も日本も、同じ“東アジア”に属しているからね！といっても、東アジアも広いよ～？まだまだ旅は続きそうだね！」\n\(myName)「なんか、ワクワクしてきた！」\nパスくん「ボクも！初めての外国で、気分がアガってきた！」\n\(myName)「よしっ！行くぞー！！」\nパスくん「調子に乗って、また船酔いしないでよね」\n\(myName)「わ、わかってるよ…」\n"
            case 2:
                stageNumber.text = String(playerData.last!.MyStageNumber)
                areaLabel.text = "北京"
                areaImage.image = UIImage(named: "China_world2")
                textFild.text = "北京は予想以上の広さで、宝探しをしていたらあっという間に日が暮れてしまった…\n\(myName)&パスくん「ひ、広い～～～！！！」\nパスくん「さすがに今日はここまでかな…やっぱり宝さがしは一苦労だね～。」\n\(myName)「そうだね。歩き疲れちゃった…」\nパスくん「ボクも”飛び疲れ”ちゃった…」\n\(myName)「え？…飛んでても疲れるの？」\nパスくん「そりゃそうさ！むしろ、歩くよりもエネルギー使うんだからね！」\n\(myName)「じゃあ、歩けばいいんじゃない？」\nパスくん「歩いててもつかれるでしょ！」\n\(myName)「…じゃあなんで飛んでるの！？」\nパスくん「それは…なんか、他に飛んでる生き物って少ないから、目立ちたいじゃん！」\n\(myName)「も～、見栄（みえ）張っちゃって…」\n"
            case 3:
                stageNumber.text = String(playerData.last!.MyStageNumber)
                areaLabel.text = "上海"
                areaImage.image = UIImage(named: "China_world3")
                textFild.text = "モンスターたち「や…やられた～…」\n\(myName)「びっくりした～！かわいい動物かと思ったら、急におそいかかってくるんだもん」\nパスくん「も～！みとれるならボクにしておいてよね！わかった？」\n主人公「あ！！！」\nパスくん「えっ、なに！？」\n主人公「見て！パンダが逆立ちしてる！かわいい～～～！！！」\nパスくん「なっ！？ボクだって逆立ちできるよ！ほら、見て！！！」\n主人公「うわああーーー！」\nパスくん「今度はなに！？」\n主人公「ちっちゃいパンダが何回もでんぐり返ししてる！かわいい～～～！！！」\nパスくん「なっ…！？ぼ、ボクだって…でんぐり返しぐらい…！ほ、ほらぁ！！！」\n\(myName)「あ！パンダが逃げちゃう！待て～～～！！！」\nパスくん「…」\n"
            case 4:
                stageNumber.text = String(playerData.last!.MyStageNumber)
                areaLabel.text = "香港"
                areaImage.image = UIImage(named: "China_world4")
                textFild.text = "\(myName)「普通に楽しんで運動しちゃった…」\nパスくん「この街は活気（かっき）づいてるね～」\n\(myName)「なんだかエネルギーをもらったよ！これからの旅も、楽しみながら進んでいこう！」\nパスくん「そうだね！せっかく世界中を旅してるんだ。楽しまなきゃソンソン！」\n\(myName)「でも、たくさん動いて疲れちゃったし、今日はゆっくりしようか」\nパスくん「誰かさんが運動に誘うから、ボクまでヘトヘトだよ～」\n\(myName)「え？パスくんも楽しんでなかった？」\nパスくん「正直言っていい？」\n\(myName)「うん。」\nパスくん「…めちゃくちゃ楽しかった。」\n\(myName)「だよね～！」\n"
            case 5:
                stageNumber.text = String(playerData.last!.MyStageNumber)
                areaLabel.text = "台湾"
                areaImage.image = UIImage(named: "China_world5")
                textFild.text = "\(myName)&パスくん「どうだ！！！」\nボス「うむ…どうやら実力はホンモノのようだ。キミたちにならこれを渡してもいいだろう。」\nパスくん「ふう！この大陸の反応は、やっぱり今の宝で間違いなかったみたい！」\nパスくん「次は…オーストラリアだね。」\n\(myName)「てことは…また船に乗って移動だね…船酔いしそう～」\n\(myName)「パスくん、ワープとか使えないの？あと瞬間移動（しゅんかんいどう）とか！」\nパスくん「キミ…ボクの事なんだと思ってるの…？」\nボス「ん？君、船酔いしやすいのかい？」\n\(myName)「そうなんです。この前も散々（さんざん）で…」\nボス「なら、私が船を改造（かいぞう）してやろう。サスペンションをつければ、ゆれもマシになる」\n\(myName)「さすぺん…？」\nボス「サスペンションというのは、簡単にいえば衝撃（しょうげき）を吸収してくれる装（そうち）のことさ。船酔いもしなくなるだろうよ」\n\(myName)「本当ですか！？よかった～！」\nパスくん「これで船の旅が楽になるね！ボクも自慢の船が進化してうれしいよ！」\n\(myName)「よーし早速次のお宝をさがそう！どんどんいこう！」\nパスくん「船酔いの恐怖がなくなったから急に元気になったなあ…。さて次の場所は…」\n\(myName)（わくわく）\nパスくん「あ…こ…これは………！！！」\n"
            default:
                print("error")
            }
    }else if playerData.last?.MyStage == "Australia"{
        areaNumber.text = "3"
        switch playerData.last?.MyStageNumber{
        case 1:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "バミューダ海域"
            areaImage.image = UIImage(named: "Australia_world1")
            textFild.text = "パスくん「\(myName)、大丈夫！？」\n\(myName)「うん…なんとか」\nパスくん「どうやら無事にオーストラリアに着いたみたいだよ！」\n\(myName)「パスくんのお腹に出てきたあの文字がなければ、本当に危なかったかもね」\nパスくん「うん…ボクもあんなの初めてだよ。誰から送られてきたかもわからない」\n\(myName)「助けてくれたあのメッセージ…一体なんだったんだろう」\nパスくん「何はともあれ、陸地に着いた！危険な航海とは、しばらくおさらばかな？」\n\(myName)「海って本当に危険なんだね…。今まで平和な航海だったから、余計にびっくりしちゃった」\nパスくん「スリル満点の船の旅だったね…」\n"
        case 2:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "シドニー"
            areaImage.image = UIImage(named: "Australia_world2")
            textFild.text = "シドニーで宝さがしをしていた二人、しかし…\nパスくん「あ！」\n\(myName)「え！？どうしたの？」\nパスくん「うっかりしてた…反応があったのはキャンベラのほうみたいだ！」\n\(myName)「そうなの！？二人とも都市を間違えて、うっかりさんだね」\nパスくん「ごめんごめん。明日はキャンベラへ向かおう！でも、今日はシドニーの街を楽しもうよ！\n\(myName)「そうだね。いっぱい遊んで、ゆっくりやすんで、冒険はそれからだ！」\nパスくん「おー！」\nパスくん（そういえばあれからお腹のメッセージは来る気配（けはい）がない…一体なんだったんだろう…）\n"
        case 3:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "キャンベラ"
            areaImage.image = UIImage(named: "Australia_world3")
            textFild.text = "モブ「なんだ。宝を探しに来た旅人さんだったの？」\nパスくん「そうだよ！このお腹のコンパスがキャンベラを…ってあれ？」\n\(myName)「どうしたの？」\nパスくん「…次はメルボルンの方角を指してる」\n\(myName)「結局、オーストラリアの首都の候補（こうほ）、全部回ることになったじゃないか～！」\nモブ「小さいのによくがんばるね～！」\n\(myName)「パスくん、小さいって言われてるよ…？（ヒソヒソ）」\nパスくん「え？キミに言ったんじゃないの…？（コショコショ）」\n"
        case 4:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "メルボルン"
            areaImage.image = UIImage(named: "Australia_world4")
            textFild.text = "\(myName)「結局カフェに入りそびれちゃった…パスくん、お腹のコンパスはどう？」\nパスくん「これは…えぇ！？」\n\(myName)「どうしたの？」\nパスくん「コンパスの針がエアーズロックの頂上を指してる…」\n\(myName)「エアーズロックって…“地球のへそ”って言われてる？」\nパスくん「これは大変な登山になりそうだ…」\n\(myName)「ひええ…」\n"
        case 5:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "エアーズロック"
            areaImage.image = UIImage(named: "Australia_world5")
            textFild.text = "\(myName)&パスくん「や、やったぁ～～～！」\n\(myName)「苦労したけど…お宝ゲットだね！」\nパスくん「今回は一段とハードだったね…」\n\(myName)「でも、こうしちゃいられない。メッセージにもあったとおり、宝は待っててくれないかもしれないんだ！急がなくちゃ！」\nパスくん「うん。次は南アジアを指してるから、また長い船の旅になるよ！まずは、このエアーズロックを降りるところからだね。行こう！」\nそう思い立ち、下を見る二人。\n\nヒュウゥ～～～…\n\n\(myName)&パスくん「…」\nパスくん「め、めちゃくちゃ高い～～～…！！！！」\n\(myName)「降りるのも一苦労だね…」\nパスくん「…ねぇ、やっぱりボクだけ飛んでいっちゃだめ？」\n\(myName)「絶対ダメ。」\nパスくん「は～い…」\n"
        default:
            print("error")
        }
    }else if playerData.last?.MyStage == "India"{
        areaNumber.text = "4"
        switch playerData.last?.MyStageNumber{
        case 1:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "スリランカ"
            areaImage.image = UIImage(named: "India_world1")
            textFild.text = "\(myName)「もーっ！！びっくりした〜！！」\nパスくん「急に襲いかかってくるなんてズルいよ！」\n\(myName)「そうだそうだ！...でも、ちょっと気がゆるんでたかな。」\nパスくん「うん...そうだね。旅には慣れてきたけど、油断せずにいきたいね。」\n\(myName)「うん！」\n\nモンスターとのバトルにも慣れてきたけど、お宝を探し出すにはまだまだ実力が足りないみたいだ。お宝に近づくまで、じぐざぐに進んで探している。\nここにはお宝はなかった。パスくんのお腹の針にあわせて次の土地に行かなくちゃ！\n\n\(myName)「…で、なんだっけ？スリランカの首都」\nパスくん「スリジャヤワルダナプラコッテ」\n\(myName)「すじりゃなや………い、言えない…」\n"
        case 2:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "インド"
            areaImage.image = UIImage(named: "India_world2")
            textFild.text = "どうにかモンスターをやっつけた。\nということは......やる事は1つ！！\n\n…\n......\n\(myName)「ごちそうさまでした！インドのカレーって、日本のものと全然違うんだなあ…。」\nパスくん「そうだね、でもおいしかった～♪ごちそうさまでした〜！」\n\(myName)「…あっ！！カレーに夢中になっちゃったけど、お宝をさがさなきゃ！コンパスの針はどう？」\nパスくん「ざんねんながら反応はないんだ…。ここにお宝は無いみたいだね。」\n\nたしかに、インドに着いたときと比べて、コンパスの針はほとんど動いてないように見えた。\n\(myName)「うーん…。よし！美味しいものも食べたことだし、頑張ろう！」\nパスくん「そうだね！がんばろ～！」\n"
        case 3:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "バングラディシュ"
            areaImage.image = UIImage(named: "India_world3")
            textFild.text = "なんとか騒ぎを落ち着かせてもらって、誤解をといて、一通りたくさんの質問に答えたけれど、お宝にありつけるような情報を持っている人はいなかった。\n\nただ、町の人たちの何人かが、「世界中のお宝を集めるって…」とひそひそ話し合っていたから話をきいてみた。\n\n「かなり前になるけど、世界中のお宝を探してた海賊がいたんだよ。」\n「まあ別にここにお宝があるわけじゃないんだけどさ」\n「そのお仲間かと思ったんだよ」\n\n主人公「なるほど…。でも、ここには初めて来たから。」\nパスくん「うんうん。それはボクたちじゃないなあ…。」\nいろいろ誤解があったけど、心配してくれた人たちにお礼を言って、町を出た。\n \n\(myName)「うーん、このあたりにはないみたいだね…」\nパスくん「この土地で探すのは、なかなか難しいかもしれないね。頑張りどころだね！」\n\(myName)「うん！絶対にお宝を見つけるぞ～！」\nパスくん「ナビももっともっと頑張るね！明日も頑張ろう～！」\n"
        case 4:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "ブータン"
            areaImage.image = UIImage(named: "India_world4")
            textFild.text = "\(myName)「うーん、ここでもなかったかあ…」\n \nがんばろうって意気込んでいたところで見つからなかったからすこし残念に思ってしまったけれど、そんなとき、パスくんの針がより力強く指していることに、針がかたかたと揺れる音で気が付いた！！\n \nパスくん「見て！！さっきよりも近くなっているみたい！」\n\(myName)「よーし、お宝をたっくさん見つけて、たっくさん探して、幸せになろう！」\nパスくん「そうだね！」\n"
        case 5:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "エベレスト"
            areaImage.image = UIImage(named: "India_world5")
            textFild.text = "遊びながら進んでいると、ついにお宝を発見した！\nお宝をおすそ分けしようかと思ったけど、いいんだと断られた。山を登ることを手伝うのが大好きで、この山に来てくれたことと、一緒に遊んでくれたことが嬉しかったんだって！なんて優しい人なんだろう。\n\nモブ「なかなかやるね！君たちも世界中を旅しているのかい？」\nパスくん「そうだよ！…ん？君たち“も”ってことは…他にも旅をしている人たちがいるの！？」\(myName)「へー！旅の途中で出会うかもしれないね！」\n\nｶﾀｶﾀ…\n急に、パスくんのお腹の針が動き出した…！\n\nパスくん「\(myName)～！次の目的地を受信したよ！」\n\(myName)「えっ、もう！？ごめん！もう行かなくちゃ！」\nモブ「いいよいいよ！大変だろうけど、がんばってね。」\n"
        default:
            print("error")
        }
    }else if playerData.last?.MyStage == "Africa"{
        areaNumber.text = "5"
        switch playerData.last?.MyStageNumber{
        case 1:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "エジプト"
            areaImage.image = UIImage(named: "Africa_world1")
            textFild.text = "寝起きだけど、慣れた動きでモンスターをやっつけた！\nでも、ここにはお宝はなかった…\n\n\(myName)「アフリカって、すっごく広いよね？上手く見つかるかなあ…」\nパスくん「任せてったら！ボクのナビに間違いはないよっ！」\n\(myName)「確かに、今までもパスくんの案内に間違いはなかったよね。」\nパスくん「へへーん！ボクがいれば怖いものなしだ！」\n\(myName)（すぐ調子にのるんだから…）\n"
        case 2:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "マダガスカル"
            areaImage.image = UIImage(named: "Africa_world2")
            textFild.text = "アメール「なかなかやるわね…いいでしょう。あなたに渡してもいいわ。ついてきなさい」\n\nアメールは、町のアメールの家ほうまで案内してくれた。\nちょっと待ってねと言ってきり出てこないので、パスくんとこっそり会話をした。\n\n\(myName)「こ、この大陸のお宝…もう手に入れられるのかな！？」\nパスくん「い、いや…針とは反対方向なんだけど…」\n\(myName)「でもお宝って言ってたよ！？」\n\nするとようやくアメールが箱を持ちながら家から出てきた。 \nアメールが差し出してくれた箱にはビンが入っていた。\nそこには…黒い細長い…なんだこれ？\n\nアメール「全世界の人々が喉から手が出るほど欲しがっている『バニラビーンズ』よ！うちの島で取れるバニラビーンズは最高級なんだから。」\n \nパスくんが「ほら、僕の針が正しいじゃないか」という顔で見てくる…。\nでもすてきなものには違いないから、貰っておこう。ありがとう！\n"
        case 3:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "南アフリカ"
            areaImage.image = UIImage(named: "Africa_world3")
            textFild.text = "モブ「…あとはホレ、こいつがオレの友達のサイードってんだ。いい宝もんだろ！」\n\(myName)「た、確かに。友達は宝ですね…！」\nモブ「あ、まだまだあるぜ～！あと隣の家にいくとな…」\n\nとっても楽しい話をしてくれるけど、この調子だと日が暮れそうだ…。\nパスくん「あ、ああ～～！！申し訳ないけど、もう行かなくっちゃ！残念！」\nモブ「おお、そうか！カゼひくなよ！歯磨いて寝ろよ～！」\n\(myName)「あ、ありがとう～！」\n\n…\n……\n\(myName)「パスくん、ありがとう…。針はどうだい？」\nパスくん「いいって事さ！…うーん、やっぱりこのあたりでもないね。先に進もう！」\n\(myName)「おー！…また明日ね…」\nパスくん「う、うん…今日はもうへとへとだあ…」\n"
        case 4:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "ガーナ"
            areaImage.image = UIImage(named: "Africa_world4")
            textFild.text = "\(myName)「も、もうお腹いっぱい…」\nパスくん「ぼ、ぼくも…」\n \nたくさんの家庭料理とフルーツを食べさせてくれた。ちょうどお腹が減っていたからありがたい。\nモブ「そりゃよかったぜ！！…んで、なんで旅してんだ？」\n\(myName)「世界中のお宝を集めたくって。この近くにあると思うんだけど…」\n \nモブ「んー、財宝！って言えるようなモンはここにはないぞ」\n\(myName)「そっか…それなら、他のところに探しに行かなきゃ。ごちそうしてくれてありがとう。」\nモブ「いいってことよ！この国は旅人大歓迎だから、いつでも帰ってこいよ！またごちそうするぜ！」\n\(myName)「うん！ありがとう！それじゃあね！」\n"
        case 5:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "サハラ砂漠"
            areaImage.image = UIImage(named: "Africa_world5")
            textFild.text = "\(myName)「ふう、今回も無事にお宝をゲットできた！」\nパスくん「やったね！」\n\nモブ「あらあら、そこのあなた」\n\(myName)「こんにちは！」\n \n少し離れた所からやってきた女の人が、パスくんをながめながら言った。\nモブ「珍しいわねえ。似たような生き物を少し前に見たのよ」\n\(myName)「へー！パスくんに似てるって、すっごい偶然だなあ！」\nパスくん「ボクも初めて聞いたよ…！」\nモブ「旅をするなら、慌てずゆっくりね。頑張って」\n\(myName)「ありがとう！」\n \nパスくんのお腹が、今度は違う方向を指しはじめた。行かなくちゃ！\n"
        default:
            print("error")
        }
    }else if playerData.last?.MyStage == "Europa"{
        areaNumber.text = "6"
        switch playerData.last?.MyStageNumber{
        case 1:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "スペイン"
            areaImage.image = UIImage(named: "Europa_world1")
            textFild.text = "今回はお宝は見つからなかった。\nお宝を集めることは楽しいけれど、お宝を探すためにいろんな国をまわって、その違いを知るのも楽しいなあ。\n\n\(myName)「パスくんって、お宝を探すこと以外に好きなことってなんなの？」\nパスくん「うーん、そうだなあ…ごはんを食べることかなっ♪」\n\(myName)「あ～…確かに、インドではしゃいでたもんね」\n\nなるほど、だからあんなに嬉しそうにカレー屋さんを探してたんだ…\n\nパスくん「な、なっ…！？はしゃいでなんかないよ！ただ、その国の本格的なおいしいものはその国でしか食べられないし、立派なお宝だよ！！」\n\(myName)「そっか、そういう考え方もあるね！」\nパスくん「今までに通った土地をもう一度全部めぐって、おいしいものをたくさん食べたいなぁ～！」\n\(myName)「また行けるなら行きたいね！」\nパスくん「うん！」\n\(myName)「またここに来たら、こんどはあの建物は完成してるかな？」\nパスくん「してるといいなあ！また見たいね！」\n\(myName)「うん！そうだね！」\n"
        case 2:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "フランス"
            areaImage.image = UIImage(named: "Europa_world2")
            textFild.text = "ひとまずモンスターをやっつけて、朝ごはんにあり着いた。\nもちろんパスくんは美味しそうにパンを食べていた。\n\nパスくん「ふあ～！最高！おいしかった～♪」\n\(myName)「おいしかったね！」\nパスくん「よし、お宝がないか探してみよう！」\n\(myName)「おー！」\n\nお宝を探してきょろきょろしていると、男の人が話しかけてきた。\n \nモブ「そこの君！遊びにきたのかい？」\n\(myName)「えーっと、この土地のお宝を探してて…」\nモブ「うーん、お宝は、あるにはあるよ。」\n \nあまりにもあっさり言うものだから、びっくりしてしまった。\nでも、あるにはあるって…どういうこと？\n\n\(myName)「えっ！本当！？」\nモブ「うん。でも、お宝って呼べるものは全部美術館にあるからね。とっちゃあダメだよ」\n\(myName)「うーん…そういうものじゃないんだけど…」\nモブ「なら、ここにはないんじゃないかなあ…」\n\(myName)「そっか。ありがとう！」\nモブ「素敵な旅を！」\n \n道のりはまだまだ遠いなあ。次の土地へ行こう！\n \n"
        case 3:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "ドイツ"
            areaImage.image = UIImage(named: "Europa_world3")
            textFild.text = "モンスターをやっつけた！今回は手ごわそうだと思ったけど…なかなか自分もやればできるじゃないか！\nパスくん「お宝のありかには…ちょこっと近づいた…かな？まだまだだね」\n\(myName)「うーん…もっと違う所なのかな？」\n \nお宝の位置を考えながら相談していると、急に人が現れた。\n \nモブ「こらっっ！！こんな時間に子供が何してるの！！」\n\nちょっと心配性そうなおばさんが、こちらを見て大きな声で言った。\n\(myName)「え！えっと、今、旅をしてて…」\nモブ「もうおうちに帰る時間でしょ！おうちの場所、わかる！？」\nパスくん「いや…その…お宝を探す旅を…」\n\nたぶん、この人は、「旅をする」っていうごっこ遊びだと思っているみたいだ。\nモブ「なんですって？遊ぶのもいいけど、時間は守りなさい！ほら、電話したげるから！」\n\(myName)「いや、遊びじゃなくて、このコンパスが指す方向にお宝が…」\nモブ「いい加減になさい！日が暮れちゃったら危ないでしょ！」\n \n本当に旅をしてるんだってば～！！\nこの人、絶対話をわかってくれなさそうだ！\nピンチ！逃げろ～～～！！\n"
        case 4:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "イギリス"
            areaImage.image = UIImage(named: "Europa_world4")
            textFild.text = "モンスターがいることに気づけても、お宝がどこにあるかはさすがに分からない。\n\(myName)「どう？お宝はある？」\nパスくん「いや～…ここじゃないみたいだね」\n\(myName)「違うか～…。仕方ない。進んでいこう」\nパスくん「そうだね！」\n\n…\n……\nしばらく歩いていると、景色が変わってきたように思えた。\n\n\(myName)「パスくん！！！また国が変わったよね！？！？」\nパスくん「…いや、今度は変わってないよ」\n\(myName)「な、なにい～～！？」\n \nうーん…や、やっぱり、国を見定めるスキルはまだまだのようだ…\n"
        case 5:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "ノルウェー"
            areaImage.image = UIImage(named: "Europa_world5")
            textFild.text = "人が集まっているところの近くでお宝をゲットした！やったね！\n \nこの土地では、週に一度だけ「あま～いお菓子を食べても自分を許しちゃえ！デー」があるらしい。\nその買い物で人だかりができていたみたいだ。\n\nモブ「あらそこの坊や、あんたもお菓子を食べるかい？」\n\(myName)「え、いいの？…ありがとう！」\nモブ「あんたの横にいるヘンテコな生き物、ちょいと前に見たんだよ。」\nパスくん「へ、ヘンテコってなんだよ！」\nモブ「んでね、その生き物と一緒にいたのがなんと…かつて全世界に名を残した伝説の男と女の海賊！！本物を見られるなんて思ってもいなかったからよーく覚えてるよ！」\nパスくん「きいてる！？ぼくはヘンテコじゃ…」\n\(myName)「パスくん！ストップストップ！！」\n \n伝説の男と女の海賊だって！すごく気になるけれど、パスくんがいつになく暴れ出しそうだったから、その話を詳しく聞く前に無理やり引っ張って町を出てきてしまった。\n \nパスくん「ふむふむ…！お宝はこれであってるみたいだよ！…でもね、僕はヘンテコじゃ…」\n\(myName)「わ、わかったって！じゃあ、お菓子を食べながら次の土地に出発だ！」\nパスくん「はいはーい…」\n"
        default:
            print("error")
        }
    }else if playerData.last?.MyStage == "America"{
        areaNumber.text = "7"
        switch playerData.last?.MyStageNumber{
        case 1:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "ニューヨーク"
            areaImage.image = UIImage(named: "America_world1")
            textFild.text = "四方八方からやってくるモンスターをやっつけた！\nそれを近くで見ていた人達がおどろいたり、興奮したりして、拍手や歓声をあげていた。\n\nそのあと、お宝探しを際かいしたものの、どこを歩いても高いビルが沢山あって、どこを歩いたのかわからなくなってしまった！\n\n\(myName)「あ、あれ…ここってもう通った道じゃない？」\nパスくん「え、通ってないよ？針はそんなに動いてないからね」\n\(myName)「も～～！わけがわからないよ～～！！」\n\nやっぱり、お宝を探すのはとってもとっても難しそうだ…！！\n"
        case 2:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "カナダ"
            areaImage.image = UIImage(named: "America_world2")
            textFild.text = "\(myName)「もー…立ち止まってたらいけないね。」\nパスくん「う～…ごめんってば…」\n\nモンスターは集まってはきていたけれど、この近くにお宝があるわけではなかった。\n\(myName)「うーん。。お宝はここでもなかったかぁ…」\nパスくん「方角だけで探そうってなると、近くなればなるほど難しいね。」\n \n近づけば近づくほど、少し目的地からずれただけで針が大きくなるんだよなあ…\n\(myName)「ううーん。そのナビ機能、もっとアップグレードできないかな？」\nパスくん「位置情報みたいな！？そんな無茶な～！ぼくはスマホじゃないんだから！」\n\(myName)「スマホもあれば、もっと便利だったね…」\nパスくん「がーん！！スマホに役目をうばわれちゃう！？」\n"
        case 3:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "ロサンゼルス"
            areaImage.image = UIImage(named: "America_world3")
            textFild.text = "パスくん「あれ？おかしいなぁ…」\n\nパスくんがお腹のコンパスをながめて悩んでいる。\n\(myName)「針の動きはかわらないね。」\nパスくん「そうなんだよ。でも、お宝は出てこないね」\n\(myName)「まっすぐこのまま行けばいいのかな？」\nパスくん「そうだと思う。お宝はもうすぐかも！」\n\(myName)「やったー！」\n"
        case 4:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "メキシコ"
            areaImage.image = UIImage(named: "America_world4")
            textFild.text = "モブ「な、なかなかやるじゃねえか…」\nモブ２「お前ほどの実力があるんなら、ここを通すしかねェな！」\nモブ３「旅人さんよォ、足元すくわれないように気をつけなァ！」\n \n謎の漁師さんたちは帰っていった…\n \n\(myName)「な、なんだったんだ…」\nパスくん「すっごく強そうな人たちだったね。でも、負けないくらい僕たちも強くなったんだね！」\n\(myName)「…そう考えると、すごいね！」\nパスくん「そうだよ！この勢いで、全世界をまわることができるさ！」\n\(myName)「なんだかやる気が出てきたぞ！…あ、パスくんのお腹…！」\nパスくん「いよいよ近づいてきたみたいだね…！急ごう！」\n"
        case 5:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "ラスベガス"
            areaImage.image = UIImage(named: "America_world5")
            textFild.text = "モンスターをやっつけると、群れの中からお宝が出てきた！\n\nパスくん「やったね主人公！」\n\(myName)「いや～、一時はどうなることかと思ったよ」\nパスくん「どうにかお宝が手に入ってよかったね！」\n \n無事にお宝をゲットできて喜んでいると、近くにいた使用人さんが話しかけてきた。\n使用人「おやおや、あなたたちも旅をしていらっしゃるんですか？」\n\(myName)「そうなんです！」\nパスくん「…あれ？でも、よくわかりましたね。ここには遊びに来る人のほうが多いのに！」\n使用人「ええ、そうなんですが…あなたがたが乗っている船にとってもよく似た船を、本当についさきほど見かけたんです」\n\(myName)「えええっ！？この船にとっても似てるの！？」\n使用人「はい。この船と同じように、羽が生えていました。」\nパスくん「確かに…羽が生えた船なんて、なかなかないよね！」\n \n自分たちの船にそっくりって、すごく気になるなぁ！\n本当についさっき見たってことは、もうすぐ会えるかもしれない！\n急がなくちゃ！\n"
        default:
            print("error")
        }
    }else if playerData.last?.MyStage == "Brazil"{
        areaNumber.text = "8"
        switch playerData.last?.MyStageNumber{
        case 1:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "リオデジャネイロ"
            areaImage.image = UIImage(named: "Brazil_world1")
            textFild.text = "モブ「負けちゃった！君たち強いね！すごく努力してるのがよくわかったよ！」\n\(myName)「えへへ･･･」\nパスくん「じゃあ約束通り、海賊の情報教えて！」\nモブ「ああそうだったね。私が見たのは、君たちみたいな海賊がサッカーの応援グッズを持っているところだったよ」\n\(myName)「サッカーの応援グッズ･･･？」\nパスくん「伝説の海賊達はサッカー観戦にでも行くのかな･･･」\nモブ「そのグッズは、確か、この先の町にあるサッカーチームのものだったよ。もしかしたらそこにいるのかもしれないね」\nパスくん「なるほど、じゃあ急いでその町に行こう！」\n\(myName)「教えてくれてありがとう！」\nリオデジャネイロを後にして、船に乗り込むと新たに舵を切った。\n次なる目的地は、アルゼンチンだ。\n"
        case 2:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "アルゼンチン"
            areaImage.image = UIImage(named: "Brazil_world2")
            textFild.text = "モブ「ふぃ～～！いいバトルだったぜ！」\n\(myName)「か、勝てた･･･」\nパスくん「ボクはネコじゃないよ！」\nモブ「約束だから教えてやる！あいつらは、なんでもモアイを観たいとか言っててな。この先の町に向かって行ったぞ」\n\(myName)「ええ！じゃあもう移動しちゃったってこと！？」\nパスくん「ボクはネコじゃないよ！！」\nモブ「ああ、多分もうこの町を発った出た後だろうな！」\n\(myName)「うわあ！じゃあ急いで向かわなきゃ！」\nパスくん「ボクはネコじゃないってば！」\n\(myName)「ほらパスくんも行くよっ！」\nモブ「気をつけてな～！！！」\nごねるパスくんを連行しながら、アルゼンチンを後にする。\nモアイのいる地を目指して･･･\n次に向かうのは、チリだ。\n"
        case 3:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "チリ"
            areaImage.image = UIImage(named: "Brazil_world3")
            textFild.text = "\(myName)「やった･･･！勝った！！！」\nモブ「くっそ～～～！負けちゃったかあ･･･！」\n悔しそうにしているところ悪いが、バトルに勝てたことに心の底から安堵した。\nモアイ観光3時間は地獄･･･！\nパスくん「じゃ、じゃあ約束通り通らせてもらうね･･･！」\nモブ「ちぇっ、仕方ないな。気をつけていくんだよ」\n\(myName)「うん･･･！」\nなんとかチリを抜けることができた。\n今度こそ、そう思いながら舵を切る。\n次なる目的地は、ボリビアだ。\n"
        case 4:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "ボリビア"
            areaImage.image = UIImage(named: "Brazil_world4")
            textFild.text = "モブ「降参！君たちの勝ちだ！」\n\(myName)「やった！！」\nモブ「じゃあ、約束だからね。教えてあげる。海賊のコスプレをした人達は、なんでも、アマゾンでピラニア釣りをするんだって言ってたよ」\nパスくん「アマゾンんん･･･！？」\n\(myName)「しかもピラニアって、あれだよね、肉食なんだよね･･･？」\n「伝説の海賊達って、なんか好奇心の塊(かたまり)みたいな人達だね･･･」\n\(myName)「でもこうしちゃいられないよ、早く行こう！」\nパスくん「そうだね･･･！絶景も見れたし、アマゾンへ急ごうか！」\n\(myName)「教えてくれてありがとう！」\nぺこり、とお辞儀をして駆け出す。\nモブ「どういたしましてー！気をつけてねー！！」\n背中で励ましの声を受け止めながら、次なる目的地へと向かう。\n野生溢(あふ)れる世界、アマゾンへ。\n"
        case 5:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "アマゾン"
            areaImage.image = UIImage(named: "Brazil_world5")
            textFild.text = "「うーむ･･･負けた！強いじゃないか君たち！」\nパスくん「よかった～！\(myName)が日頃から頑張っている証拠だね！」\n\(myName)「えへへ･･･」\n「じゃあ約束だからな。情報をあげよう。私はあの海賊達が「宇宙に行く」と言っているのを聞いたよ。そして彼らの船が空に飛んでいくのを見たんだ。」\n\(myName)「空･･･！？」\n突拍子もなさすぎて、びっくりした。\nパスくん「･･･まさか、そんなところまでそっくりだなんて･･･」\nそのパスくんのつぶやきは、無視できるものではなかった。\n\(myName)「えっ、パスくん、どういうこと･･･？」\nパスくん「･･･あのね、言ってなかったんだけどね、ボクたちのこの船も空を飛ぶことができるんだ」\n\(myName)「え！？そうなの！？」\nパスくん「でも、4つ合った飛行用のパーツがどこかに散らばっちゃってて、今はその力が失われてるんだ･･･。もう一度飛べるようにするためには、船のパーツを探しに行かなくちゃいけない」\n\(myName)「探すって、今まで行った場所にはそれっぽいものはなかった気がするけど･･･」\nパスくん「うん･･･多分今まで行ってない大陸に散らばってると思うんだ」\n\(myName)「っていうことは･･･」\nパスくん「･･･南極大陸･･･だね･･･」\n南極、それはこの世界で最も寒い地域。\n最低気温は－90度をも下回る、まさに極寒（ごっかん）の地だ。\nきっとこれまでとは比べものにならないほど大変な旅になるだろう。\nだけど、それでも。\n\(myName)「･･･いこう！そのパーツ探しに！伝説の海賊達を追いかけなくちゃ！」\nパスくん「そうだね･･･！よぉーし！じゃあ南極へ出発だ！」\n\(myName)「面舵(おもかじ)いっぱーい！！」\n新たな力を手に入れるため。\nいざ、極寒の地へ･･･！\n"
        default:
            print("error")
        }
    }else if playerData.last?.MyStage == "SouthPole"{
        areaNumber.text = "9"
        switch playerData.last?.MyStageNumber{
        case 1:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "ルメール海域"
            areaImage.image = UIImage(named: "SouthPole_world1")
            textFild.text = "「わーーー！負けた負けた！くやしいなー！」\nパスくん「セリフのわりに笑顔で楽しそう」\n「いやあ、久しぶりに人と遊んで楽しくてね！」\nにこにこと嬉しそうなその人は、手を差し出してきた。\n「これ、約束のやつ！付き合ってくれてありがとうね！」\n\(myName)「船のパーツ！ありがとうございます！」\nパスくん「まずは1つ目だね！」\n\(myName)「うん！」\n「じゃあ、なんかよくわかんないけど頑張ってね！」\nそう言うと、男の人の船は、海峡の中をすいすいと進んで行った。\n\(myName)「運転すご･･･！上手･･･！」\nパスくん「ボクたちも次を目指そうか」\n\(myName)「そうだね、パスくん道案内お願い！」\nパスくん「まかせてー！」\n気を取り直して、舵を切る。\n2つ目のパーツを目指して。\n"
        case 2:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "南極基地"
            areaImage.image = UIImage(named: "SouthPole_world2")
            textFild.text = "パスくん「\(myName)の勝ち！さすが！！」\n「負けちゃった～！でも久しぶりにこんなにテンション上がったよ！」\n\(myName)「よかったです･･･！」\n「じゃあそのパーツ渡さなきゃね。ちょっと取ってくる！」\nそう言うなり観測隊の人は基地に入り、そして手にパーツを持ってすぐに戻ってきてくれた。\n「はい！これ！合ってる？」\nパスくん「あ！間違いない！船のパーツだよ！」\n\(myName)「ありがとうございます！」\nお礼を言って、パーツを受け取る。\nこれで船のパーツは2つとなった。\n\(myName)「残り半分！がんばろう･･･！」\n\(myName)＆パスくん「「おー！」」\n"
        case 3:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "ペンギンタウン"
            areaImage.image = UIImage(named: "SouthPole_world3")
            textFild.text = "「くそ～～～、負けちゃったぞ･･･」\n\(myName)「いきなりすぎてびっくりしたあ･･･」\nパスくん「でもなんとかパーツを守れたね･･･」\nふうっと安堵していると、\n「･･･よく見たら、そのネコもかわいいなあ･･･！」\n\(myName)「え？」\nパスくん「ネコ･･･またネコって･･･！」\n「ネコちゃん！オイラと一緒に遊ぼうぜ～！」\n\(myName)「今度はペンギンじゃなくてパスくんにターゲットが･･･」\n「おいおまえ！そのネコちゃんをくれよ！くれないならバトルだ！」\n\(myName)「いやいやいやうそでしょ！？」\nパスくん「\(myName)！いくよ！さよなら！！」\n言うやいなや、猛スピードで駆けていくパスくん。\n\(myName)「ままま待って！置いてかないで！」\n「まーーてーーー！！」\n･･･なんとか撒いて、船へ乗り込む。\nなんだかんだで、残るパーツはあと一つだ。\n"
        case 4:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "ヴィンソン・マシフ"
            areaImage.image = UIImage(named: "SouthPole_world4")
            textFild.text = "「な、な、な…！？」\nパスくん「よっし！ボクたちの勝ちだね！」\n\(myName)「うん！」\n思わずパスくんとハイタッチをする。\n「…ご加護が無いってことはこれは山の神様ではなかったのか…！？」\n\(myName)「あ、あのう…パーツ…もらっていっていいですか…？」\n「ああ…いいよ…はいどうぞ…」\n\(myName)「あ、ありがとう…」\nパスくん「なんだか複雑な気持ちだね…」\n約束は約束なので、パーツをもらう。\nパスくん「よ、よし！これで4つのパーツは全部集まったね！」\n\(myName)「やったね！…あれ？でもこれをどうしたらいいの？」\nパスくん「船に組み込んでもらったら完成だよ！どうやらこの先に宇宙ステーションがあるみたい。そこになら、船をなおしてくれる人がいるかもしれない！」\n\(myName)「なるほど！じゃあその宇宙ステーションに行こう！」\n集めたパーツを抱えて走り出す。宇宙への道はあと少しだ。\n"
        case 5:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "宇宙ステーション"
            areaImage.image = UIImage(named: "SouthPole_world5")
            textFild.text = "「ふむ！いいじゃろう、お前さん達は十分に強い力を持っておるようじゃ」\n\(myName)「やった！じゃあ･･･！」\n「わしゃ約束は破らん。少し待っておれ、すぐになおしてやるでな」\nというと、おじいさんはあっという間にパーツを取り付けてしまった。\n「久しぶりすぎて手に力が入らんかったわい！じゃがこれでこの船はそらを飛べる！宇宙だっていけるじゃろう！」\nパスくん「本当！？やったー！」\n\(myName)「ついに宇宙に行けるんだね･･･！ありがとうおじいさん！」\n飾りだとばかり思っていた羽が、キラキラと輝いている。\nそれを見ただけで不思議と「この船は飛べるんだ」と確信できた。\nついに、宇宙へと旅立つ準備が整ったのだ。\n「――では、気をつけてな！」\n\(myName)「うん！博士ありがとう！」\n「ほっほっほ。博士などと言われたのは久しぶりじゃの！本当にそっくりじゃわい」\n\(myName)「そっくり？」\n「いや、それより急がなくていいのかな？何かを追いかけておるのじゃろう」\nパスくん「そうだね…！\(myName)！出発しよう！」\n\(myName)「うん…！」\n船が上昇し始める。そして、まるで海を走るように空へと泳ぎだした。\n\(myName)「ほ、ほんとに飛んでる･･･！！」\nパスくん「\(myName)！しっかりつかまってて！このままあっという間に大気圏を抜けるよー！！」\n"
        default:
            print("error")
        }
    }else if playerData.last?.MyStage == "Cosmo"{
        areaNumber.text = "10"
        switch playerData.last?.MyStageNumber{
        case 1:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "Moon"
            areaImage.image = UIImage(named: "Cosmo_world1")
            textFild.text = "\(myName)「勝った〜！」\n「きみたち強いね！」\nパスくん「\(myName)はほんとに強くなったよね…！」\n「じゃあ約束守らなきゃ！あのね、わたしが見た海賊船は、木星の方向へ進んでたよ」\n\(myName)「木星か！そんなに遠くないよ！」\nパスくん「…そうだねっ」\n\(myName)「教えてくれてありがとう！」\n「どういたしまして！気をつけてね！」\n月を後にして、船に乗り込む。\n\(myName)「もう少しで伝説の海賊にたどり着くよ！やったねパスくん！」\nパスくん「そうだね…！いまの\(myName)なら、どんな敵でも1人で倒せちゃうよ！」\n\(myName)「えへへ！パスくんも一緒だもん！心強いよ！」\nパスくん「…うん…、君の力になれてるなら嬉しいんだ…」\n\(myName)「…？」\n"
        case 2:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "Mars"
            areaImage.image = UIImage(named: "Cosmo_world2")
            textFild.text = "「負けた負けたーー！んじゃあ早速取り掛かるから、ちょい待ってて！」\nというと、おねえさんはてきぱきと作業をし始め、あっという間に修理が終わってしまった。\n「はいおわり〜！」\nパスくん「はやっ！」\n「なんかさ〜、船を上昇させるパーツの部分のネジが緩んでたっぽいよ。とれそうなくらいゆるゆるだったもん」\n\(myName)「ね、ネジ…」\nパスくん「ねえ\(myName)、そういえば博士、力入んなかったとか言ってたような…」\n\(myName)「は、はかせ〜…！！」\n思わずがっくりとする。\n\(myName)「でも、船がなおってよかったよ！これで先へ進めるね！」\nパスくん「…うん、そうだね…！」\nおねえさんにお礼を言って、船に乗り込む。\n不安でドキドキしたけど、船は無事に上昇した。\n\(myName)「よし！しゅっぱーつ！」\nパスくん「……」\n\nｰｰそのしばらく後のこと\n木星に着くまでの時間、少し休憩をしようということになった。\n伝説の海賊は、きっとすごく強いんだろう。\n絶対に勝つために、体の疲れをいやしておかなくては。\nそう思って、ひと眠りした後のことだった。\n\n\(myName)「ふわあ〜…よく寝た…」\nのびをして、しかしすぐに、船が静かすぎることに気がついた。\n\(myName)「…お〜い、パスくん？」\nいつもなら近くにいるはずの相棒がどこにもいない。\nどうしたんだろう…\n船中を探し回る。それでも見つからない。\n\(myName)「パスくん…！」\nすると、舵に何か紙が貼り付けられているのを見つけた。\n\(myName)「なんだろう……」\n昨日までなかったそれに、近づいて見てみる。\n\(myName)「て、手紙…？」\nパスくん「ボクの力が無くてもやっていける。君はもう一人で大丈夫だね。さよなら」\n\n\(myName)「………パスくん…？」\n\n"
        case 3:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "Jupiter"
            areaImage.image = UIImage(named: "Cosmo_world3")
            textFild.text = "\(myName)「よ、よし･･･！とどめだ･･･！」\n最後の一撃を加えようとしたときだった。\n「あまぁぁぁい！」\n\(myName)「うわああぁ！」\nもう倒せると思っていたのに、伝説の海賊達は急に体を起こして反撃をしてきた。\nしかも･･･まるで攻撃が効いていないかのように元気だ。\n\(myName)「うそ･･･！どうして･･･？たしかに攻撃は当たっていたのに！」\n「本当にそれがお前の全力か？攻撃にまるで力が入っていないな」\n「これじゃあ私たちは倒せないわよ～」\nたしかに、言うとおりだった。体に力が入っていない気がする･･･\n自分が戦いに集中できていない理由は、わかっていた。\n\(myName)「･･･パスくん･･･」\nいなくなった相棒のことが気がかりで、心にずっと引っかかっている。\n「･･･今の君に大切な物が、ここには無いようだ」\n「そうね。それが無いようじゃ、私たちには勝てないわ」\n伝説の海賊達は、武器をしまった。\nジンバル「一旦勝負はおあずけということじゃな」\n「･･･土星に行ってみなさい。そこに君にとってのお宝があるかもしれん」\n\(myName)「お宝･･･」\n伝説の海賊達の意図はわからない。\nでも、どうしても土星に行かなくてはいけない気がした。\n\(myName)「･･･わかった」\n"
        case 4:
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "Saturn"
            areaImage.image = UIImage(named: "Cosmo_world4")
            textFild.text = "パスくん「ほら、君は一人でも十分に強い。ボクはもういらないんだよ」\n\(myName)「･･･だから違うんだ。パスくん」\n伝説の海賊達に負けたことを思い出しながら、言葉を続ける。\n\(myName)「ここに来る前にね、会ったんだ。伝説の海賊達に」\nパスくん「えっ！？」\n\(myName)「でも負けちゃった。一人じゃ勝てなかったんだよ」\nパスくん「･･････」\n\(myName)「それでね、言われたんだ。今の君には、大切な物が欠けているって」\nパスくん「大切な物･･･？」\n\(myName)「それはね、きっと、ともだちなんだ。」\nパスくん「ともだち･･･！？ともだちなんて･･･どうしたら･･･」\n\(myName)「ともだちならもういるよ！パスくんという最高のともだちが！」\nパスくん「ボクが･･･ともだち･･･？」\n\(myName)「うん！もちろんじゃないか！」\nパスくんの手をとる。\n\(myName)「大変な旅だったけど、ここまで乗り越えられたのは一人じゃなかったからだよ。君が一緒にいてくれるだけで、頑張ろうって思える。何倍もの力が湧いてくるんだ」\nパスくん「\(myName)･･･」\n\(myName)「コンパスが使えないとか、道が示せないとか、そんなのどうだっていいよ！そういう時はまたいつもみたいに情報収集したらいい。そうやって二人で一緒に旅をしようよ」\nパスくんの羽が光り出す\n\(myName)「必要ないなんて悲しいことを言わないで！パスくんというともだちが一緒にいるだけで、強くなれるんだから――！」\n\nぱあぁぁっとパスくんが光に包まれる。\n\n\(myName)「パスくん…！？」\n光がおさまっていくと、そこには\n【パスくんの姿描写】→羽が無いので諸々かえる。羽を生やすパスくん「…もう、君はボクがいないとだめなんだから…！」\n\(myName)「！…うん！君がいないと心細いんだ！一緒に行ってくれないかな？」\n「も～いいよっ、ともだちだからね！」\n\(myName)「えへへ…！…あれ？コンパスの針動いてない？」\nパスくん「…ほんとだ！」\nさっきまでぴくりとも動かなかった針が、いつものように動き出していた。\nパスくん「姿が変わったから、コンパスの機能もよくなったのかも…」\n\(myName)「じゃあ、いま針が示しているのって…」\nパスくん「お宝の位置…つまり伝説の海賊達の場所だよ！」\n針が指す方向は、さっきまでいた木星とは真逆の方向だった。\n\(myName)「伝説の海賊達も移動しちゃったんだ！」\nパスくん「よーし！追いかけよう！」\n自分自身、何が変わったわけでもない。\nでも、不思議と自信と力にあふれていた。\n今の自分たちなら、負ける気がしない――！\n"
        case 5:
            NextButton.isHidden = false
            cancelButton.isHidden = true
            stageNumber.text = String(playerData.last!.MyStageNumber)
            areaLabel.text = "The end"
            areaImage.image = UIImage(named: "Cosmo_world5")
            textFild.text = "\(myName)＆パスくん「「やった～～～～！！！！」」\nパスくんと二人で飛びはねる。\n「あ゛～～～！負けた負けた！」\n「負けちゃったわねえ～」\nジンバル「完敗じゃな！」\n伝説の海賊達も、ぐて～っと倒れ込む。\n「さて、約束のお宝……の前に、俺たちの正体を明かすとするか」\n\(myName)「正体？」\n「なんだ、まだわかってないのか？」\n「うふふ、こんな格好だからわからないわよ～」\nジンバル「その仮面、声も変えることができるんじゃな～」\nパスくん「え？\(myName)の知り合い？」\n\(myName)「え？ええ！？」\n何を言っているのかよくわからない。\n仮面に手をかけて、伝説の海賊達が素顔をあらわす…\n「や～っと愛する我が子とちゃんとしゃべれるよ」\n「\(myName)～！元気だったかしら！」\n\(myName)「……うそ……！？」\n目の前に立っていたのは、見覚えのある人達だった。\nいや見覚えがあるなんてどころじゃない。\n\(myName)「お父さん、お母さんじゃん！！なんで！？」\n"
        default:
            print("error")
        }
        if playerData.last!.MyStageNumber <= 4 {
            
            try!realm.write{
                playerData.last!.MyStageNumber = playerData.last!.MyStageNumber + 1
                }
        }else if playerData.last!.MyStageNumber == 5 {
                let realm = try! Realm()
                let player = Player()
                player.MyStage = "Clear"
                try!realm.write{
                    realm.add(player)
                    }
            }
        }
}
    
    @IBAction func NextButton(_ sender: Any) {
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
        self.performSegue(withIdentifier: "SegueE", sender: nil)
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
    
    func cancelButtonTap() {
        let realm = try! Realm()
        let newData = realm.objects(Player.self).last
        try! realm.write {
            newData?.MyCoin = newData!.MyCoin + 100
            newData?.MyScore = newData!.MyScore + 100
            newData!.MyJewel = newData!.MyJewel + 1
            newData!.StoryBool = 0
        }
        messageView.isHidden = true
        cancelButton.isEnabled = true
        
        
    }
}
