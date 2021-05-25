//
//  TutorialCharamakedViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/10.
//

import UIKit
import RealmSwift
import AVFoundation

class TutorialCharamakedViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate, AVAudioPlayerDelegate{
    
    @IBOutlet weak var ItemCollection: UICollectionView!
    @IBOutlet weak var ListBackground: UIImageView!
    
    @IBOutlet weak var avatarView: AvatarView!
    
    
    var PartsArray = [String]()
    var PartsName : String!
    
    var player : AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        tutorial()
        PartsName = "head"
        ItemCollection.delegate = self
        ItemCollection.dataSource = self
        avatar()

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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PartsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
                let playerData = realm.objects(Player.self).last
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
    
    @IBAction func headButton(_ sender: Any) {
        ListBackground.image = UIImage(named: "board1_myRoom")
        showList(Parts: "head")
        PartsName = "head"
    }
    
    @IBAction func bodyButton(_ sender: Any) {
        ListBackground.image = UIImage(named: "board2_myRoom")
        showList(Parts: "body")
        PartsName = "body"
    }
    
    @IBAction func eyeButton(_ sender: Any) {
        ListBackground.image = UIImage(named: "board3_myRoom")
        showList(Parts: "eye")
        PartsName = "eye"
    }
    
    @IBAction func mouthButton(_ sender: Any) {
        ListBackground.image = UIImage(named: "board4_myRoom")
        showList(Parts: "mouth")
        PartsName = "mouth"
    }
    
