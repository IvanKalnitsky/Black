//
//  MenuViewController.swift
//  BlackJack
//
//  Created by macbookp on 09.08.2021.
//

import UIKit

class MenuViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var labelImageView: UIImageView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var themeImageView: UIImageView!

    let themesArray: [Themes] = [.classic,.silver,.gold]
    
    var choosedTheme: Themes = .classic {
        didSet {
            switch choosedTheme {
            case .classic:
                themeImageView.image = UIImage(named: "classic")
            case .silver:
                themeImageView.image = UIImage(named: "silver")
            case .gold:
                themeImageView.image = UIImage(named: "gold")
            }
        }
    }

    var counter = 0 {
        didSet {
            choosedTheme = themesArray[counter]
            TopResults.choosedTheme = counter
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        configureBackground()
        configureLabel()
        configureLeftRightButtons()
        configureThemeImageView()
        navigationController?.setNavigationBarHidden(true, animated: false)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        choosedTheme = .classic
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "ToGame" {
            let gameVC = segue.destination as! GameViewController
            if nameTextField.text == "" {
                gameVC.name = "No name"
            } else {
                guard let text = nameTextField.text else { return }
                gameVC.name = text
            }
            gameVC.chossedTheme = choosedTheme
        }
    }

    func configureThemeImageView() {
        switch choosedTheme {
        case .classic:
            themeImageView.image = UIImage(named: "classic")
        case .silver:
            themeImageView.image = UIImage(named: "silver")
        case .gold:
            themeImageView.image = UIImage(named: "gold")
        }
        themeImageView.contentMode = .scaleToFill
        themeImageView.layer.cornerRadius = 30
    }

    func configureLabel() {
        labelImageView.image = UIImage(named: "labelMenu")
        backgroundImageView.contentMode = .scaleToFill

    }

    func configureBackground() {
        backgroundImageView.image = UIImage(named: "bgMenu")
        backgroundImageView.contentMode = .scaleToFill
    }

    func configureLeftRightButtons() {
        guard let leftImage = UIImage(named: "left") else { return }
        guard let rightImage = UIImage(named: "right") else { return }

        leftButton.setImage(leftImage, for: .normal)
        rightButton.setImage(rightImage, for: .normal)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
    }

    @IBAction func leftButtonPressed(_ sender: Any) {
        if counter > 0 {
            counter -= 1
        } else {
            counter = 2
        }
    }
    

    @IBAction func rightButtonPressed(_ sender: Any) {
        if counter < 2 {
            counter += 1
            choosedTheme = themesArray[counter]
        } else {
            counter = 0
            choosedTheme = themesArray[counter]
        }
    }
}
