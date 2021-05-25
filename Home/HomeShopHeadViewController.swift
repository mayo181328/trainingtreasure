//
//  HomeShopHeadViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/12/21.
//

import UIKit
import AVFoundation
import RealmSwift

class HomeShopHeadViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, AVAudioPlayerDelegate,ButtonTapDelegate ,CancelTapDelegate{
    

    
    
    var player : AVAudioPlayer!
    
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!

    @IBOutlet weak var ShopCollectionView: UICollectionView!
    @IBOutlet weak var mannequinImage: UIImageView!
    
    @IBOutlet weak var cancelBarView: CancelBarView!
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var BuyButton: UIButton!
    
    
    
    var shopName : String!
    var PartsArray = [String]()
    
    var shopHeadItem = [String]()
    var shopBodyItem = [String]()
    var selectItem : String!
    var selectindex : Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BuyButton.isEnabled = false
        writeTopBar()

        ShopCollectionView.delegate = self
        ShopCollectionView.dataSource = self
        cancelBarView.delegate = self
        underBar.delegate = self
        let nib = UINib(nibName: "ShopCollectionViewCell", bundle: Bundle.main)
        ShopCollectionView.register(nib, forCellWithReuseIdentifier: "ShopCell")
        let layout = UICollectionViewFlowLayout()
        //        サイズ
            layout.itemSize = CGSize(width: 160, height: 223)
        ShopCollectionView.backgroundColor = .clear
        ShopCollectionView.collectionViewLayout = layout
        
        
        setList()
        writePreparationCancelBar()
        writeCancelBar()
    }
    
    func setList(){
        let realm = try!Realm()
        let ShopHeadItem = realm.objects(Player.self).last?.ShopHead
        let ShopBodyItem = realm.objects(Player.self).last?.ShopBody
        
        
        for i in 0...ShopHeadItem!.count - 1 {
            if let sh = realm.objects(Player.self).last?.ShopHead[i].ShopHead {
                shopHeadItem.append(sh)
            }
        }
            for i in 0...ShopBodyItem!.count - 1 {
             if let sb = realm.objects(Player.self).last?.ShopBody[i].ShopBody{
                shopBodyItem.append(sb)

            }
        }

        if shopName == "head" {
            for i in shopHeadItem {
                PartsArray.append(i)
            }
        }else if shopName == "body" {
            for i in shopBodyItem {
                PartsArray.append(i)
            }
        }
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
            BuyButton.isEnabled = true
            if shopName == "head" {
                mannequinImage.image = UIImage(named: shopHeadItem[indexPath.row])
                selectItem = shopHeadItem[indexPath.row]
                selectindex = indexPath.row
            }else if shopName == "body" {
                mannequinImage.image = UIImage(named: shopBodyItem[indexPath.row])
                selectItem = shopBodyItem[indexPath.row]
                selectindex = indexPath.row
            }
            
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PartsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ShopCollectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath)as!ShopCollectionViewCell
        cell.Image.image = UIImage(named: PartsArray[indexPath.row] + ".png")
        return cell
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
        startMainBGM()
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
        startAdventureBGM()
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
        startMainBGM()
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
        startMainBGM()
        self.present(NVController, animated: true, completion: nil)
    }

    func startMainBGM(){
//                BGM
                let url = Bundle.main.bundleURL.appendingPathComponent("mainBGM.mp3")
        do {
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            try BGMplayer = AVAudioPlayer(contentsOf: url)
            BGMplayer.volume = Float(0.05 * SoundData!.BGM)
        } catch {
            print("Error")
        }
        BGMplayer!.play()
        BGMplayer!.numberOfLoops = -1
    }
    
    func startAdventureBGM(){
//                BGM
                let url = Bundle.main.bundleURL.appendingPathComponent("adventureBGM.mp3")
                        do {
                            let realm = try!Realm()
                            let SoundData = realm.objects(Player.self).last
                            try BGMplayer = AVAudioPlayer(contentsOf: url)
                            BGMplayer.volume = Float(0.05 * SoundData!.BGM)
                        } catch {
                            print("Error")
                        }
                        BGMplayer!.play()
                        BGMplayer!.numberOfLoops = -1
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
    
    @IBAction func BuyButton(_ sender: Any) {
        let realm = try!Realm()
        let PlayerData = realm.objects(Player.self).last
        
        if PlayerData!.MyCoin >= 1000 {
            try!realm.write{
                PlayerData?.MyCoin = PlayerData!.MyCoin - 1000
            }
            
        if shopName == "head" {
            let ShopHeadItem = realm.objects(Player.self).last?.ShopHead
            let myNewItem = MyHeadItemList()
            myNewItem.MyHeadList = selectItem
            shopHeadItem.remove(at: selectindex)
            try!realm.write(){
                PlayerData?.ShopHead.removeAll()
                PlayerData?.MyHeadItem.append(myNewItem)
            }
            for i in shopHeadItem{
                let shopHeadData = ShopHeadList()
                shopHeadData.ShopHead = i
                try!realm.write(){
                    PlayerData?.ShopHead.append(shopHeadData)
                }

            }
        }else if shopName == "body" {
            let ShopBodyItem = realm.objects(Player.self).last?.ShopBody
            let myNewItem = MyBodyItemList()
            myNewItem.MyBodyList = selectItem
            shopBodyItem.remove(at: selectindex)
            try!realm.write(){
                realm.delete(PlayerData!.ShopBody)
                PlayerData?.MyBodyItem.append(myNewItem)
            }
            
                try!realm.write(){
                    for i in shopBodyItem{
                        let shopBodyData = ShopBodyList()
                        shopBodyData.ShopBody = i
                    PlayerData?.ShopBody.append(shopBodyData)
                    }
                }
        }
                self.PartsArray = []
            writeTopBar()
            setList()
            self.ShopCollectionView.reloadData()
            self.performSegue(withIdentifier: "Segue", sender: nil)
        }
    }
    
    //    値渡し
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "Segue") {
                let NC = segue.destination as! LoadViewController
                NC.shopName = shopName
            }
        }
}
