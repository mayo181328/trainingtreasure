//
//  PracticeWordViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/11/23.
//

import UIKit
import AlignedCollectionViewFlowLayout
import AVFoundation
import RealmSwift

class PracticeWordViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, AVAudioPlayerDelegate ,ButtonTapDelegate ,CancelTapDelegate{

    
    
    @IBOutlet weak var QuestionCollection: UICollectionView!
    @IBOutlet weak var Layout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!
    @IBOutlet weak var cancelBarView: CancelBarView!
    
    var passedRow : IndexPath!
    var QuizTitleNumber : Int!
    var player : AVAudioPlayer!
    
    
    let headerTitle: [String] = ["食事", "いきもの", "まわりのもの", "学校","お仕事", "自然", "人と生活", "旅","時間", "算数", "動詞", "状態",]
    
    let quizTitle = [
        ["果物1","果物2","野菜1","野菜2","食べ物1","食べ物2","料理1","料理2","料理3","飲み物","おやつ","食事"],
        ["動物1","動物2","動物3","動物4","動物5","虫","植物1","植物2"],
        ["乗り物1","乗り物2","建物・街1","建物・街2","建物・街3","建物・街4","建物・街5","衣類1","衣類2","身の回り1","身の回り2","前置詞",],
        ["教科","教室の中1","教室の中2","学校","学用品1","学校施設","学校施設"],
        ["職業1","職業2","職業3","職業4","職業5","職業6",],
        ["色","季節","天候"],
        ["家族","行事","人の気持ち"],
        ["方角","国旗1","国旗2","国風文化"],
        ["時間","曜日","月の名前"],
        ["数字1","数字2","形"],
        ["1日の行動1","1日の行動2","スポーツ","スポーツ","休み時間","音楽","その他1","その他2",],
        ["状態1","状態2","状態3","状態4","頻度と疑問視",],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writeTopBar()
        QuestionCollection.delegate = self
        QuestionCollection.dataSource = self
        underBar.delegate = self
        cancelBarView.delegate = self
        
        let nib = UINib(nibName: "QuizCollectionViewCell", bundle: Bundle.main)
        QuestionCollection.register(nib, forCellWithReuseIdentifier: "quizCell")
    
        self.QuestionCollection.backgroundColor = UIColor.clear
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
        return quizTitle[section].count
    }
//    クイズタイトルの個数分セクションを作る
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return quizTitle.count
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
        let cell = QuestionCollection.dequeueReusableCell(withReuseIdentifier: "quizCell", for: indexPath)as! QuizCollectionViewCell
        cell.QuizLabel.text = quizTitle[indexPath.section][indexPath.row]
        
        
//        cellの色を変える
        switch indexPath.row {
        case 1,6,11:
            cell.QuizImage?.image = UIImage(named: "redMemo")
        case 2,7,12:
            cell.QuizImage?.image = UIImage(named: "greenMemo")
        case 3,8,13:
            cell.QuizImage?.image = UIImage(named: "yellowMemo")
        case 4,9,14:
            cell.QuizImage?.image = UIImage(named: "pinkMemo")
        case 5,10,0:
            cell.QuizImage?.image = UIImage(named: "purpleMemo")
        default:
            cell.QuizImage?.image = UIImage(named: "redMemo")
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
        
        passedRow = indexPath
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
        if passedRow != nil {
            self.performSegue(withIdentifier: "Segue", sender: nil)
             }
    }
    
    
//    値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Segue") {
            let practiceWordQuestionViewController = segue.destination as! PracticeWordQuestionViewController
            practiceWordQuestionViewController.CellIndex = passedRow
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
