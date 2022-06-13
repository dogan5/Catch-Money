//
//  ViewController.swift
//  Dolar yakala
//
//  Created by Doğan seçilmiş on 7.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var array = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var dolar1: UIImageView!
    @IBOutlet weak var dolar2: UIImageView!
    @IBOutlet weak var dolar3: UIImageView!
    @IBOutlet weak var dolar4: UIImageView!
    @IBOutlet weak var dolar5: UIImageView!
    @IBOutlet weak var dolar6: UIImageView!
    @IBOutlet weak var dolar7: UIImageView!
    @IBOutlet weak var dolar8: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text =   "Score : \(score)"
        
        let gelenYuksekSayi = UserDefaults.standard.object(forKey: "highscore")
        if gelenYuksekSayi == nil {
            highScore = 0
            highscoreLabel.text = "Highscore : \(highScore)"
            
        }
        if let yeniSkor = gelenYuksekSayi as? Int{
            highScore = yeniSkor
            highscoreLabel.text = "Highscore : \(highScore)"
        }
        
        
        dolar1.isUserInteractionEnabled = true
        dolar2.isUserInteractionEnabled = true
        dolar3.isUserInteractionEnabled = true
        dolar4.isUserInteractionEnabled = true
        dolar5.isUserInteractionEnabled = true
        dolar6.isUserInteractionEnabled = true
        dolar7.isUserInteractionEnabled = true
        dolar8.isUserInteractionEnabled = true
        
        let d1 = UITapGestureRecognizer.init(target: self, action: #selector(skorArttır))
        let d2 = UITapGestureRecognizer.init(target: self, action: #selector(skorArttır))
        let d3 = UITapGestureRecognizer.init(target: self, action: #selector(skorArttır))
        let d4 = UITapGestureRecognizer.init(target: self, action: #selector(skorArttır))
        let d5 = UITapGestureRecognizer.init(target: self, action: #selector(skorArttır))
        let d6 = UITapGestureRecognizer.init(target: self, action: #selector(skorArttır))
        let d7 = UITapGestureRecognizer.init(target: self, action: #selector(skorArttır))
        let d8 = UITapGestureRecognizer.init(target: self, action: #selector(skorArttır))
        
        dolar1.addGestureRecognizer(d1)
        dolar2.addGestureRecognizer(d2)
        dolar3.addGestureRecognizer(d3)
        dolar4.addGestureRecognizer(d4)
        dolar5.addGestureRecognizer(d5)
        dolar6.addGestureRecognizer(d6)
        dolar7.addGestureRecognizer(d7)
        dolar8.addGestureRecognizer(d8)
        
        array = [dolar1,dolar2,dolar3,dolar4,dolar5,dolar6,dolar7,dolar8]
        
        counter = 10
        timerLabel.text = "Time : \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(geriSayma), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(dolarSakla), userInfo: nil, repeats: true)
        
        dolarSakla()
        
    }
    @objc func dolarSakla(){
        for dolar in array {
            dolar.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(array.count - 1)))
        array[random].isHidden = false
        
    }

    @objc func skorArttır(){
        
        score += 1
        scoreLabel.text = "Score : \(score)"
        
    }
    @objc func geriSayma(){
        counter -= 1
        timerLabel.text = "Time : \(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for dolar in array {
                dolar.isHidden = true
            }
            
            if self.score > self.highScore {
                self.highScore = self.score
                self.highscoreLabel.text = "HighScore : \(highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            let alert = UIAlertController(title: "Time's up", message: "Do you want to play again ?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction.init(title: "Okey", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction.init(title: "Play Again", style: .default) { UIAlertAction in
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timerLabel.text = String(self.counter)
              
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.geriSayma), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.dolarSakla), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }

    
}

    
