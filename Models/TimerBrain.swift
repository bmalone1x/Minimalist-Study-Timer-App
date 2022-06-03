//
//  Timer.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/1/22.
//

import Foundation
import AVFoundation

protocol TimerBrainDelegate {
    
    func timerTimeChanged(timeString: String)
    func timerEnded()
}

class TimerBrain {
    
    
    private var timeTilAlarm = 0
    private var secondsPassed = 0
    
    private var timer: Timer?
    private var timerActive = false   // i.e. running or stopped
    private var timerReachedZero = false
    private var isABreak = false;
    private var viewController: TimerBrainDelegate?
    
    private var player: AVAudioPlayer?
    
    
    init(viewControllerDelegate: TimerBrainDelegate) {
        
        timeTilAlarm = getTimerDuration()
        timer = Timer()
        viewController = viewControllerDelegate
        player = AVAudioPlayer()
    }
    
    init()
    {
        timeTilAlarm = getTimerDuration()
        timer = Timer()
        player = AVAudioPlayer()
    }
    
    func setDelegate(delegate : TimerBrainDelegate)
    {
        viewController = delegate
    }
    
    func startTimer()
    {
    
        
        timerActive = true
        timer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
        
    @objc func updateTimer(){
                  
                  
        if secondsPassed < timeTilAlarm && timerActive && !timerReachedZero
        {
                    
            secondsPassed += 1
        
        
            viewController?.timerTimeChanged(timeString: getTimeString())
            
            if(getTimeLeft() == 0)
            {
                timerReachedZero = true
            }
            
        }
        else
        {
            if(timerReachedZero)
            {
                soundAlarm()
                timer!.invalidate()
                viewController?.timerEnded()
                secondsPassed = 0  // reset
                timerReachedZero = false // reset
                isABreak = !isABreak
                timeTilAlarm = getTimerDuration()
            }
            else
            {
                timer?.invalidate()
            }
           
        }
    }
    
    func getTimeString() -> String
    {
        let time = getTimeLeft()
        
        let minutes = (time % 3600) / 60
        let seconds = (time % 3600) % 60
        
        var timeString = String(minutes) + ":"
        
        
        if (seconds <= 9)
        {
            timeString += "0" + String(seconds)
        }
        else
        {
            timeString += String(seconds)
        }
        
        return timeString
    }
    
    func stopTimer()
    {
        timerActive = false
        timer?.invalidate()
        timer = nil
        viewController?.timerEnded()
        
    }
    
    func soundAlarm()
    {
        print(TimerSettings.getChosenAlarm())
        let url = Bundle.main.url(forResource: TimerSettings.getChosenAlarm(), withExtension: "wav")
        player =  try! AVAudioPlayer(contentsOf: url!)
        player?.play()
        print("Alarm Sounded")
        
    }
    
    func getTimerStatus() -> Bool
    {
        return timerActive
    }
    
    func setTimerStatus(_ bool:Bool)
    {
        timerActive = bool
    }
    
    func getTimeLeft() -> Int
    {
        return getTimerDuration() - secondsPassed
    }
    
    func getIsABreak() -> Bool
    {
        return isABreak
    }
    
    func changeSession()
    {
        isABreak = !isABreak
    }
    
    func resetTimeElapsed()
    {
        secondsPassed = 0
    }
    
     private func getTimerDuration() -> Int
    {
        return TimerSettings.getTimerLength(isABreak: isABreak)
    }
    
    
}
 
    

