//
//  ViewController.swift
//  CountryListOnepointTest
//
//  Created by Sébastien Rochelet on 09/07/2018.
//  Copyright © 2018 Sébastien Rochelet. All rights reserved.
//

import UIKit
import Alamofire

class CountriesListViewController: UIViewController {
    var listCountries: [Country]?
    
    @IBOutlet weak var SearchBarView: UIView!
    
    @IBOutlet weak var CountriesTableView: UITableView!
    
    @IBAction func RefreshButton(_ sender: UIBarButtonItem) {
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableViewManager = CountriesTableViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.searchController.searchResultsUpdater = self.tableViewManager
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.SearchBarView.addSubview(self.searchController.searchBar)
        self.tableViewManager.tableView = self.CountriesTableView
        self.CountriesTableView.dataSource = self.tableViewManager
        self.CountriesTableView.delegate = self.tableViewManager
        ApiManager.getCountriesFromApi() { (_ countries: [Country]) in
            let sortedCountries = countries.sorted(by: {(country1, country2) in
                    return (country1.name < country2.name)
                })
            self.listCountries = sortedCountries
            self.tableViewManager.listCountries = sortedCountries
            self.CountriesTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToCountry" {
            
            if let cell = sender as? CountriesTableViewCell,
                let destination = segue.destination as? CountryViewController {
                let country = self.listCountries?.first(where: {(country) in
                    return (country.name == cell.CountryNameLabel.text)
                })
                destination.navigationItem.title = cell.CountryNameLabel.text
                destination.listCountries = self.listCountries
                destination.currentCountry = country
                destination.flagImage = cell.FlagImageView.image
                self.searchController.isActive = false
            }
        }
    }
}

