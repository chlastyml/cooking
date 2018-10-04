//
//  TimerViewController.swift
//  Cooking
//
//  Created by kacalek on 20/09/2018.
//  Copyright © 2018 kacalek. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBAction func BackBtnClick(_ sender: Any) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "main_navigation") as! UINavigationController
            self.present(nextVC, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    let defaultTime = 72
    
    var counter = 0
    var timer = Timer()
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.counter = defaultTime
        timeLabel.text = convertTime(inputSeconds: counter)
        pauseButton.isEnabled = false
    }
    
    @objc func UpdateTimer() {
        if isPlaying {
            counter = counter - 1
            if counter <= 0 {
                print("Konec")
                
                isPlaying = false
                timer.invalidate()
                timeLabel.text = convertTime(inputSeconds: 0)
                
                let defaultColor = self.view?.backgroundColor
                
                DispatchQueue(label: "com.myApp.queue").async {
                    let delay = UInt32(0.3 * 1000 * 1000)
                    DispatchQueue.main.async {
                        self.view?.backgroundColor = UIColor.red
                    }
                    usleep(delay)
                    DispatchQueue.main.async {
                        self.view?.backgroundColor = UIColor.blue
                    }
                    usleep(delay)
                    DispatchQueue.main.async {
                        self.view?.backgroundColor = UIColor.black
                    }
                    usleep(delay)
                    DispatchQueue.main.async {
                        self.view?.backgroundColor = defaultColor
                    }
                }
            } else {
                timeLabel.text = convertTime(inputSeconds: counter)
            }
        }
    }
    
    @IBAction func startTimer(_ sender: AnyObject) {
        if(isPlaying) {
            return
        }
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @IBAction func pauseTimer(_ sender: AnyObject) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
    }
    
    @IBAction func resetTimer(_ sender: AnyObject) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
        counter = defaultTime
        timeLabel.text = convertTime(inputSeconds: counter)
    }
    
    @IBAction func plusTime(_ sender: AnyObject) {
        counter += 5
        timeLabel.text = convertTime(inputSeconds: counter)
    }
    
    @IBAction func minusTime(_ sender: AnyObject) {
        counter -= 5
        timeLabel.text = convertTime(inputSeconds: counter)
    }
    
    func convertTime(inputSeconds: Int) -> String {
        let seconds = inputSeconds % 60
        let minutes = Int(floor(Double(inputSeconds) / 60.0))
        
        let secondString = seconds < 10 ? String(format: "0%d", seconds) : String(seconds)
        let minutesString = minutes < 10 ? String(format: "0%d", minutes) : String(minutes)
        
        return "\(minutesString):\(secondString)"
    }
}
