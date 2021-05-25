//
//  StoryViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/02.
//

import UIKit
import RealmSwift
import AVFoundation

class StoryViewController: UIViewController , AVAudioPlayerDelegate,ButtonTapDelegate ,cancelTapLogInDelegate {

    

    var player : AVAudioPlayer!
    
    @IBOutlet weak var underBar: UnderBar2View!
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var MapImage: UIImageView!
    @IBOutlet weak var LogInView: LogInView!
    
    @IBOutlet weak var GoAdButton: UIButton!
    
    @IBOutlet weak var Background: UIImageView!
    @IBOutlet weak var CloseMap: UIImageView!
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var Paskun: UIImageView!
    
    
    
    
    var map :String = "world"
    @IBOutlet weak var mapButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MessageLabel.isHidden = true
        
        MapImage.image = UIImage(named: "Japan_world")
        CloseMap.isHidden = true
        startAdventureBGM()
        underBar.delegate = self
        LogInView.delegate = self
        writeTopBar()
        SetLoginView()
        let realm = try! Realm()
        let newData = realm.objects(Player.self).last
        if newData!.StoryBool == 1 {
            GoAdButton.isEnabled = false
            MessageLabel.isHidden = false
        }
        setBackground()
        let realm = try!Realm()
        let cheack = realm.objects(Player.self).last
        if cheack?.MyStage = "Cosmo"{
            Paskun.image = UIImage(named: "paskun_2")
        }
        
    }
    
    func setBackground(){
        let realm = try!Realm()
        let cheack = realm.objects(Player.self).last
        switch cheack?.MyStage {
        case "Japan":
            Background.image = UIImage(named: "Japan_Sbackground")
        case "China":
            Background.image = UIImage(named: "China_Sbackground")
        case "Australia":
            Background.image = UIImage(named: "Australia_Sbackground")
        case "India":
            Background.image = UIImage(named: "India_Sbackground")
        case "Africa":
            Background.image = UIImage(named: "Africa_Sbackground")
        case "Europa":
            Background.image = UIImage(named: "Europa_Sbackground")
        case "America":
            Background.image = UIImage(named: "America_Sbackground")
        case "Brazil":
            Background.image = UIImage(named: "Brazil_Sbackground")
        case "SouthPole":
            Background.image = UIImage(named: "SouthPole_Sbackground")
        case "Cosmo":
            Background.image = UIImage(named: "Cosmo_Sbackground")
        case "Clear":
            Background.image = UIImage(named: "Cosmo_Sbackground")
            MessageLabel.text = "クリアおめでとう！"
            GoAdButton.isHidden = true
        default:
            print("error")
        }
    }
    
    @IBAction func mapButton(_ sender: Any) {
         if map == "area" {
            MapImage.isHidden = false
            CloseMap.isHidden = true
            MapImage.image = UIImage(named: "Japan_world")
            mapButton.setImage(UIImage(named: "world_Map"),for: .normal)
            map = "world"
        }else if map == "world" {
            MapImage.image = UIImage(named: "worldMap")
            mapButton.setImage(UIImage(named: "close_Map"),for: .normal)
            map = "close"
        }else if map == "close" {
            CloseMap.isHidden = false
            MapImage.isHidden = true
            mapButton.setImage(UIImage(named: "area_Map"),for: .normal)
            map = "area"
        }
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
    func cancelButtonTap() {
        let realm = try! Realm()
        let newData = realm.objects(Player.self).last
        try! realm.write {
            newData?.MyCoin = newData!.MyCoin + 100
            newData?.MyJewel = newData!.MyJewel + 1
        }
        LogInView.isHidden = true
    }
    
    func SetLoginView(){
        var LoginArray = [String]()
        
        let realm = try!Realm()
        let LoginData = LoginDateList()
        let checkData = realm.objects(Player.self).last
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMd", options: 0, locale: Locale(identifier: "ja_JP"))
        
        for i in 0...checkData!.LoginDate.count - 1 {
            LoginArray.append(checkData!.LoginDate[i].Login)
        }
        
        for i in LoginArray {
                if i == dateFormatter.string(from: nowDate) {
                LogInView.isHidden = true
                return
            }else if  i != dateFormatter.string(from: nowDate){
                LogInView.isHidden = false
                LoginData.Login = dateFormatter.string(from: nowDate)
                try!realm.write(){
                    checkData!.StoryBool = 0
                    checkData!.LoginDate.append(LoginData)
                }
            }
        }
        
        
    }
    
    @IBAction func GoOnAdventureButton(_ sender: Any) {
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
        self.performSegue(withIdentifier: "Segue", sender: nil)
    }
}
