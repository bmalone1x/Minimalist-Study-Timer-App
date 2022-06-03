//
//  TimerSettings.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/4/22.
//

import Foundation
import UIKit

class TimerSettings {
    
    // TIME OPTIONS
    
    static let defaults = UserDefaults.standard
    
    static let timeOptions = ["1 minute","5 minutes","10 minutes","15 minutes", "20 minutes", "25 minutes", "30 minutes", "35 minutes", "40 minutes", "45 minutes", "1 hour", "1.5 hours", "2 hours"]
    
    static let secondEquivs:[String:Int] = ["1 minute": 60,"5 minutes": 300,"10 minutes": 600,"15 minutes": 900, "20 minutes": 1200, "25 minutes": 1500, "30 minutes": 1800, "35 minutes": 2100, "40 minutes": 2400, "45 minutes": 2700, "1 hour": 3600, "1.5 hours": 5400, "2 hours": 7200]
    
    
    static let alarmOptions = ["Bing", "Digital", "Intense Digital"]
    
    

    static private func getTimerLength(forRow row: Int) -> Int
    {
        let length = secondEquivs[TimerSettings.timeOptions[row]]!
        return length
    }
    
    
    // CHANGE USER SETTINGS
    
    static func setStudyTimerDefault(row: Int)
    {
        let length = getTimerLength(forRow: row)
        defaults.set(length, forKey: "Study Timer Length")
        defaults.set(row, forKey: "Study Length Picker Row")
    }
    
    
    static func setBreakTimerDefault(row : Int)
    {
        let length = getTimerLength(forRow: row)
        defaults.set(length, forKey: "Break Timer Length")
        defaults.set(row, forKey: "Break Length Picker Row")
    }
    
    static func setAlarmSoundDefault(row : Int)
    {
        let sound = alarmOptions[row]
        defaults.set(sound, forKey: "Alarm Sound")
        defaults.set(row, forKey: "Alarm Sound Picker Row")
    }
    
    //  --------------------
    
    
    // RETURN USER DEFAULT TO TIMER
    static func getTimerLength(isABreak : Bool) -> Int
    {
        if(isABreak)
        {
            return defaults.integer(forKey: "Break Timer Length")
        }
        else
        {
            return defaults.integer(forKey: "Study Timer Length")
        }
    }
    
    static func getChosenAlarm() -> String
    {
        return defaults.string(forKey: "Alarm Sound")!
    }
    
}
