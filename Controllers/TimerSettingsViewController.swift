//
//  TimerSettingsViewController.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/4/22.
//

import UIKit
import GoogleMobileAds

class TimerSettingsViewController: UIViewController {
  
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private var settingLabels = ["Study Timer Length", "Break Timer Length", "Alarm Sound" ]
    
    private var settingImages = [UIImage(named: "custom.book"), UIImage(named: "custom.moon"), UIImage(named: "custom.alarm")]
    
    private var fullScreenAd: GADInterstitialAd?
    
    private var adCounter = 2
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        
        let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                                        request: request,
                              completionHandler: { [self] ad, error in
                                if let error = error {
                                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                  return
                                }
                                fullScreenAd = ad
                                fullScreenAd?.fullScreenContentDelegate = self
                              }
            )
        
    }

}

extension TimerSettingsViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if fullScreenAd != nil && adCounter % 2 == 0 {
            fullScreenAd?.present(fromRootViewController: self)
          }
        
        adCounter += 1
        
        
        let selectedRow = indexPath.row
        print("Selected row " + String(selectedRow))
        
        if (selectedRow == 0)
        {
            self.performSegue(withIdentifier: "StudyLengthSettings", sender: self)
        }
        
        if (selectedRow == 1)
        {
            self.performSegue(withIdentifier: "BreakLengthSettings", sender: self)
        }
        
        if (selectedRow == 2)
        {
            self.performSegue(withIdentifier: "AlarmSettings", sender: self)
        }
        
        
    }
}

extension TimerSettingsViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingLabels.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! SettingCell
        
        cell.settingImage.image = settingImages[indexPath.row]
        cell.settingLabel.text = settingLabels[indexPath.row]
        
        
        return cell
        
    }
    
}

extension TimerSettingsViewController: GADFullScreenContentDelegate
{
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
      print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad will present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad did dismiss full screen content.")
        let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                                        request: request,
                              completionHandler: { [self] ad, error in
                                if let error = error {
                                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                  return
                                }
                                fullScreenAd = ad
                fullScreenAd?.fullScreenContentDelegate = self
                              }
            )
    }
}
