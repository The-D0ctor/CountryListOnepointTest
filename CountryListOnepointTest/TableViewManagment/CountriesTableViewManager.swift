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
    
    var filteredCountries: Array<Country>?
    
    var tableView: UITableView?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredCountries == nil {
            return listCountries.count
        }
        else {
            return filteredCountries!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountriesTableViewCell
        var country: Country?
        if filteredCountries == nil {
            country = listCountries[indexPath.row]
        }
        else {
            country = filteredCountries![indexPath.row]
        }
        cell.CountryNameLabel.text = country!.name
        cell.CountryCapitalLabel.text = country!.capital
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        if searchText == nil || searchText!.isEmpty {
            filteredCountries = nil
        }
        else {
            filteredCountries = listCountries.filter({(country: Country) in
                return (country.name.lowercased().starts(with: searchText!.lowercased()) ||
                    country.capital.lowercased().starts(with: searchText!.lowercased()))
            })
        }
        self.tableView?.reloadData()
    }
}
