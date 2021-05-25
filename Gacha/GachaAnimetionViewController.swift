//
//  GachaAnimetionViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/12/28.
//

import UIKit
import AVFoundation
import RealmSwift

class GachaAnimetionViewController: UIViewController , AVAudioPlayerDelegate {
    
    @IBOutlet weak var AnimationImage: UIImageView!
    @IBOutlet weak var topBar: TopBarView!
    
    var player : AVAudioPlayer!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        animation()
        }
    override func viewDidAppear(_ animated: Bool) {
        writeTopBar()
    }


    func animation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        let soundURL  = Bundle.main.url(forResource: "open", withExtension: "mp3")
        do{
            let realm = try!Realm()
            let SoundData = realm.objects(Player.self).last
            self.player = try AVAudioPlayer(contentsOf: soundURL!)
            self.player.volume = Float(0.5 * SoundData!.Effect )
            self.player.delegate = self
            self.player?.play()
        }catch{
            print(error)
        }
        }
        // アニメーション用の画像
                let image1 = UIImage(named:"animetion1_gacha")!
                let image2 = UIImage(named:"animetion2_gacha")!
                let image3 = UIImage(named:"animetion3_gacha")!
                let image4 = UIImage(named:"animetion4_gacha")!
                
        
            self.AnimationImage.image = image1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.AnimationImage.image = image2
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.AnimationImage.image = image3
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.AnimationImage.image = image4
        }


        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.performSegue(withIdentifier: "Segue", sender: nil)
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
}
