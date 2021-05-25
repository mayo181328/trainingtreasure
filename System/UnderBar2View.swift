//
//  TopBarView.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/12/23.
//


import UIKit

protocol ButtonTapDelegate {
    func practiceButtonTap()
    func storyButtonTap()
    func homeButtonTap()
    func gachaButtonTap()
}

class UnderBar2View: UIView  {
    
    var delegate: ButtonTapDelegate?
    
    @IBAction func practiceButton(_ sender: UIButton) {
        self.delegate?.practiceButtonTap()
    }
    
    @IBAction func storyButton(_ sender: UIButton) {
        self.delegate?.storyButtonTap()
    }
    @IBAction func homeButton(_ sender: UIButton) {
        self.delegate?.homeButtonTap()
    }
    @IBAction func gachaButton(_ sender: UIButton) {
        self.delegate?.gachaButtonTap()
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





