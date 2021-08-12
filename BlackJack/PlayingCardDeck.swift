//
//  PlayingCardDeck.swift
//  BlackJack
//
//  Created by macbookp on 05.08.2021.
//

import Foundation

struct PlayingCardDeck {
    private(set) var cards = [PlayingCard]()

    mutating func draw() -> PlayingCard? {
        if cards.count > 0 {
            return cards.remove(at: Int.random(in: 0...cards.count - 1 ))
        } else {
            return nil
        }
    }

    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank,isOpen: true))
            }
        }
    }
}
