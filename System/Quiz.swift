
//  Quiz.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/11/24.
//

import Foundation
import UIKit

//3択問題
struct Quiz {
     var answer: String
     var section1:String
     var section2:String
     var section3:String
     var sound:String



    init(answer:String,section1:String,section2:String,section3:String,sound:String){
        self.answer = answer
        self.section1 = section1
        self.section2 = section2
        self.section3 = section3
        self.sound = sound
    }
}

//4択問題
struct Quiz4 {
     var answer: String
     var section1:String
     var section2:String
     var section3:String
     var section4:String
     var sound:String

    init(answer:String,section1:String,section2:String,section3:String,section4:String,sound:String){
        self.answer = answer
        self.section1 = section1
        self.section2 = section2
        self.section3 = section3
        self.section4 = section4
        self.sound = sound
    }
}

//6択問題
struct Quiz6 {
     var answer: String
     var section1:String
     var section2:String
     var section3:String
     var section4:String
     var section5:String
     var section6:String
     var sound:String

    init(answer:String,section1:String,section2:String,section3:String,section4:String,section5:String,section6:String,sound:String){
        self.answer = answer
        self.section1 = section1
        self.section2 = section2
        self.section3 = section3
        self.section4 = section4
        self.section5 = section5
        self.section6 = section6
        self.sound = sound
    }
}

//8択問題
struct Quiz7 {
     var answer: String
     var section1:String
     var section2:String
     var section3:String
     var section4:String
     var section5:String
     var section6:String
     var section7:String
     var sound:String

    init(answer:String,section1:String,section2:String,section3:String,section4:String,section5:String,section6:String,section7:String,sound:String){
        self.answer = answer
        self.section1 = section1
        self.section2 = section2
        self.section3 = section3
        self.section4 = section4
        self.section5 = section5
        self.section6 = section6
        self.section7 = section7
        self.sound = sound
    }
}
//8択問題
struct Quiz8 {
     var answer: String
     var section1:String
     var section2:String
     var section3:String
     var section4:String
     var section5:String
     var section6:String
     var section7:String
     var section8:String
     var sound:String

    init(answer:String,section1:String,section2:String,section3:String,section4:String,section5:String,section6:String,section7:String,section8:String,sound:String){
        self.answer = answer
        self.section1 = section1
        self.section2 = section2
        self.section3 = section3
        self.section4 = section4
        self.section5 = section5
        self.section6 = section6
        self.section7 = section7
        self.section8 = section8
        self.sound = sound
    }
}
