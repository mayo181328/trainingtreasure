//
//  ConfigurationCreditViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/10.
//

import UIKit
import RealmSwift
import AVFoundation

class ConfigurationCreditViewController: UIViewController , AVAudioPlayerDelegate ,ButtonTapDelegate,CancelTapDelegate{
    
    var player : AVAudioPlayer!
    
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!
    @IBOutlet weak var cancelBarView: CancelBarView!
    
    @IBOutlet weak var textfild: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        textfild.isEditable = false
        underBar.delegate = self
        writeTopBar()
        writePreparationCancelBar()
        writeCancelBar()
        writeText()
        cancelBarView.delegate = self
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
    
    //    トップバーに書き込む関数
       func writeTopBar() {
        let realm = try!Realm()
        let playerData = realm.objects(Player.self)
        let myLevel = playerData.last!.MyScore  / 10
        print(playerData.last!.MyScore / 10,playerData.last!.MyScore)
        
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
    func writeText() {
        textfild.text = "この規約は、お客様が、無料学習塾プロジェクトふらいおん（以下「当団体」）が提供する「英語学習アプリ」サービス（以下「本サービス」）をご利用頂く際の取扱いにつき定めるものです。本規約に同意した上で本サービスをご利用ください。\n\n第１条（定義）\n　本規約上で使用する用語の定義は、次に掲げるとおりとします。\n（1）本サービス\n当団体が運営するサービス及び関連するサービス\n（2）本サイト\n本サービス上で提供される文字、音、静止画、動画、ソフトウェアプログラム、コード等の総称（投稿情報を含む）\n（3）利用者\n本サービスを利用する全ての方\n（4）知的財産\n　発明、考案、植物の新品種、意匠、著作物その他の人間の創造的活動により生み出されるもの（発見または解明がされた自然の法則または現象であって、産業上の利用可能性があるものを含む）、商標、商号その他事業活動に用いられる商品または役務を表示するもの及び営業秘密その他の事業活動に有用な技術上または営業上の情報\n（5）知的財産権\n　特許権、実用新案権、育成者権、意匠権、著作権、商標権その他の知的財産に関して法令により定められた権利または法律上保護される利益に係る権利\n\n第２条（本規約への同意）\n１　利用者は、本利用規約に同意頂いた上で、本サービスを利用できるものとします。\n２　利用者が、本サービスをスマートフォンその他の情報端末にダウンロードし、本規約への同意手続を行った時点で、利用者と当団体との間で、本規約の諸規定に従った利用契約が成立するものとします。\n３　利用者が未成年者である場合には、親権者その他の法定代理人の同意を得たうえで、本サービスをご利用ください。\n４　未成年者の利用者が、法定代理人の同意がないにもかかわらず同意があると偽りまたは年齢について成年と偽って本サービスを利用した場合、その他行為能力者であることを信じさせるために詐術を用いた場合、本サービスに関する一切の法律行為を取り消すことは出来ません。\n５ 本規約の同意時に未成年であった利用者が成年に達した後に本サービスを利用した場合、当該利用者は本サービスに関する一切の法律行為を追認したものとみなされます。\n\n第３条（規約の変更）\n１　当団体は、利用者の承諾を得ることなく、いつでも、本規約の内容を改定することができるものとし、利用者はこれを異議なく承諾するものとします。\n２　当団体は、本規約を改定するときは、その内容について当団体所定の方法により利用者に通知します。\n３　前本規約の改定の効力は、当団体が前項により通知を行った時点から生じるものとします。\n４　利用者は、本規約変更後、本サービスを利用した時点で、変更後の本利用規約に異議なく同意したものとみなされます。\n\n第４条（禁止行為）\n本サービスの利用に際し、当団体は、利用者に対し、次に掲げる行為を禁止します。\n（１）当団体または第三者の知的財産権を侵害する行為\n（２）当団体または第三者の名誉・信用を毀損または不当に差別もしくは誹謗中傷する行為\n（３）当団体または第三者の財産を侵害する行為、または侵害する恐れのある行為\n（４）当団体または第三者に経済的損害を与える行為\n（５）当団体または第三者に対する脅迫的な行為\n（６）コンピューターウィルス、有害なプログラムを仕様またはそれを誘発する行為\n（７）本サービス用インフラ設備に対して過度な負担となるストレスをかける行為\n（８）当サイトのサーバーやシステム、セキュリティへの攻撃\n（９）当団体提供のインターフェース以外の方法で当団体サービスにアクセスを試みる行為\n（１０）上記の他、当団体が不適切と判断する行為\n\n第５条（免責）\n１　当団体は、本サービスの内容変更、中断、終了によって生じたいかなる損害についても、一切責任を負いません。\n２　当団体は、利用者の本サービスの利用環境について一切関与せず、また一切の責任を負いません。\n３　当団体は、本サービスが利用者の特定の目的に適合すること、期待する機能・商品的価値・正確性・有用性を有すること、利用者による本サービスの利用が利用者に適用のある法令または業界団体の内部規則等に適合すること、および不具合が生じないことについて、何ら保証するものではありません。\n４　当団体は、本サービスが全ての情報端末に対応していることを保証するものではなく、本サービスの利用に供する情報端末のＯＳのバージョンアップ等に伴い、本サービスの動作に不具合が生じる可能性があることにつき、利用者はあらかじめ了承するものとします。当団体は、かかる不具合が生じた場合に当団体が行うプログラムの修正等により、当該不具合が解消されることを保証するものではありません。\n５　利用者は、AppStore、GooglePlay等のサービスストアの利用規約および運用方針の変更等に伴い、本サービスの一部又は全部の利用が制限される可能性があることをあらかじめ了承するものとします。\n６　当団体は、本サービスを利用したことにより直接的または間接的に利用者に発生した損害について、一切賠償責任を負いません。\n７　当団体は、利用者その他の第三者に発生した機会逸失、業務の中断その他いかなる損害（間接損害や逸失利益を含みます）に対して、当団体が係る損害の可能性を事前に通知されていたとしても、一切の責任を負いません。\n８　第１項乃至前項の規定は、当団体に故意または重過失が存する場合又は契約書が消費者契約法上の消費者に該当する場合には適用しません。\n９　前項が適用される場合であっても、当団体は、過失（重過失を除きます。）による行為によって利用者に生じた損害のうち、特別な事情から生じた損害については、一切賠償する責任を負わないものとします。\n１０　本サービスの利用に関し当団体が損害賠償責任を負う場合、当該損害が発生した月に利用者から受領した利用額を限度として賠償責任を負うものとします。\n１１　利用者と他の利用者との間の紛争及びトラブルについて、当団体は一切責任を負わないものとします。利用者と他の利用者でトラブルになった場合でも、両者同士の責任で解決するものとし、当団体には一切の請求をしないものとします。\n１２　利用者は、本サービスの利用に関連し、他の利用者に損害を与えた場合または第三者との間に紛争を生じた場合、自己の費用と責任において、かかる損害を賠償またはかかる紛争を解決するものとし、当団体には一切の迷惑や損害を与えないものとします。\n１３　利用者の行為により、第三者から当団体が損害賠償等の請求をされた場合には、利用者の費用（弁護士費用）と責任で、これを解決するものとします。当団体が、当該第三者に対して、損害賠償金を支払った場合には、利用者は、当団体に対して当該損害賠償金を含む一切の費用（弁護士費用及び逸失利益を含む）を支払うものとします。\n１４　利用者が本サービスの利用に関連して当団体に損害を与えた場合、利用者の費用と責任において当団体に対して損害を賠償（訴訟費用及び弁護士費用を含む）するものとします。\n\n第６条（権利譲渡の禁止）\n１　利用者は、予め当団体の書面による承諾がない限り、本規約上の地位および本規約に基づく権利または義務の全部または一部を第三者に譲渡してはならないものとします。\n２　当団体は、本サービスの全部または一部を当団体の裁量により第三者に譲渡することができ、その場合、譲渡された権利の範囲内で利用者のアカウントを含む、本サービスに係る利用者の一切の権利が譲渡先に移転するものとします。\n\n第７条（分離可能性）\n本規約のいずれかの条項又はその一部が、消費者契約法その他の法令等により無効又は執行不能と判断された場合であっても、本規約の残りの規定及び一部が無効又は執行不能と判断された規定の残りの部分は、継続して完全に効力を有するものとします。\n\n第８条（当団体への連絡方法）\n本サービスに関する利用者の当団体へのご連絡・お問い合わせは、本サービスまたは当団体が運営するwebサイト内(https://flyon.jp)の適宜の場所に設置するお問い合わせフォームからの送信または当団体が別途指定する方法により行うものとします。\n\n第９条（準拠法）\n１　本規約の有効性，解釈及び履行については，日本法に準拠し，日本法に従って解釈されるものとする。\n２０２０年２月１４日　施行\n"
    }
}
