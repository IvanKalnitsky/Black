//
//  Cards.swift
//  BlackJack
//
//  Created by macbookp on 05.08.2021.
//

import Foundation

struct PlayingCard : CustomStringConvertible {
    var description: String {
        return "\(rank)\(suit)"
    }

    var suit: Suit
    var rank: Rank
    var isOpen: Bool

    enum Rank: CustomStringConvertible {
        var description: String {
            switch self {
            case .ace:
                return "A"
            case .face(let kind):
                return kind
            case .numeric(let pips):
                return "\(pips)"
            }
        }

        case ace
        case face(String)
        case numeric(Int)

        var order: Int? {
            switch self {
            case .ace:
                return 11
            case .numeric(let pips):
                return pips
            case .face(let kind) where kind == "J":
                return 10
            case .face(let kind) where kind == "Q":
                return 10
            case .face(let kind) where kind == "K":
                return 10
            default:
                return nil
            }
        }

        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for i in 2...10 {
                allRanks.append(.numeric(i))
            }
            allRanks += [.face("J"),.face("Q"),.face("K")]
            return allRanks
        }

    }
    enum Suit: String, CustomStringConvertible {
        var description: String {
            return rawValue
        }
        case spades = "♠️"
        case hearts = "♥️"
        case clubs = "♣️"
        case diamonds = "♦️"
        static var all = [Suit.spades,.hearts,.clubs,.diamonds]
    }
}
