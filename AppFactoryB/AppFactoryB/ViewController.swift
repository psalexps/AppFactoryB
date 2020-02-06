//
//  ViewController.swift
//  AppFactoryB
//
//  Created by  on 17/01/2020.
//  Copyright © 2020 klery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var andarButton: UIButton!
    @IBOutlet weak var correrButton: UIButton!
    @IBOutlet weak var bicicletaButton: UIButton!
    
    var timer : Timer?
    
    var sec :Int = 0
    var min :Int = 0
    var hor :Int = 0
    
    var pause :Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        andarButton.isSelected = true
        
        pauseButton.isEnabled = false
        finishButton.isEnabled = false
        
        pauseButton.setImage(UIImage(systemName: "pause.circle"), for: UIControl.State.normal)

    }
    
    func cronometro(){
        
        timer = Timer.scheduledTimer(timeInterval: 1,
        target: self,
        selector: #selector(fireTimer),
        userInfo: nil,
        repeats: true)
    }

    @IBAction func start(_ sender: Any) {

        cronometro()
        
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        finishButton.isEnabled = true
    }
    
    @objc func fireTimer() {
        
        if (min >= 59){
            
            min = 0
            hor += 1
            
        }
        
        if (sec >= 59){
            
            sec = 0
            min += 1
        }
        else {
            
            sec += 1
        }
        
        if (sec <= 9) {
            
            timeLabel.text = "0\(hor):0\(min):0\(sec)"
            
            if (min <= 9) {
                
                timeLabel.text = "0\(hor):0\(min):0\(sec)"
            }
            else{
                
                timeLabel.text = "0\(hor):\(min):0\(sec)"
            }
        }
        else {
            
            timeLabel.text = "0\(hor):0\(min):\(sec)"
            
            if (min <= 9) {
                
                timeLabel.text = "0\(hor):0\(min):\(sec)"
            }
            else{
                
                timeLabel.text = "0\(hor):\(min):\(sec)"
            }
        }
        
    }
    
    @IBAction func pause(_ sender: Any) {
        
        if (pause == 0) {

            pauseButton.setImage(UIImage(systemName: "play.circle"), for: UIControl.State.normal)
            timer?.invalidate()
            pause = 1
        }
        else {
            
            pauseButton.setImage(UIImage(systemName: "pause.circle"), for: UIControl.State.normal)
            cronometro()
            pause = 0
        }
    }
    
    @IBAction func finish(_ sender: Any) {
        
        sec = 0
        min = 0
        hor = 0
        timeLabel.text = "00:00:00"
        timer?.invalidate()
        finishButton.isEnabled = false
        startButton.isEnabled = true
        pauseButton.isEnabled = false
    }
}

