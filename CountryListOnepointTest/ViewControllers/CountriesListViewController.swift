//
//  ViewController.swift
//  CountryListOnepointTest
//
//  Created by Sébastien Rochelet on 09/07/2018.
//  Copyright © 2018 Sébastien Rochelet. All rights reserved.
//

import UIKit
import Alamofire

var flagDictionary: Dictionary<String, UIImage?> = Dictionary()

class CountriesListViewController: UIViewController {
    var listCountries: [Country]?
    
    @IBOutlet weak var SearchBarView: UIView!
    
    @IBOutlet weak var CountriesTableView: UITableView!
    
    @IBAction func RefreshButton(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        getCountries()
    }
    
    @IBOutlet weak var RefreshButtonOutlet: UIBarButtonItem!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableViewManager = CountriesListTableViewManager()
    
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
        getCountries()
    }

    func getCountries() {
        ApiManager.getCountriesFromApi() { (_ countries: [Country]?) in
            if countries != nil {
                let sortedCountries = countries?.sorted {(country1, country2) in
                    return (country1.name < country2.name)
                }
                self.listCountries = sortedCountries
                self.tableViewManager.listCountries = sortedCountries!
                self.CountriesTableView.reloadData()
            }
            else {
                self.alert(title: "Error", message: "We had difficulties to download the countries, please retry")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToCountry" {
            if let cell = sender as? CountriesListTableViewCell,
                let destination = segue.destination as? CountryViewController {
                let country = self.listCountries?.first {(country) in
                    return (country.name == cell.CountryNameLabel.text)
                }
                destination.navigationItem.title = cell.CountryNameLabel.text
                destination.listCountries = self.listCountries
                destination.currentCountry = country
                self.searchController.isActive = false
            }
        }
    }
    
    @IBAction func backFromCountry(unwindSegue: UIStoryboardSegue) {}
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        self.RefreshButtonOutlet.isEnabled = true
    }
}
