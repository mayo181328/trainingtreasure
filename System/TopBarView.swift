//
//  TopBarView.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/12/23.
//

import UIKit

class TopBarView: UIView {
    
    
    @IBOutlet weak var LevelLabel : UILabel!
    @IBOutlet weak var NameLabel : UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var JewelLabel : UILabel!
    @IBOutlet weak var StageLabel : UILabel!
    
    override init(frame: CGRect) {
           super.init(frame: frame)
        configure()
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)!
        configure()
       }
    private func configure() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
    }
}
}
