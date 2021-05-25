//
//  HomeCalendarViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/11/23.
//

import UIKit
import AVFoundation
import RealmSwift

class HomeCalendarViewController: UIViewController , AVAudioPlayerDelegate,ButtonTapDelegate {
    
    var player : AVAudioPlayer!
    
    @IBOutlet weak var topBar: TopBarView!
    @IBOutlet weak var underBar: UnderBar2View!

    override func viewDidLoad() {
        super.viewDidLoad()
        underBar.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        writeTopBar()
    }
    
    @IBAction func backButton(_ sender: Any) {
        let soundURL  = Bundle.main.url(forResource: "cancel", withExtension: "mp3")
        do{
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = 0.1
            player.delegate = self
            player?.play()
        }catch{
            print(error)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //    トップバーに書き込む関数
       func writeTopBar() {
        let realm = try!Realm()
        realm.objects(Player.self)
        let playerData = realm.objects(Player.self)
        
        var myLevel = playerData.last!.MyScore  / 10
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
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = 0.1
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
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = 0.1
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
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = 0.1
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
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player.volume = 0.1
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
