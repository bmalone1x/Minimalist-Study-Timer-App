//
//  SettingCell.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/14/22.
//

import UIKit

class SettingCell: UITableViewCell {
    
    @IBOutlet weak var settingImage: UIImageView!
    
    @IBOutlet weak var settingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = SelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
