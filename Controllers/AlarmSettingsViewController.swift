//
//  AlarmSettingsViewController.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/14/22.
//

import UIKit


class AlarmSettingsViewController: UIViewController {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(TimerSettings.defaults.integer(forKey: "Alarm Sound Picker Row"), inComponent: 0, animated: false)
    }

}

extension AlarmSettingsViewController : UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected Row" + String(row))
        
        TimerSettings.setAlarmSoundDefault(row: row)
    }
}

extension AlarmSettingsViewController : UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TimerSettings.alarmOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TimerSettings.alarmOptions[row]
    }
    
}

