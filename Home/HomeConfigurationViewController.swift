//
//  HomeConfigurationViewController.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/11/23.
//

import UIKit

class HomeConfigurationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popToViewController((navigationController?.viewControllers [0])!, animated: true)
    }
}