    @IBAction func skinButton(_ sender: Any) {
        ListBackground.image = UIImage(named: "board5_myRoom")
        showList(Parts: "skin")
        PartsName = "skin"
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
  
    func tutorial() {
        let MyHeadArray = ["cool_brown","cool_gold","okappa_ash","okappa_rightblue","bob_brown","bob_gold","tuntun_gold","tuntun_red",]
        let MyBodyArray = ["onepiece_white","onepiece_blue","t-shirt_green","t-shirt_red",]
        let MyEyeArray = ["maru_brack","maru_rightgreen","tate_brown","tate_blue","zito_green","zito_red",]
        let MyMouthArray = ["cool_mouth","kuri_mouth","lol_mouth","lol2_mouth","maru_mouth","ω_mouth"]
        let MySkinArray = ["black_skin","brown_skin","nomal_skin","white_skin","white2_skin","yerow_skin"]
        
        let ShopHeadArray = ["Sponytail_black","Sponytail_blown","Ssenter","Sveryshort_black","Sveryshort_brown ","Swave_gold","Swave_silver","Sbosabosa_black","Sbosabosa_blown","Sbousu","Sintake_black","Sintake_silver","Smash_ash","Smash_black",]
        let ShopBodyArray = ["Ssailor_w","Ssailer_black","Scort_brown","Scort_green","Scort_navy","Sjacket_green","Sjacket_navi","Sjacket_red","Sonepice2_cyaan","Sonepice2_white","Sonepice2_yellow","Sparker_color1","Sparker_color1","Sparker_color2","Sparker_color3","Sparker2_black","Sparker2_blue","Sparker2_orange","Sparker2_yellow","SpoloShirt_blue","SpoloShirt_green","SpoloShirt_red","Ssuit_blue","Ssuit_green","Ssuit_red",]
        
        let GachaHeadArray = ["Gheadset","Garmorhead_blue","Garmorhead_gold","Garmorhead_green ","Garmorhead_red ","Gmadehead_gold","Gmadehead_silber","Gmagicrobehead_blue","Gmagicrobehead_red","Gpiratehead_blue","Gpiratehead_red"]
        let GachaBodyArray = ["Gdress1_green","Gdress1_yellow","GjacketCamofla_black","GjacketCamofla_camofla","Gonepice3_blue","Gonepice3_pink","Gonepice3_yellow","GtechWear_blue","GtechWear_red","GtechWear_yellow","Gvampire","Garmor_blue","Garmor_gold","Garmor_green","Garmor_red","Gmadebody_black","Gmadebody_blue","Gmadebody_yellow","Gmagicrobe_blue","Gmagicrobe_red","Gpirate_blue","Gpirate_red"]
        
        
        let realm = try!Realm()
       let playerData = realm.objects(Player.self)
        if playerData.count == 0 {
            let player = Player()
//            プレイヤー情報
            player.MyScore = 10
            player.MyName = "No Name"
            player.MyCoin = 14567
            player.MyJewel = 188
            player.MyStage = "Japan"
            player.MyStageNumber = 1
            player.MySystemNumber = 1
            player.StoryBool = 0


            //    今の装備
            player.MyHeadNow = "okappa_ash"
            player.MyBodyNow  = "onepiece_white"
            player.MyEyesNow  = "maru_brack"
            player.MyMouthNow = "lol_mouth"
            player.MySkinNow = "nomal_skin"
            
//            BGM
            player.BGM = 1.0
            player.Effect = 1.0
            player.Voice = 1.0
            
//            分析
            player.WordCount = 0
            player.ExerciseCount = 0
            
//            ログイン
            let LoginData = LoginDateList()
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMd", options: 0, locale: Locale(identifier: "ja_JP"))
            LoginData.Login = dateFormatter.string(from: date)
            player.LoginDate.append(LoginData)
            
            
            
            
            for i in 0...99{
                let KList1 = WordKnowledgeList()
                KList1.Word = 0
                player.WordKnowledge.append(KList1)
            }
            
            for i in 0...99{
                let KList2 = BasicsKnowledgeList()
                KList2.Basics = 0
                player.BasicsKnowledge.append(KList2)
            }
            
            for i in 0...99{
                let KList3 = AppliedKnowledgeList()
                KList3.Applied = 0
                player.AppliedKnowledge.append(KList3)
            }
            
            for i in 0...99{
                let KList4 = JudgmentKnowledgeList()
                KList4.Judgment = 0
                player.JudgmentKnowledge.append(KList4)
            }
            
            for i in 0...99{
                let KList5 = ThinkingKnowledgeList()
                KList5.Thinking = 0
                player.ThinkingKnowledge.append(KList5)
            }
            
            for i in 0...99{
                let KList6 = LisningKnowledgeList()
                KList6.Lisning = 0
                player.LisningKnowledge.append(KList6)
            }
            
            
            
            
//            マイアイテムの保存
//            ショップアイテムの保存
            for i in MyHeadArray{
                let myHeadItemList = MyHeadItemList()
                myHeadItemList.MyHeadList = i
                player.MyHeadItem.append(myHeadItemList)
            }
            for i in MyBodyArray{
                let myBodyItemList = MyBodyItemList()
                myBodyItemList.MyBodyList = i
                player.MyBodyItem.append(myBodyItemList)
            }
            
            for i in MyEyeArray{
                let myEyesItemList = MyEyesItemList()
                myEyesItemList.MyEyesList = i
                player.MyEyesItem.append(myEyesItemList)
            }
            for i in MyMouthArray{
                let myMouthItemList = MyMouthItemList()
                myMouthItemList.MyMouthList = i
                player.MyMouthItem.append(myMouthItemList)
            }
            for i in MySkinArray{
                let mySkinItemList = MySkinItemList()
                mySkinItemList.MySkinList = i
                player.MySkinItem.append(mySkinItemList)
            }
            
            
            
            for i in ShopHeadArray{
                let shopItemList = ShopHeadList()
                shopItemList.ShopHead = i
                player.ShopHead.append(shopItemList)
            }
            for i in ShopBodyArray{
                let shopItemList = ShopBodyList()
                shopItemList.ShopBody = i
                player.ShopBody.append(shopItemList)
            }
            
//            ガチャアイテムの保存
            
            for i in GachaHeadArray {
                let gachaHeadList = GachaHeadList()
                gachaHeadList.GachaHead = i
                player.GachaHead.append(gachaHeadList)
            }
            for i in GachaBodyArray {
                let gachaBodyList = GachaBodyList()
                gachaBodyList.GachaBody = i
                player.GachaBody.append(gachaBodyList)
            }
            try!realm.write(){
            realm.add(player)
            }
        }
}
    
    @IBAction func OkButton(_ sender: Any) {
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
    
       func avatar() {
        let realm = try!Realm()
        let playerData = realm.objects(Player.self).last
        
        avatarView.skinImage.image = UIImage(named: (playerData?.MySkinNow) as! String)
        avatarView.eyeImage.image = UIImage(named: (playerData?.MyEyesNow) as! String)
        avatarView.mouthImage.image = UIImage(named: (playerData?.MyMouthNow)as! String)
        avatarView.bodyImage.image = UIImage(named: (playerData?.MyBodyNow)as! String)
        avatarView.headImage.image = UIImage(named: (playerData?.MyHeadNow)as! String)
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
}
