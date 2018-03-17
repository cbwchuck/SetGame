//
//  Card.swift
//  SetGame
//
//  Created by Chuck on 2018/3/8.
//  Copyright © 2018年 Chuck. All rights reserved.
//

import Foundation

//struct Cards {

struct card: Equatable {
    static func ==(lhs: card, rhs: card) -> Bool {
        //TODO: Should implement this?
        return true
    }
    static let allSymbols = ["▲","●","■"]
    var number = 1
    var symbol = "▲"
    var shading = 1
    var color = 1
    
    var hasMatched = false
    var isSelected = false
//    var isShowing = false
}
//1 2 3
//三角，圆，方块
//红，绿，紫色
//solid, striped, open
