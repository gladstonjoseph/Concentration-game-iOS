//
//  Concentration.swift
//  Concentration
//
//  Created by Gladston Joseph on 6/26/18.
//  Copyright © 2018 Gladston Joseph. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private var seenCards = [0]
    private var cardAlreadySeen: Int?
    
    private var numberOfPairsOfCards: Int
    private var numberOfMatches = 0
        
    private var matchedScore = 0
    private var mismatchedScore = 0
    private var score: Double = 0
    var finalScore: Int?
    
    var flipCount = 0
    
    func chooseCard(at index: Int) {
        if flipCount == 0 {
            runTimer()
        }
        flipCount = flipCount + 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // Check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    numberOfMatches = numberOfMatches + 1
                    matchedScore = matchedScore + 2
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                } else {
                    if cardAlreadySeen != nil, cards[index].identifier != cardAlreadySeen {
                        mismatchedScore = mismatchedScore - 1
                    }
                }
                cards[index].isFaceUp = true
            } else {
                if seenCards.contains(cards[index].identifier) {
                    cardAlreadySeen = cards[index].identifier
                }
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        score = Double(matchedScore + mismatchedScore)
        seenCards.append(cards[index].identifier)
        if numberOfMatches == numberOfPairsOfCards {
            stopTimer()
            finalScore = Int((score / Double(elapsedTime)) * 100)
        }
    }
    
    var timer = Timer()
    var elapsedTime = 0

    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(Concentration.updateTimer)), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        elapsedTime = elapsedTime + 1
        //        timerLabel.text = timeString(time: TimeInterval(seconds))
        //        timerLabel.text = String(seconds)
        //            labelButton.setTitle(timeString(time: TimeInterval(seconds)), for: UIControlState.normal)
    }

    func stopTimer() {
        timer.invalidate()
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // ToDo: Shuffle the cards
        var shuffledCards = [Card]()
        for _ in cards {
            let randomNumber = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledCards.append(cards[randomNumber])
            cards.remove(at: randomNumber)
        }
        cards = shuffledCards
        self.numberOfPairsOfCards = numberOfPairsOfCards
    }
}
