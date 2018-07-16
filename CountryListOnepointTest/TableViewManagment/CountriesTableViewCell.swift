//
//  CountriesTableViewCell.swift
//  CountryListOnepointTest
//
//  Created by Sébastien Rochelet on 12/07/2018.
//  Copyright © 2018 Sébastien Rochelet. All rights reserved.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {
    @IBOutlet weak var FlagImageView: UIImageView!
    
    @IBOutlet weak var CountryNameLabel: UILabel!
    
    @IBOutlet weak var CountryCapitalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
