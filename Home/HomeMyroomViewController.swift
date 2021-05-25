//
//  HomeMyroomViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/11/23.
//

import UIKit
import AVFoundation
import RealmSwift

class HomeMyroomViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate , AVAudioPlayerDelegate,ButtonTapDelegate ,CancelTapDelegate{
    
    var player : AVAudioPlayer!

    @IBOutlet weak var ItemCollection: UICollectionView!
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!
    
    @IBOutlet weak var cancelBarView: CancelBarView!
    
    
    @IBOutlet weak var ListBackground: UIImageView!
    @IBOutlet weak var avatarView: AvatarView!
    
    var PartsArray = [String]()
    var PartsName : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        writeTopBar()
        PartsName = "head"
        setAvatar()
        ItemCollection.delegate = self
        ItemCollection.dataSource = self
        underBar.delegate = self
        cancelBarView.delegate = self
        
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: Bundle.main)
        ItemCollection.register(nib, forCellWithReuseIdentifier: "itemCell")
        let layout = UICollectionViewFlowLayout()

        //        サイズ
            layout.itemSize = CGSize(width: 105, height: 105)
        // 横スクロール
        layout.scrollDirection = .horizontal
        ItemCollection.backgroundColor = .clear
        ItemCollection.collectionViewLayout = layout
        showList(Parts: "head")
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
    
    @IBAction func ShopButton(_ sender: Any) {
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PartsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(PartsArray)
        let cell = ItemCollection.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath)as!ItemCollectionViewCell
        cell.ImageView.image = UIImage(named: PartsArray[indexPath.row] + ".png")
        return cell
    }

    
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

            if PartsName == "head" {
                let realm = try! Realm()
                let playerData = realm.objects(Player.self).last
                try!realm.write{
                    playerData?.MyHeadNow = PartsArray[indexPath.row]
                }
            }else if PartsName == "body"{
                let realm = try! Realm()
                var playerData = realm.objects(Player.self).last
                try!realm.write{
                    playerData?.MyBodyNow = PartsArray[indexPath.row]
                }
            }else if PartsName == "eye"{
                let realm = try! Realm()
                let playerData = realm.objects(Player.self).last
                try!realm.write{
                    playerData?.MyEyesNow = PartsArray[indexPath.row]
                }
            }else if PartsName == "mouth"{
                let realm = try! Realm()
                let playerData = realm.objects(Player.self).last
                try!realm.write{
                    playerData?.MyMouthNow = PartsArray[indexPath.row]
                }
            }else if PartsName == "skin"{
                let realm = try! Realm()
                let playerData = realm.objects(Player.self).last
                try!realm.write{
                    playerData?.MySkinNow = PartsArray[indexPath.row]
                }
            }
            setAvatar()
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
    
    @IBAction func headButton(_ sender: Any) {
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
        ListBackground.image = UIImage(named: "board1_myRoom")
        PartsName = "head"
        showList(Parts: "head")
    }
    
    @IBAction func bodyButton(_ sender: Any) {
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
        ListBackground.image = UIImage(named: "board2_myRoom")
        PartsName = "body"
        showList(Parts: "body")
    }
    
    @IBAction func eyeButton(_ sender: Any) {
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
        ListBackground.image = UIImage(named: "board3_myRoom")
        PartsName = "eye"
        showList(Parts: "eye")
    }
    
    @IBAction func mouthButton(_ sender: Any) {
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
        ListBackground.image = UIImage(named: "board4_myRoom")
        PartsName = "mouth"
        showList(Parts: "mouth")
    }
    
    @IBAction func skinButton(_ sender: Any) {
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
        ListBackground.image = UIImage(named: "board5_myRoom")
        PartsName = "skin"
        showList(Parts: "skin")
    }
    
    func showList(Parts:String)  {
        PartsArray = []
        if Parts == "head" {
            let realm = try!Realm()
            let PartsData = realm.objects(Player.self).last?.MyHeadItem
            for i in PartsData! {
                if i.MyHeadList != nil {
                PartsArray.append(i.MyHeadList)
                }
            }
            
        }else if Parts == "body" {
            let realm = try!Realm()
            let PartsData = realm.objects(Player.self).last?.MyBodyItem
            for i in PartsData! {
                if i.MyBodyList != nil {
                PartsArray.append(i.MyBodyList)
                }
            }
        }else if Parts == "eye" {
            let realm = try!Realm()
            let PartsData = realm.objects(Player.self).last?.MyEyesItem
            for i in PartsData! {
                if i.MyEyesList != nil {
                PartsArray.append(i.MyEyesList)
                }
            }
        }else if Parts == "mouth" {
            let realm = try!Realm()
            let PartsData = realm.objects(Player.self).last?.MyMouthItem
            for i in PartsData! {
                if i.MyMouthList != nil {
                PartsArray.append(i.MyMouthList)
                }
            }
        }else if Parts == "skin" {
            let realm = try!Realm()
            let PartsData = realm.objects(Player.self).last?.MySkinItem
            for i in PartsData! {
                if i.MySkinList != nil {
                PartsArray.append(i.MySkinList)
                }
            }
        }
        ItemCollection.reloadData()
    }
    
    func setAvatar() {
        
        let realm = try!Realm()
        let playerData = realm.objects(Player.self).last
        
        avatarView.headImage.image = UIImage(named: (playerData!.MyHeadNow)!)
        avatarView.bodyImage.image = UIImage(named: (playerData!.MyBodyNow)!)
        avatarView.mouthImage.image = UIImage(named: (playerData!.MyMouthNow)!)
        avatarView.eyeImage.image = UIImage(named: (playerData!.MyEyesNow)!)
        avatarView.skinImage.image = UIImage(named: (playerData!.MySkinNow)!)
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
        self.performSegue(withIdentifier: "BackSegue", sender: nil)
    }
}
