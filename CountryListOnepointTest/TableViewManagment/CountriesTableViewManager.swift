//
//  CountriesTableViewManager.swift
//  CountryListOnepointTest
//
//  Created by Sébastien Rochelet on 12/07/2018.
//  Copyright © 2018 Sébastien Rochelet. All rights reserved.
//

import UIKit

class CountriesTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    var listCountries: Array<Country> = Array()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountriesTableViewCell
        cell.CountryNameLabel.text = listCountries[indexPath.row].name
        cell.CountryCapitalLabel.text = listCountries[indexPath.row].capital
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    }
}
