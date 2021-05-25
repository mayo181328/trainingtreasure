//
//  Player.swift
//  EnglishStudyApp
//
//  Created by mayo on 2020/12/25.
//

import Foundation
import RealmSwift


class Player: Object {
//    プレイヤー情報
    @objc dynamic var MyScore : Int = 0
    @objc dynamic var MyName : String!
    @objc dynamic var MyCoin : Int = 0
    @objc dynamic var MyJewel : Int = 0
    @objc dynamic var MyStage : String!
    @objc dynamic var MyStageNumber : Int = 0
    @objc dynamic var MySystemNumber : Int = 0
    @objc dynamic var MyDate : Date!
    @objc dynamic var StoryBool : Int = 0
    
    
    

//    今の装備
    @objc dynamic var MyHeadNow : String!
    @objc dynamic var MyBodyNow : String!
    @objc dynamic var MyEyesNow : String!
    @objc dynamic var MyMouthNow : String!
    @objc dynamic var MySkinNow : String!
//    所持品
    let MyHeadItem = List<MyHeadItemList>()
    let MyBodyItem = List<MyBodyItemList>()
    let MyMouthItem = List<MyMouthItemList>()
    let MyEyesItem = List<MyEyesItemList>()
    let MySkinItem = List<MySkinItemList>()
//    ショップ配列
    let ShopHead = List<ShopHeadList>()
    let ShopBody = List<ShopBodyList>()

//    ガチャ配列
    let GachaHead = List<GachaHeadList>()
    let GachaBody = List<GachaBodyList>()
//    苦手
     let weakList = List<WeakList>()
    
//    BGM
    @objc dynamic var BGM : Double = 0.0
    @objc dynamic var Effect : Double = 0.0
    @objc dynamic var Voice : Double = 0.0
    
//    分析
    @objc dynamic var WordCount : Int = 0
    @objc dynamic var ExerciseCount : Int = 0
    
    let WordKnowledge = List<WordKnowledgeList>()
    let BasicsKnowledge = List<BasicsKnowledgeList>()
    let AppliedKnowledge = List<AppliedKnowledgeList>()
    let JudgmentKnowledge = List<JudgmentKnowledgeList>()
    let ThinkingKnowledge = List<ThinkingKnowledgeList>()
    let LisningKnowledge = List<LisningKnowledgeList>()
    
    let LoginDate = List<LoginDateList>()
    
}

//ログイン
class LoginDateList: Object {
    @objc dynamic var Login : String!
}
//分析
class WordKnowledgeList: Object {
    @objc dynamic var Word : Int = 0
}
class BasicsKnowledgeList: Object {
    @objc dynamic var Basics : Int = 0
}
class AppliedKnowledgeList: Object {
    @objc dynamic var Applied : Int = 0
}
class JudgmentKnowledgeList: Object {
    @objc dynamic var Judgment : Int = 0
}
class ThinkingKnowledgeList: Object {
    @objc dynamic var Thinking : Int = 0
}
class LisningKnowledgeList: Object {
    @objc dynamic var Lisning : Int = 0
}
//    所持品
class MyItemList: Object {
    @objc dynamic var MyHeadList : String!
    @objc dynamic var MyBodyList : String!
    @objc dynamic var MyEyesList : String!
    @objc dynamic var MyMouthList : String!
    @objc dynamic var MySkinList : String!
}
class MyHeadItemList: Object {
    @objc dynamic var MyHeadList : String!
}
class MyBodyItemList: Object {
    @objc dynamic var MyBodyList : String!
}
class MyMouthItemList: Object {
    @objc dynamic var MyMouthList : String!
}
class MyEyesItemList: Object {
    @objc dynamic var MyEyesList : String!
}
class MySkinItemList: Object {
    @objc dynamic var MySkinList : String!
}
//    ショップ配列
class ShopHeadList: Object {
    @objc dynamic var ShopHead : String!
}
class ShopBodyList: Object {
    @objc dynamic var ShopBody : String!
}
//ガチャ配列
class GachaHeadList: Object {
    @objc dynamic var GachaHead : String!
}

class GachaBodyList: Object {
    @objc dynamic var GachaBody : String!
}

//苦手
class WeakList: Object {
    @objc dynamic var weakQuiz : String!
}
