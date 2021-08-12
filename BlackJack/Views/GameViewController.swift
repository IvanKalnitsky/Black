//
//  ViewController.swift
//  BlackJack
//
//  Created by macbookp on 05.08.2021.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var compCollectionVIew: UICollectionView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var compCountLabel: UILabel!
    @IBOutlet weak var myCountLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var betLabel: UILabel!
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var standButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    @IBOutlet weak var fiftyButton: UIButton!
    @IBOutlet weak var oneHundredButton: UIButton!
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var coinsImageVIew: UIImageView!
    @IBOutlet weak var coinsStackVIew: UIStackView!

    var chossedTheme: Themes?
    var isTimeForBet = true
    var isTimeForDeal = true
    var deck = PlayingCardDeck()
    var name = ""
    let heightOfCards = UIScreen.main.bounds.height * 0.18

    var widthOfCards: CGFloat {
        return heightOfCards * 0.7
    }

    let deckImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.layer.cornerRadius = 5
        return imageView
    }()

    let resultImageView = UIImageView()

    var playerCoins = 1000 {
        didSet {
            coinsLabel.text = "\(playerCoins)"
            checkResult()
        }
    }

    var bet = 0 {
        didSet {
            betLabel.text = "\(bet)"
        }
    }

    var compCounter = 0 {
        didSet {
            compCountLabel.text = "\(compCounter)"
        }
    }

    var playerCounter = 0 {
        didSet {
            myCountLabel.text = "\(playerCounter)"
        }
    }

    var compCards = [PlayingCard]() {
        didSet {
            compCollectionVIew.reloadData()
        }
    }

    var playerCards = [PlayingCard]() {
        didSet {
            myCollectionView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layoutBackGroundImage()
        layoutBetButtons()
        layoutCoinsImage()
        resultImageView.isHidden = true
        layOutCollections()
        layootDeckImageView()
        layoutCardImageView()
        layoutResultImage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        compCountLabel.isHidden = true
        playerCoins = 1000
        bet = 0
        configureCollectiionViews()
        hitButton.isHidden = true
        standButton.isHidden = true

    }



    //MARK: - CONFIGURE and LAYOUT VIEWS

    func layoutResultImage() {
        view.addSubview(resultImageView)
        resultImageView.frame = CGRect(x: 0, y: 0, width: 250, height: 80)
        resultImageView.center = CGPoint(x: view.center.x, y: view.center.y - 30)
    }

    func layoutCardImageView() {
        view.addSubview(cardImageView)
        switch chossedTheme {
        case .classic:
            cardImageView.image = UIImage(named: "back")
        case .silver:
            cardImageView.image = UIImage(named: "backSilver")
        default:
            cardImageView.image = UIImage(named: "backGold")
        }

        cardImageView.frame = CGRect(x: deckImageView.frame.origin.x, y: deckImageView.frame.origin.y, width: widthOfCards, height: heightOfCards)

        cardImageView.isHidden = true
    }

    func layoutBackGroundImage() {
        backGroundImageView.contentMode = .scaleToFill
        switch chossedTheme {
        case .classic:
            backGroundImageView.image = UIImage(named: "bgClassic")
        case .silver:
            backGroundImageView.image = UIImage(named: "bgSilver")
        case .gold:
            backGroundImageView.image = UIImage(named: "bgGold")
        case .none:
            break
        }
    }

    func layoutBetButtons() {
        switch chossedTheme {
        case .classic, .silver:
            tenButton.setBackgroundImage(UIImage(named: "10"), for: .normal)
            fiftyButton.setBackgroundImage(UIImage(named: "50"), for: .normal)
            oneHundredButton.setBackgroundImage(UIImage(named: "100"), for: .normal)
        case .gold:
            tenButton.setBackgroundImage(UIImage(named: "10gold"), for: .normal)
            fiftyButton.setBackgroundImage(UIImage(named: "50gold"), for: .normal)
            oneHundredButton.setBackgroundImage(UIImage(named: "100gold"), for: .normal)
        default: break
        }
    }

    func layoutCoinsImage() {
        switch chossedTheme {
        case .classic,.silver:
            coinsImageVIew.image = UIImage(named: "coinsClassic")
            coinsLabel.textColor = .white
            betLabel.textColor = .white
            myCountLabel.textColor = .white
            compCountLabel.textColor = .white
        default:
            coinsImageVIew.image = UIImage(named: "coinsGold")
            coinsLabel.textColor = .black
            betLabel.textColor = .black
            myCountLabel.textColor = .black
            compCountLabel.textColor = .black
        }
    }

    func layOutCollections() {
        compCollectionVIew.heightAnchor.constraint(equalToConstant: heightOfCards).isActive = true
        myCollectionView.heightAnchor.constraint(equalToConstant: heightOfCards).isActive = true
    }

    func layootDeckImageView() {
        view.addSubview(deckImageView)
        deckImageView.contentMode = .scaleToFill
        deckImageView.layer.cornerRadius = 5
        deckImageView.frame = CGRect(x: 0, y: 0, width: widthOfCards , height: heightOfCards)
        deckImageView.center = CGPoint(x: view.frame.maxX - 50 - widthOfCards / 2, y: view.frame.midY - 15 - 30)
        switch chossedTheme {
        case .classic:
            deckImageView.image = UIImage(named: "deck")
        case .silver:
            deckImageView.image = UIImage(named: "deckSilver")
        default:
            deckImageView.image = UIImage(named: "deckGold")
        }
    }

    //MARK: - METHODS

    func animateCard(toPlayer: Bool?) {
        UIView.animate(withDuration: 0.2) { [self] in
            cardImageView.isHidden = false
            let destinationPointBottom = CGPoint(x: self.view.bounds.minX + 50, y: self.view.bounds.maxY - 140 - (heightOfCards / 2))
            let destinationPointTop = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.minY + 80 + (heightOfCards / 2))
            switch toPlayer {
            case true:
                cardImageView.center = destinationPointBottom
            default:
                cardImageView.center = destinationPointTop
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                cardImageView.isHidden = true
                cardImageView.frame = CGRect(x: deckImageView.frame.origin.x, y: deckImageView.frame.origin.y, width: widthOfCards, height: heightOfCards)
                switch toPlayer {
                case true:
                    self.playerTakesCard()
                case false:
                    self.compTakesCard()
                default: break
                }
            }
        }
    }

    func configureCollectiionViews() {
        compCollectionVIew.delegate = self
        compCollectionVIew.dataSource = self
        compCollectionVIew.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    func startGame() {
        animateCard(toPlayer: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.animateCard(toPlayer: false)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.animateCard(toPlayer: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.animateCard(toPlayer: false)
            self.hitButton.isHidden = false
            self.standButton.isHidden = false
        }


        compCollectionVIew.reloadData()
        myCollectionView.reloadData()
    }

    func compTakesCard() {
        guard var compDropCard = deck.draw() else { return }
        if !compCards.isEmpty {
            compDropCard.isOpen = false
        }
        compCounter += compDropCard.rank.order!
        compCards.append(compDropCard)
    }

    func playerTakesCard() {
        guard let myDropCard = deck.draw() else { return }
        playerCounter += myDropCard.rank.order!
        playerCards.insert(myDropCard, at: 0)
    }

    func openCardsFor(_ cards: [PlayingCard]) -> [PlayingCard] {
        var newCards = [PlayingCard]()
        for card in cards {
            let newCard = PlayingCard(suit: card.suit, rank: card.rank, isOpen: true)
            newCards.append(newCard)
        }
        return newCards
    }

    func win() {
        resultImageView.image = UIImage(named: "win")
        resultImageView.isHidden = false
        playerCoins += 2 * bet
        bet = 0
    }

    func lose() {
        resultImageView.image = UIImage(named: "lose")
        resultImageView.isHidden = false
        bet = 0
    }

    func draw() {
        resultImageView.image = UIImage(named: "tie")
        resultImageView.isHidden = false
        playerCoins += bet
        bet = 0
    }

    func gameResult() {
        deckImageView.isHidden = true
        let playerDifCount = playerCounter - 21
        let compDifCount = compCounter - 21
        if compCounter == playerCounter {
            draw()
        } else if compCounter > 21 && playerCounter > 21 {
            if playerDifCount < compDifCount {
                win()
            } else {
                lose()
            }
        } else if compCounter > 21 {
            win()
        } else if playerCounter > 21 {
            lose()
        } else if compCounter > playerCounter {
            lose()
        } else {
            win()
        }
    }

    func checkResult() {
        if TopResults.topResult == nil {
            TopResults.topResult = 1000
        }
        if TopResults.resultsArray == nil {
            TopResults.resultsArray = [Int]()
            TopResults.namesArray = [String]()
        } else if playerCoins > TopResults.topResult {
            TopResults.topResult = playerCoins
            TopResults.resultsArray.insert(playerCoins, at: 0)
            TopResults.namesArray.insert(name, at: 0)
        }
    }

    func hideCoinsButtons() {
        resetButton.isHidden = !resetButton.isHidden
        tenButton.isHidden = !tenButton.isHidden
        fiftyButton.isHidden = !fiftyButton.isHidden
        oneHundredButton.isHidden = !oneHundredButton.isHidden
    }

    //MARK: - IBActions

    @IBAction func takeCardDidPressed(_ sender: UIButton) {
        guard !isTimeForBet else { return }
        if playerCounter < 21 {
            animateCard(toPlayer: true)
        }
    }

    @IBAction func standButtonDidPressed(_ sender: UIButton) {
        var isCompTakeCard = false
        guard !isTimeForBet else { return }
        while compCounter < 17 {
            compTakesCard()
            isCompTakeCard = true
        }
                if isCompTakeCard {
                    animateCard(toPlayer: nil)
                }
        isTimeForBet = true
        compCountLabel.isHidden = false
        dealButton.isHidden = false
        gameResult()
        compCards = openCardsFor(compCards)
        compCollectionVIew.reloadData()
        hitButton.isHidden = true
        standButton.isHidden = true
    }

    @IBAction func dealButtonPressed(_ sender: UIButton) {
        if isTimeForDeal {
            guard bet > 0 else { return }
            dealButton.isHidden = true
            dealButton.setImage(UIImage(named: "newGame"), for: .normal)
            isTimeForDeal = false
            isTimeForBet = false
            startGame()
            hideCoinsButtons()
            myCountLabel.isHidden = false
        } else if isTimeForBet {
            isTimeForDeal = true
            dealButton.setImage(UIImage(named: "deal"), for: .normal)
            playerCounter = 0
            compCounter = 0
            compCards = [PlayingCard]()
            playerCards = [PlayingCard]()
            deck = PlayingCardDeck()
            compCountLabel.isHidden = true
            resultImageView.isHidden = true
            myCountLabel.isHidden = true
            deckImageView.isHidden = false
            hideCoinsButtons()
        }
    }

    @IBAction func resetScoreButtonPressed(_ sender: Any) {
        guard isTimeForBet else { return }
        playerCoins += bet
        bet = 0
    }

    @IBAction func tenCoinsButtonPresed(_ sender: Any) {
        guard isTimeForBet, playerCoins >= 10 else { return }
        bet += 10
        playerCoins -= 10
    }

    @IBAction func fiftyCoinsButtonPresed(_ sender: Any) {
        guard isTimeForBet, playerCoins >= 50 else { return }
        bet += 50
        playerCoins -= 50
    }

    @IBAction func oneHundredCoinsButtonPresed(_ sender: Any) {
        guard isTimeForBet, playerCoins >= 100 else { return }
        bet += 100
        playerCoins -= 100
    }
}

//MARK: TableViewDELEGATE DATASOURCE

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == compCollectionVIew {
            return compCards.count
        } else {
            return playerCards.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = compCollectionVIew.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardCollectionViewCell
        if collectionView == compCollectionVIew {
            let card = compCards[indexPath.item]
            cell.configure(card: card, isOpen: card.isOpen, theme: chossedTheme)
            return cell
        } else {
            let card = playerCards[indexPath.item]
            cell.configure(card: card, isOpen: card.isOpen, theme: chossedTheme)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == compCollectionVIew {
            return spacingBetweenCards(cards: compCards)
        } else {
            return spacingBetweenCards(cards: playerCards)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == myCollectionView {
            UIView.animate(withDuration: 0.3, animations: {
                let newFrame = cell.frame
                cell.frame = CGRect(x: newFrame.origin.x + 50, y: newFrame.origin.y, width: newFrame.width, height: newFrame.height)
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                let newFrame = cell.frame
                cell.frame = CGRect(x: newFrame.origin.x + 20, y: newFrame.origin.y, width: newFrame.width, height: newFrame.height)
            })
        }

    }

    func spacingBetweenCards(cards: [PlayingCard]) -> CGFloat {
        let inset = widthOfCards * 0.1
        switch cards.count {
        case 0...2:
            return inset
        case 3,4:
            return -2 * inset
        case 5:
            return -4 * inset
        case 6:
            return -6 * inset
        case 7,8:
            return -7 * inset
        default:
            return -7.5 * inset
        }
    }

}
