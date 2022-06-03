//
//  ViewController.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/1/22.
//

import UIKit
import GoogleMobileAds

class TimerViewController: UIViewController {
    
    private var timerBrain = TimerBrain()
    
    @IBOutlet weak var timerControlImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var statusLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = timerBrain.getTimeString()
        if(TimerSettings.defaults.integer(forKey: "Study Timer Length") == 0)
        {
            TimerSettings.setStudyTimerDefault(row: 0)
            TimerSettings.setBreakTimerDefault(row: 0)
        }
        
        if(TimerSettings.defaults.string(forKey: "Alarm Sound") == nil)
        {
            TimerSettings.setAlarmSoundDefault(row: 0)
        }
    
        timerBrain.setDelegate(delegate: self)
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        timeLabel.text = timerBrain.getTimeString()
    }

    @IBAction func timerControlButtonPress(_ sender: UIButton) {
        
        if(timerControlImage.image == UIImage(systemName: "play"))
        {
            timerControlImage.image = UIImage(systemName: "pause")
            startTimer()
            
           
            updateSessionLabel()
            
           
        }
        else
        {
            timerControlImage.image = UIImage(systemName: "play")
            stopTimer()
        }
        
    }
    
    private func startTimer()
    {
        timerBrain.setTimerStatus(true)
        print("Timer Started")
        self.timeLabel.text = timerBrain.getTimeString()
        timerBrain.startTimer()
    }
    
    private func stopTimer()
    {
        print("Timer Stopped")
        timerBrain.setTimerStatus(false)
    }
    
    @IBAction func skipCurrentSessionButtonPress(_ sender: UIButton) {
        
        timerBrain.stopTimer()
        timerEnded()
        timerBrain.changeSession()
        timerBrain.resetTimeElapsed()
        updateSessionLabel()
    }
    
    func updateSessionLabel()
    {
        if(timerBrain.getIsABreak())
        {
            statusLabel.text = "Break"
        }
        else
        {
            statusLabel.text = "Study"
        }
        
        timeLabel.text = timerBrain.getTimeString()
    }
}

extension TimerViewController: TimerBrainDelegate {
    
    
    func timerTimeChanged(timeString: String) {
        
            DispatchQueue.main.async {
                self.timeLabel.text = String(timeString)
            }
       
        
    }
    
    
    func timerEnded() {
        print("Timer Ended")
        timerControlImage.image = UIImage(systemName: "play")
        timeLabel.text = "0:00"
        
    }
    
    
}

