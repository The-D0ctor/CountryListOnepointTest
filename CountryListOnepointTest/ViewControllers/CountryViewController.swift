//
//  CountryViewController.swift
//  CountryListOnepointTest
//
//  Created by Sébastien Rochelet on 21/07/2018.
//  Copyright © 2018 Sébastien Rochelet. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    var listCountries: [Country]?
    
    var currentCountry: Country?
    
    var currencies: [String?]?
    
    var borders: [Country]?
    
    var flagImage: UIImage?
    
    @IBOutlet weak var FlagImageView: UIImageView!
    
    @IBOutlet weak var CapitalLabel: UILabel!
    
    @IBOutlet weak var InhabitantsLabel: UILabel!
    
    @IBOutlet weak var CurrenciesTableView: UITableView!
    
    @IBOutlet weak var BordersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.currencies = self.currentCountry?.currencies.compactMap({ (country) in
            return country.name
        })
        print(currencies!)
        self.borders = self.currentCountry?.borders.compactMap({ (borderCode) in
            return listCountries?.first(where: {(country) in
                return (country.alpha3Code == borderCode)
            })})
        print(borders!)
        self.FlagImageView.image = flagImage
        self.CapitalLabel.text = "Capital: \(currentCountry?.capital ?? "")"
        self.InhabitantsLabel.text = "Population: \(currentCountry?.population ?? 0) inhabitants"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
