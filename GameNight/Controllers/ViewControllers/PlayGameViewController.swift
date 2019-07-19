//
//  PlayGameViewController.swift
//  GameNight
//
//  Created by Timothy Rosenvall on 7/18/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController {
    
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var hangmanWordLabel: UILabel!
    @IBOutlet weak var wrongLetterCollectionView: UICollectionView!
    @IBOutlet weak var chooseLetterCollectionView: UICollectionView!
    @IBOutlet weak var restartGameButton: UIButton!
    @IBOutlet weak var newWordButton: UIButton!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var leftArmImageView: UIImageView!
    @IBOutlet weak var rightArmImageView: UIImageView!
    @IBOutlet weak var hangmanBodyView: UIView!
    @IBOutlet weak var leftLeftImageView: UIImageView!
    @IBOutlet weak var rightLetImageView: UIImageView!
    @IBOutlet weak var backgroundOverlayView: UIView!
    @IBOutlet weak var endGameView: UIView!
    @IBOutlet weak var endGameImageHolderView: UIView!
    @IBOutlet weak var endGameImageView: UIImageView!
    @IBOutlet weak var endGameLabel: UILabel!
    @IBOutlet weak var endGameRestartButton: UIButton!
    @IBOutlet weak var endGameNewWordButton: UIButton!
    
    
    var wrongLetters: [String] = []
    var usedLetters: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WordsController.shared.createRandomWord()
        self.backgroundOverlayView.isHidden = true
        self.endGameView.isHidden = true
        setupViews()
    }
    
    
    @IBAction func restartGameButtonTapped(_ sender: Any) {
        restartGame()
    }
    
    @IBAction func newGameButtonTapped(_ sender: Any) {
        newGame()
    }
    
    @IBAction func endGameRestartButtonTapped(_ sender: Any) {
        restartGame()
        fadeOut()
    }
    
    @IBAction func endGameNewWordButtonTapped(_ sender: Any) {
        newGame()
        fadeOut()
    }
    
    func youWin() {
        endGameImageView.image = #imageLiteral(resourceName: "YouWin")
        endGameLabel.text = "YOU WIN"
        fadeIn()
    }
    
    func gameOver() {
        endGameImageView.image = #imageLiteral(resourceName: "GameOver")
        endGameLabel.text = "YOU LOST"
        fadeIn()
    }
    
    func fadeIn () {
        UIView.animate(withDuration: 1.5) {
            DispatchQueue.main.async {
                self.backgroundOverlayView.isHidden = false
                self.endGameView.isHidden = false
            }
        }
    }
    
    func fadeOut () {
        UIView.animate(withDuration: 1.5) {
            DispatchQueue.main.async {
                self.backgroundOverlayView.isHidden = true
                self.endGameView.isHidden = true
            }
        }
    }
    
    func setupViews() {
        feedbackLabel.text = ""
        WordsController.shared.createHangManTemplate()
        hangmanWordLabel.text = WordsController.shared.hangmanWord
        headImageView.isHidden = true
        hangmanBodyView.isHidden = true
        leftArmImageView.isHidden = true
        rightArmImageView.isHidden = true
        leftLeftImageView.isHidden = true
        rightLetImageView.isHidden = true
    }
    
    func restartGame() {
        setupViews()
        wrongLetters = []
        usedLetters = []
        wrongLetterCollectionView.reloadData()
        chooseLetterCollectionView.reloadData()
    }
    
    func newGame() {
        setupViews()
        wrongLetters = []
        usedLetters = []
        WordsController.shared.createRandomWord()
        wrongLetterCollectionView.reloadData()
        chooseLetterCollectionView.reloadData()
    }
}

extension PlayGameViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    // Wrong Letter Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == chooseLetterCollectionView {
            return AlphabetController.alphabet.count
        } else {
            return self.wrongLetters.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == chooseLetterCollectionView {
            
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "letterCell", for: indexPath) as? LetterCollectionViewCell else {return UICollectionViewCell()}
            let letter = String(AlphabetController.alphabet[indexPath.row])
            cell.letterLabel.text = letter
            if usedLetters.contains(letter) {
                cell.backgroundColor = UIColor.lightGray
                cell.letterLabel.textColor = UIColor.black
            } else {
                cell.backgroundColor = UIColor.red
                cell.letterLabel.textColor = UIColor.white
            }
            return cell
            
            
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wrongCell", for: indexPath) as? wrongLetterCollectionViewCell else {return UICollectionViewCell()}
                cell.wrongLetterLabel.text = wrongLetters[indexPath.row]
                cell.isUserInteractionEnabled = false
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let letter = AlphabetController.alphabet[indexPath.row]
        if !usedLetters.contains("\(letter)") {
            if WordsController.shared.word.contains(letter) {
                usedLetters.append("\(letter)")
                WordsController.shared.updateHangManWord(letter: letter)
                hangmanWordLabel.text = WordsController.shared.hangmanWord
                feedbackLabel.text = WordsController.shared.createCorrectAnswerFeedback()
                chooseLetterCollectionView.reloadData()
            } else {
                usedLetters.append("\(letter)")
                wrongLetters.append("\(letter)")
                wrongLetterCollectionView.reloadData()
                chooseLetterCollectionView.reloadData()
                feedbackLabel.text = WordsController.shared.createWrongAnswerFeedback()
                if headImageView.isHidden == true {
                    headImageView.isHidden = false
                } else if hangmanBodyView.isHidden == true {
                    hangmanBodyView.isHidden = false
                } else if leftArmImageView.isHidden == true {
                    leftArmImageView.isHidden = false
                } else if rightArmImageView.isHidden == true {
                    rightArmImageView.isHidden = false
                } else if leftLeftImageView.isHidden == true {
                    leftLeftImageView.isHidden = false
                } else {
                    rightLetImageView.isHidden = false
                }
            }
            if WordsController.shared.hangmanWord == WordsController.shared.word {
                youWin()
            }
            if wrongLetters.count == 6 {
                gameOver()
            }
        }
    }
}
