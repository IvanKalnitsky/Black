//
//  CardCollectionViewCell.swift
//  BlackJack
//
//  Created by macbookp on 05.08.2021.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    let height = UIScreen.main.bounds.height * 0.18
    var width: CGFloat {
        height * 0.7
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func configure(card: PlayingCard, isOpen: Bool, theme: Themes?) {
        guard let image = UIImage(named: card.description) else { return }
        if isOpen {
            imageView.image = image
        } else {
            switch theme {
            case .silver:
                imageView.image = UIImage(named: "backSilver")
            case .gold:
                imageView.image = UIImage(named: "backGold")
            default:
                imageView.image = UIImage(named: "back")
            }
        }
    }
}
