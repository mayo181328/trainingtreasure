//
//  LoadViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/02/01.
//

import UIKit



class LoadViewController: UIViewController {
    
    var shopName : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.performSegue(withIdentifier: "Segue", sender: nil)
        }
    }
    
    //    値渡し
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "Segue") {
                let NCViewController = segue.destination as! HomeShopHeadViewController
                NCViewController.shopName = shopName
            }
        }
    


}
