//
//  CountryViewController.swift
//  CountryListOnepointTest
//
//  Created by Sébastien Rochelet on 21/07/2018.
//  Copyright © 2018 Sébastien Rochelet. All rights reserved.
//

import UIKit
import SVGKit

class CountryViewController: UIViewController {
    var listCountries: [Country]?
    
    var currentCountry: Country?
    
    var currencies: [String]?
    
    var bordersCountries: [Country]?
    
    @IBOutlet weak var FlagImageView: UIImageView!
    
    @IBOutlet weak var CapitalLabel: UILabel!
    
    @IBOutlet weak var InhabitantsLabel: UILabel!
    
    @IBOutlet weak var CurrenciesTableView: UITableView!
    
    @IBOutlet weak var BordersTableView: UITableView!
    
    private let currenciesTableViewManager = ListTableViewManager()
    private let bordersTableViewManager = ListTableViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let image = flagDictionary[currentCountry!.name] {
            self.FlagImageView.image = image
        }
        else if currentCountry!.alpha3Code != "SHN" {
            ApiManager.getFlag(flagUrl: currentCountry!.flag) {(flagData) in
                let flagImage = SVGKImage(data: flagData)
                self.FlagImageView.image = flagImage?.uiImage
                flagDictionary[self.currentCountry!.name] = flagImage?.uiImage
            }
        }
        else {
            FlagImageView.image = nil
            flagDictionary[currentCountry!.name] = nil
        }
        self.currencies = self.currentCountry?.currencies.compactMap { (currency) in
            if currency.name != nil {
                if currency.symbol != nil {
                    return "\(currency.name!) (\(currency.symbol!))"
                }
                return currency.name!
            }
            return nil
        }
        self.bordersCountries = self.currentCountry?.borders.compactMap { (borderCode) in
            return listCountries?.first {(country) in
                return (country.alpha3Code == borderCode)
            }}
        self.CapitalLabel.text = "Capital: \(currentCountry!.capital)"
        self.InhabitantsLabel.text = "Population: \(currentCountry!.population) inhabitants"
        self.currenciesTableViewManager.contentList = self.currencies
        self.CurrenciesTableView.dataSource = self.currenciesTableViewManager
        self.CurrenciesTableView.delegate = self.currenciesTableViewManager
        self.bordersTableViewManager.contentList = self.bordersCountries?.compactMap {(country) in
            return country.name
        }
        self.BordersTableView.dataSource = self.bordersTableViewManager
        self.BordersTableView.delegate = self.bordersTableViewManager
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToCountry" {
            if let cell = sender as? ListTableViewCell,
                let destination = segue.destination as? CountryViewController {
                let country = self.bordersCountries?.first {(country) in
                    return (country.name == cell.ContentListLabel.text)
                }
                destination.navigationItem.title = cell.ContentListLabel.text
                destination.listCountries = self.listCountries
                destination.currentCountry = country
            }
        }
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
