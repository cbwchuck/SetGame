//
//  ViewController.swift
//  SetGame
//
//  Created by Chuck on 2018/3/8.
//  Copyright © 2018年 Chuck. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    private lazy var game = setGame()
    
    private(set) var cardsLeft = 81
    private(set) var numberOfCardshaveBeenShown = 12
    
    @IBOutlet var cardButton: [UIButton]!
    
    @IBAction func button(_ sender: UIButton) {
        if let cardNumber = cardButton.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateCardView(in: cardButton)
        }else {
            print("Card selected not in cardButton array")
        }
    }
    
    @IBOutlet weak var matchedPair: UILabel!
    
    @IBAction func newGame(_ sender: UIButton) {
        self.game = setGame()
        cardsLeft = 81
        numberOfCardshaveBeenShown = 12
        updateCardView(in: cardButton)
    }
    
    @IBAction func deal3MoreCards(_ sender: UIButton) {
        print("cardsLeft--\(cardsLeft)")
        print("numberOfCardsShowing--\(game.numberOfCardsShowing)")
        print("numberOfCardshaveBeenShown--\(numberOfCardshaveBeenShown)")
        print("numberOfCardCanBeShowed--\(game.numberOfCardCanBeShowed)")
        
        if cardsLeft >= 3 {
            if game.numberOfCardsShowing < game.numberOfCardCanBeShowed {
                fillInBlank(in: cardButton)
                cardsLeft -= 3
            }else if game.numberOfCardCanBeShowed <= 21 {
                game.numberOfCardCanBeShowed += 3
                showMoreCards()
                cardsLeft -= 3
            }
        }
        print("")
        print("cardsLeft--\(cardsLeft)")
        print("numberOfCardsShowing--\(game.numberOfCardsShowing)")
        print("numberOfCardshaveBeenShown--\(numberOfCardshaveBeenShown)")
        print("numberOfCardCanBeShowed--\(game.numberOfCardCanBeShowed)")
        print("")
    }
    
    func fillInBlank(in buttonSet: [UIButton]) {
        var swapCard = card()
        var times = 0
        for cardIndex in 0..<game.numberOfCardCanBeShowed {
            if game.cards[cardIndex].hasMatched && times<3 {
                swapCard = game.cards[numberOfCardshaveBeenShown]
                game.cards[cardIndex] = swapCard
                game.cards[numberOfCardshaveBeenShown] = game.cards[cardIndex]
                numberOfCardshaveBeenShown += 1
                times += 1
                game.numberOfCardsShowing += 1
            }
        }
        updateCardView(in: cardButton)
    }
    
    func showMoreCards() {
        var swapCard = card()
        for i in 1...3 {
            swapCard = game.cards[game.numberOfCardCanBeShowed-i]
            game.cards[game.numberOfCardCanBeShowed-i] = game.cards[numberOfCardshaveBeenShown]
            game.cards[numberOfCardshaveBeenShown] = swapCard
            numberOfCardshaveBeenShown += 1
            game.numberOfCardsShowing += 1
        }
        updateCardView(in: cardButton)
    }
    
    func updateCardView(in buttonSet: [UIButton]) {
        //TODO: finish all the functions
        let solidStyle: [NSAttributedStringKey: Any] = [
            .strokeWidth: 15.0,
            .foregroundColor: UIColor.init(white: 0.8, alpha: 1)
            ]
        let stripedStyle: [NSAttributedStringKey: Any] = [
            .strokeWidth: 15.0,
            .foregroundColor: UIColor.init(white: 0, alpha: 0.5)
        ]
        let openStyle: [NSAttributedStringKey: Any] = [
            .strokeWidth: 15.0,
        ]
        var cardsBeingSelected = [Int]()
        
        matchedPair.text = "Matched Pair: \(game.numberOfMatchedPair)"
        
        for index in 0..<buttonSet.count {
            if !game.cards[index].hasMatched && index < game.numberOfCardCanBeShowed {
                let literal = String(game.cards[index].number) + game.cards[index].symbol
                let shadingOfCard = game.cards[index].shading
                let colorOfCard = game.cards[index].color
                let attritextForSolid = NSAttributedString(string: literal, attributes: solidStyle)
                let attritextForStriped = NSAttributedString(string: literal, attributes: stripedStyle)
                let attritextForOpen = NSAttributedString(string: literal, attributes: openStyle)
                
                switch colorOfCard {
                case 1: buttonSet[index].backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                case 2: buttonSet[index].backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                case 3: buttonSet[index].backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                default: break
                }
                
                switch shadingOfCard {
                case 1:
                    buttonSet[index].setAttributedTitle(attritextForSolid, for: UIControlState.normal)
                case 2:
                    buttonSet[index].setAttributedTitle(attritextForStriped, for: UIControlState.normal)
                case 3:
                    buttonSet[index].setAttributedTitle(attritextForOpen, for: UIControlState.normal)
                default: break
                }
                
                //MARK:选中后的操作
                if game.cards[index].isSelected {
                    cardsBeingSelected.append(index)
                    buttonSet[index].layer.borderWidth = 8.0
                    buttonSet[index].layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                } else {
                    buttonSet[index].layer.borderWidth = 0.0
                    buttonSet[index].layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                }
                
                if cardsBeingSelected.count == 3 {
                    if game.matchedDetector(card1Index: cardsBeingSelected[0], card2Index: cardsBeingSelected[1], card3Index: cardsBeingSelected[2]) {
                        game.numberOfMatchedPair += 1
                        game.numberOfCardsShowing -= 3
                        cardsBeingSelected.removeAll()
                        updateCardView(in: buttonSet)
                    } else {
                        game.chooseCard(at: cardsBeingSelected[0])
                        game.chooseCard(at: cardsBeingSelected[1])
                        game.chooseCard(at: cardsBeingSelected[2])
                        cardsBeingSelected.removeAll()
                        updateCardView(in: buttonSet)
                    }
                }
            } else {
                buttonSet[index].layer.borderWidth = 0.0
                buttonSet[index].layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                buttonSet[index].setAttributedTitle(NSAttributedString.init(string: ""), for: UIControlState.normal)
                buttonSet[index].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCardView(in: cardButton)
    }
    
}
