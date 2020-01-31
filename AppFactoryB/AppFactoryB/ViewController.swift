//
//  ViewController.swift
//  AppFactoryB
//
//  Created by  on 17/01/2020.
//  Copyright © 2020 klery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inicio: UIBarButtonItem!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    var timer: Timer?
    var time: Double = 0
    
    var seconds :Int = 0
    var miliSeconds :Int = 0
    
    var startTime: Double = 0
    
    var ms: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func start(_ sender: Any) {
        
        /*let interval :Double = 0.02
        
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)*/
        
        startTime = Date().timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                     target: self,
                                     selector: #selector(fireTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func fireTimer() {

        /*ms += Int(timer!.timeInterval * 10)
        
        miliSeconds += Int(timer!.timeInterval * 10)
        
        /*if(ms >= 10) {
            
            seconds += 1
        }*/
        
        timeLabel.text = "\(miliSeconds)"*/
        
        //Total time since timer started, in seconds
        time = Date().timeIntervalSinceReferenceDate - startTime

        //Convert the time to a string with 2 decimal places
        
        //miliSeconds = String(format: "%.2f", time)
        
        miliSeconds += Int(time * 100)
        
        if (miliSeconds >= 100) {
            
            miliSeconds = 0
            seconds += 1
        }
        
        timeLabel.text = "\(seconds):\(miliSeconds)"
        
    }
    
}

