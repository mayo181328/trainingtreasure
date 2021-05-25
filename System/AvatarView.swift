//
//  AvatarView.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/19.
//

import UIKit

class AvatarView: UIView {
    
    @IBOutlet weak var skinImage: UIImageView!
    @IBOutlet weak var mouthImage: UIImageView!
    @IBOutlet weak var eyeImage: UIImageView!
    @IBOutlet weak var bodyImage: UIImageView!
    @IBOutlet weak var headImage: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        if let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
