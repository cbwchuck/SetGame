//
//  SetGame.swift
//  SetGame
//
//  Created by Chuck on 2018/3/8.
//  Copyright © 2018年 Chuck. All rights reserved.
//

import Foundation

struct setGame {
    var cards = [card]()
    var numberOfCardsShowing = 12
    var numberOfCardCanBeShowed = 12
    var numberOfMatchedPair = 0
    
    mutating func chooseCard(at index: Int) {
//        cards[index].isShowing = true
        if !cards[index].hasMatched {
        cards[index].isSelected = !cards[index].isSelected
        }
    }
    
    mutating func matchedDetector(card1Index Index1: Int, card2Index Index2 : Int, card3Index Index3: Int) -> Bool {
        if cards[Index1].color == cards[Index2].color && cards[Index2].color != cards[Index3].color{
            return false
        }else if cards[Index1].color == cards[Index3].color && cards[Index3].color != cards[Index2].color{
            return false
        }else if cards[Index2].color == cards[Index3].color && cards[Index1].color != cards[Index2].color{
            return false
        }else if cards[Index1].number == cards[Index2].number && cards[Index2].number != cards[Index3].number {
            return false
        }else if cards[Index1].number == cards[Index3].number && cards[Index3].number != cards[Index2].number{
            return false
        }else if cards[Index2].number == cards[Index3].number && cards[Index1].number != cards[Index2].number{
            return false
        }else if cards[Index1].shading == cards[Index2].shading && cards[Index2].shading != cards[Index3].shading {
            return false
        }else if cards[Index1].shading == cards[Index3].shading && cards[Index3].shading != cards[Index2].shading {
            return false
        }else if cards[Index2].shading == cards[Index3].shading && cards[Index1].shading != cards[Index2].shading {
            return false
        }else if cards[Index1].symbol == cards[Index2].symbol && cards[Index2].symbol != cards[Index3].symbol {
            return false
        }else if cards[Index1].symbol == cards[Index3].symbol && cards[Index3].symbol != cards[Index2].symbol{
            return false
        }else if cards[Index2].symbol == cards[Index3].symbol && cards[Index1].symbol != cards[Index2].symbol {
            return false
        }else {
//            cards.remove(at: Index1)
//            cards.remove(at: Index2)
//            cards.remove(at: Index3)
            cards[Index1].hasMatched = true
//            cards[Index1].isShowing = false
            cards[Index2].hasMatched = true
//            cards[Index2].isShowing = false
            cards[Index3].hasMatched = true
//            cards[Index3].isShowing = false
            return true
        }
    }
    
    
    init(){
        var cardToBePut = card()
        var swapCard = card()
        for indexOfNumber in 1...3 {
            for indexOfSymbol in 0..<3 {
                for indexOfShading in 1...3 {
                    for indexOfColor in 1...3 {
                        cardToBePut.number = indexOfNumber
                        cardToBePut.symbol = card.allSymbols[indexOfSymbol]
                        cardToBePut.shading = indexOfShading
                        cardToBePut.color = indexOfColor
                        cards.append(cardToBePut)
                    }
                }
            }
        }
        for cardToSwapIndex in 0..<cards.count {
            let randomIndex = cards.count.arc4random
            swapCard = cards[cardToSwapIndex]
            cards[cardToSwapIndex] = cards[randomIndex]
            cards[randomIndex] = swapCard
        }
    }
}

//让Int有产生随机数的功能
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
