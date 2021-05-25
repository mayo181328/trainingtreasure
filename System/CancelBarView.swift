//
//  CancelBarView.swift
//  EnglishStudyApp
//
//  Created by mayo on 2021/01/21.
//

import UIKit

protocol CancelTapDelegate {
    func CancelButtonTap()
}

class CancelBarView: UIView {
    
    @IBOutlet weak var Label: UILabel!
    
    var delegate: CancelTapDelegate?
    

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
    
    @IBAction func cancelBarButton(_ sender: Any) {
        self.delegate?.CancelButtonTap()
    }
}
