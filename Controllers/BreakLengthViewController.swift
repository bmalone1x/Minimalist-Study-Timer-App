//
//  BreakLengthViewController.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/14/22.
//

import UIKit

class BreakLengthViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(TimerSettings.defaults.integer(forKey: "Break Length Picker Row"), inComponent: 0, animated: false)
    }

}

extension BreakLengthViewController : UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected Row" + String(row))
        
        TimerSettings.setBreakTimerDefault(row: row)
    }
}

extension BreakLengthViewController : UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TimerSettings.timeOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TimerSettings.timeOptions[row]
    }
    
}
