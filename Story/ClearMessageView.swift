//
//  ClearMessageView.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/23.
//

import UIKit

protocol cancelTapStoryDelegate {
    func cancelButtonTap()
}

class ClearMessageView: UIView {
    
    var delegate: cancelTapStoryDelegate?

    @IBAction func cancelButton(_ sender: UIButton) {
        self.delegate?.cancelButtonTap()
    }
    
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
