//
//  HomeDiaryViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/15.
//

import UIKit
import RealmSwift
import AVFoundation

class HomeDiaryViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, AVAudioPlayerDelegate ,ButtonTapDelegate ,CancelTapDelegate{
    
    @IBOutlet weak var DiaryCollection: UICollectionView!
    @IBOutlet weak var Layout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var cancelBarView: CancelBarView!
    
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!
    
    var passedRow : IndexPath!
    var QuizTitleNumber : Int!
    var player : AVAudioPlayer!
    
    let headerTitle: [String] = ["日本", "東アジア", "オーストラリア", "南アジア", "アフリカ", "ヨーロッパ", "北アメリカ", "南アメリカ", "南極", "宇宙", ]
    
    let cellTitle = [
        ["東京", "愛知", "大阪", "福岡", "沖縄", ],
        ["韓国", "北京", "上海","香港" , "台湾", ],
        ["バミューダ海域","シドニー", "キャンベラ", "メルボルン",  "エアーズロック", ],
        ["スリランカ", "インド", "バングラデシュ", "ブータン", "エベレスト", ],
        ["エジプト", "マダガスカル", "南アフリカ", "ガーナ", "サハラ砂漠", ],
        ["スペイン", "フランス", "ドイツ", "イギリス", "ノルウェー", ],
        ["ニューヨーク", "カナダ",  "ロサンゼルス","メキシコ", "ラスベガス",],
        ["リオデジャネイロ", "アルゼンチン", "チリ", "ボリビア", "アマゾン", ],
        ["ルメール海峡", "南極基地", "ペンギンタウン", "ヴィンソン・マシフ", "宇宙ステーション", ],
        ["Moon", "Mars", "Jupiter", "Saturn", "The end", ],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writeTopBar()
        DiaryCollection.delegate = self
        DiaryCollection.dataSource = self
        underBar.delegate = self
        cancelBarView.delegate = self
        
        let nib = UINib(nibName: "DiaryCollectionViewCell", bundle: Bundle.main)
        DiaryCollection.register(nib, forCellWithReuseIdentifier: "Cell")
    
        self.DiaryCollection.backgroundColor = UIColor.clear
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
//    一つのセクションにクイズタイトルの個数分セルを作る
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var cellCount :Int!
        let realm = try!Realm()
        let cheack = realm.objects(Player.self).last
        switch cheack?.MyStage {
        case "Japan": cellCount = 0
        case "China":cellCount = 1
        case "Australia":cellCount = 2
        case "India":cellCount = 3
        case "Africa":cellCount = 4
        case "Europa":cellCount = 5
        case "America":cellCount = 6
        case "Brazil":cellCount = 7
        case "SouthPole":cellCount = 8
        case "Cosmo":cellCount = 9
        case "Clear":cellCount = 10
            
        default:
            print("error")
        }
        return cellCount
    }
    
    
//    クイズタイトルの個数分セクションを作る
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var titleCount :Int!
        let realm = try!Realm()
        let cheack = realm.objects(Player.self).last
        switch cheack?.MyStage {
        case "Japan": titleCount = 0
        case "China":titleCount = 1
        case "Australia":titleCount = 2
        case "India":titleCount = 3
        case "Africa":titleCount = 4
        case "Europa":titleCount = 5
        case "America":titleCount = 6
        case "Brazil":titleCount = 7
        case "SouthPole":titleCount = 8
        case "Cosmo":titleCount = 9
        case "Clear":titleCount = 10
            
        default:
            print("error")
        }
        return titleCount
    }
    
    //    値渡し
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "Segue") {
                let NC = segue.destination as! DiaryMessageViewController
                NC.passedRow = passedRow
            }
        }
    
//    ヘッダーの設定
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath)as! SectionHeaderCollectionReusableView
        let label = UILabel(frame: .zero)
        header.addSubview(label)
        if kind == UICollectionView.elementKindSectionHeader {
            header.sectionLabel.text = "\(headerTitle[indexPath.section])"
            return header
        }
        return header
    }
    
//    セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DiaryCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)as! DiaryCollectionViewCell
        cell.Label.text = cellTitle[indexPath.section][indexPath.row]
        
        
//        cellの色を変える
        switch indexPath.row {
        case 1,6,11:
            cell.Image?.image = UIImage(named: "redMemo")
        case 2,7,12:
            cell.Image?.image = UIImage(named: "greenMemo")
        case 3,8,13:
            cell.Image?.image = UIImage(named: "yellowMemo")
        case 4,9,14:
            cell.Image?.image = UIImage(named: "pinkMemo")
        case 5,10,0:
            cell.Image?.image = UIImage(named: "purpleMemo")
        default:
            cell.Image?.image = UIImage(named: "redMemo")
        }
        return cell
    }
//    サイズの設定
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
//    遷移
//    選択された時に起動
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
}
