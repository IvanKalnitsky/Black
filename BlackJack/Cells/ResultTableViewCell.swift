//
//  ResultTableViewCell.swift
//  BlackJack
//
//  Created by macbookp on 11.08.2021.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func cofigure(name: String, result: String, firstCell: Bool) {
        if firstCell {
            nameLabel.font = UIFont.systemFont(ofSize: 17)
            contentView.backgroundColor = #colorLiteral(red: 0.1269071996, green: 0.3554212451, blue: 0.2191436887, alpha: 1)
            self.nameLabel.text = "NAME"
            self.resultLabel.text = "SCORE"
        } else {
            self.nameLabel.text = name.uppercased()
            self.resultLabel.text = result.uppercased()
            contentView.backgroundColor = #colorLiteral(red: 0.3848692179, green: 0.5036417842, blue: 0.4253953993, alpha: 1)
        }
    }
}
