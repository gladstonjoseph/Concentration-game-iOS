//
//  Theme.swift
//  Concentration
//
//  Created by Gladston Joseph on 8/8/18.
//  Copyright © 2018 Gladston Joseph. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    var backgroundColor: UIColor
    var cardColor: UIColor
    var cardTitles: [String]
    
    static let halloween = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    static let winter = ["⛄️", "🏔", "🌨", "❄️", "🎿", "🏂", "⛷", "🍵", "🍦"]
    static let sports = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏓", "🏸", "⛳️"]
    
    static let cardTitlesOptions = [halloween, winter, sports]
    static let backgroundColorOptions = [#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)]
    static let cardColorOptions = [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)]
    
    static var previousNumber: Int? // used in randomNumber()
    
    static func randomNumber() {
        var randomNumber = Int(arc4random_uniform(UInt32(Theme.cardTitlesOptions.count)))
        while Theme.previousNumber == randomNumber {
            randomNumber = Int(arc4random_uniform(UInt32(Theme.cardTitlesOptions.count)))
        }
        Theme.previousNumber = randomNumber
        Theme.randomIndex = randomNumber
    }
    
    static var randomIndex: Int?
    
    init() {
        Theme.randomNumber()
        //let randomIndex = Int(arc4random_uniform(UInt32(Theme.cardTitlesOptions.count)))
        self.backgroundColor = Theme.backgroundColorOptions[Theme.randomIndex!]
        self.cardColor = Theme.cardColorOptions[Theme.randomIndex!]
        self.cardTitles = Theme.cardTitlesOptions[Theme.randomIndex!]
    }
}
