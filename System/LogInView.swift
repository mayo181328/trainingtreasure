//
//  LogInView.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/24.
//

import UIKit

protocol cancelTapLogInDelegate {
    func cancelButtonTap()
}

class LogInView: UIView {
    var delegate: cancelTapLogInDelegate?

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
