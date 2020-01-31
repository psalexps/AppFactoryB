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
    
    var seconds :Int = 0
    var miliSeconds :Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func start(_ sender: Any) {
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {

        miliSeconds += Int(timer!.timeInterval * 10)
        
        if(miliSeconds >= 10) {
            seconds += 1
            miliSeconds = 0
        }
        
        timeLabel.text = "\(seconds):\(miliSeconds)"
    }
    
}

