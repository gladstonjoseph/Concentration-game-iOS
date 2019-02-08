//
//  ViewController.swift
//  Concentration
//
//  Created by Gladston Joseph on 6/26/18.
//  Copyright © 2018 Gladston Joseph. All rights reserved.
///Users/gladstonjoseph/xCode/Concentration/Concentration/Concentration.swift

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count + 1) / 2
        }
    }
    
    var theme = Theme()
    
    var cardsColor: UIColor?
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var newButton: UIButton!
    
    @IBAction func newGameButton(_ sender: UIButton) {
        game.stopTimer()
        emoji.removeAll()
        game.cards.removeAll()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        scoreLabel.text = "Score: \(game.finalScore ?? 0)"
        updateViewFromModel(cardColor: cardsColor!)
        theme = Theme()
        settingTheme()
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel(cardColor: cardsColor!)
        } else {
            print("Chosen card was not in CardButtons")
        }
    }
    
    func settingTheme() {
        self.view.backgroundColor = theme.backgroundColor
        cardsColor = theme.cardColor
        emojiChoices = theme.cardTitles
        scoreLabel.textColor = theme.backgroundColor
        flipCountLabel.textColor = theme.backgroundColor
        newButton.backgroundColor = theme.cardColor
        updateViewFromModel(cardColor: cardsColor!)
    }
    
    override func viewDidLoad() {
        settingTheme()
    }
    
    
    func updateViewFromModel(cardColor: UIColor) {
        if game.flipCount > 0 {
            flipCountLabel.textColor = theme.cardColor
        }
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : cardColor
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        if game.finalScore != nil {
            scoreLabel.textColor = theme.cardColor
            scoreLabel.text = "Score: \(game.finalScore ?? 0)"
        }
    }
    
    
    var emojiChoices = [String]()
    
    var emoji = [Int: String]()

    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

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

