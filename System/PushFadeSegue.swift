//
//  PushFadeSegue.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/12/24.
//

import UIKit

class PushFadeSegue: UIStoryboardSegue {
    override func perform() {
        UIView.transition(
            with: (source.navigationController?.view)!,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: {
                () -> Void in
                self.source.navigationController?.pushViewController(self.destination, animated: false)
            },
            completion: nil)
    }
}
