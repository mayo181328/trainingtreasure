//
//  GachaFinishedViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/11/23.
//

import UIKit
import RealmSwift
import AVFoundation

class GachaFinishedViewController: UIViewController , AVAudioPlayerDelegate,ButtonTapDelegate {
    
    var player : AVAudioPlayer!
    
    var gachaHeadItem = [String]()
    var gachaBodyItem = [String]()
    var random : Int!
    
    @IBOutlet weak var topBar : TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!
    
    @IBOutlet weak var Image: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        underBar.delegate = self
        writeTopBar()
        gacha()
    }
    
    func gacha()  {
        let realm = try!Realm()
        let GachaHeadItem = realm.objects(Player.self).last?.GachaHead
        let GachaBodyItem = realm.objects(Player.self).last?.GachaBody
        let PlayerData = realm.objects(Player.self).last
        
//        一度配列に保存
        if GachaHeadItem!.count != 0{
        for i in 0...GachaHeadItem!.count - 1 {
            gachaHeadItem.append(GachaHeadItem![i].GachaHead)
         }
        }
        if GachaBodyItem!.count != 0{
        for i in 0...GachaBodyItem!.count - 1 {
            gachaBodyItem.append(GachaBodyItem![i].GachaBody)
         }
        }
        
        var random2 = Int.random(in: 0...1)
        
        
        if random2 == 0 {
            if GachaHeadItem?.count == 1 {
                random = 0
            }else if GachaHeadItem!.count < 1{
                if GachaBodyItem?.count == 1 {
                    random = 0
                }else {
                    random = Int.random(in: 0...gachaBodyItem.count - 1)
                }
                let myNewItem = MyBodyItemList()
                Image.image = UIImage(named: gachaBodyItem[random])
                myNewItem.MyBodyList = gachaBodyItem[random]
                gachaBodyItem.remove(at: random)
                try!realm.write(){
                    PlayerData?.GachaBody.removeAll()
                    PlayerData?.MyBodyItem.append(myNewItem)
                }
                for i in gachaBodyItem {
                    let gachaBodyData = GachaBodyList()
                    gachaBodyData.GachaBody = i
                    try!realm.write(){
                        PlayerData?.GachaBody.append(gachaBodyData)
                    }
                }
                return
            } else {
                random = Int.random(in: 0...gachaHeadItem.count - 1)
            }
            
            let myNewItem = MyHeadItemList()
            Image.image = UIImage(named: gachaHeadItem[random])
            myNewItem.MyHeadList = gachaHeadItem[random]
            gachaHeadItem.remove(at: random)
            try!realm.write(){
                PlayerData?.GachaHead.removeAll()
                PlayerData?.MyHeadItem.append(myNewItem)
            }
            for i in gachaHeadItem {
                let gachaHeadData = GachaHeadList()
                gachaHeadData.GachaHead = i
                try!realm.write(){
                    PlayerData?.GachaHead.append(gachaHeadData)
                }
                
            }
        }else if random2 == 1 {
            if GachaBodyItem?.count == 1 {
                random = 0
            }else if GachaBodyItem!.count < 1{
                if GachaHeadItem?.count == 1 {
                    random = 0
                }else {
                    random = Int.random(in: 0...gachaHeadItem.count - 1)
                }
                let myNewItem = MyHeadItemList()
                Image.image = UIImage(named: gachaHeadItem[random])
                myNewItem.MyHeadList = gachaHeadItem[random]
                gachaHeadItem.remove(at: random)
                try!realm.write(){
                    PlayerData?.GachaHead.removeAll()
                    PlayerData?.MyHeadItem.append(myNewItem)
                }
                for i in gachaHeadItem {
                    let gachaHeadData = GachaHeadList()
                    gachaHeadData.GachaHead = i
                    try!realm.write(){
                        PlayerData?.GachaHead.append(gachaHeadData)
                    }
                }
                return
            } else {
                random = Int.random(in: 0...gachaBodyItem.count - 1)
            }
            
            print(gachaBodyItem)
            print(random)
            let myNewItem = MyBodyItemList()
            Image.image = UIImage(named: gachaBodyItem[random])
            myNewItem.MyBodyList = gachaBodyItem[random]
            gachaBodyItem.remove(at: random)
            try!realm.write(){
                PlayerData?.GachaBody.removeAll()
                PlayerData?.MyBodyItem.append(myNewItem)
            }
            for i in gachaBodyItem {
                let gachaBodyData = GachaBodyList()
                gachaBodyData.GachaBody = i
                try!realm.write(){
                    PlayerData?.GachaBody.append(gachaBodyData)
                }
                
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
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
}
