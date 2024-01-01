//
//  ViewController.swift
//  CatchTheTinkerBell
//
//  Created by Gizemnur Özden on 28.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var counter = 0
    var score = 0
    var tinkArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var tink1: UIImageView!
    @IBOutlet weak var tink2: UIImageView!
    @IBOutlet weak var tink3: UIImageView!
    @IBOutlet weak var tink4: UIImageView!
    @IBOutlet weak var tink5: UIImageView!
    @IBOutlet weak var tink6: UIImageView!
    @IBOutlet weak var tink7: UIImageView!
    @IBOutlet weak var tink8: UIImageView!
    @IBOutlet weak var tink9: UIImageView!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        scoreLabel.text = "Score \(score)"
        
        //High Score check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore : \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
            
        }
        
        
        //Images
        tink1.isUserInteractionEnabled = true    //tıklanabilirlik doğru yaptık.
        tink2.isUserInteractionEnabled = true
        tink3.isUserInteractionEnabled = true
        tink4.isUserInteractionEnabled = true
        tink5.isUserInteractionEnabled = true
        tink6.isUserInteractionEnabled = true
        tink7.isUserInteractionEnabled = true
        tink8.isUserInteractionEnabled = true
        tink9.isUserInteractionEnabled = true
        
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
    
        
        tink1.addGestureRecognizer(recognizer1)
        tink2.addGestureRecognizer(recognizer2)
        tink3.addGestureRecognizer(recognizer3)
        tink4.addGestureRecognizer(recognizer4)
        tink5.addGestureRecognizer(recognizer5)
        tink6.addGestureRecognizer(recognizer6)
        tink7.addGestureRecognizer(recognizer7)
        tink8.addGestureRecognizer(recognizer8)
        tink9.addGestureRecognizer(recognizer9)
        
        
        
        tinkArray = [tink1 , tink2 , tink3 , tink4 , tink5, tink6, tink7, tink8, tink9]


        
    //Timer
        
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideTink), userInfo: nil, repeats: true)
        
        hideTink()
        
        
    }
    
    
    @objc func hideTink(){
        
        for tink in tinkArray {
            tink.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(tinkArray.count - 1 ))) // kaç tane tink varsa onun bir elsiğini almam gerekiyor ki app im çökmesin dizilerde 0. indekstyen başladığı için
        
        tinkArray[random].isHidden = false
        
        
    }
    
    
    
    
    @objc func increaseScore(){
        
        score += 1
        scoreLabel.text = "Score \(score)"
        
        
    }
    
    @objc func countDown (){
        
        counter -= 1
        
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            //süre bittikten sonra tink fotoları tamamen saklansın diye yaptık.
        
            for tink in tinkArray {
                tink.isHidden = true
            }
            
            //High Score
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "highscore")
            }
            
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                
                
                //replay function
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideTink), userInfo: nil, repeats: true)
                
                
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true,completion: nil)
        }
    }


}

