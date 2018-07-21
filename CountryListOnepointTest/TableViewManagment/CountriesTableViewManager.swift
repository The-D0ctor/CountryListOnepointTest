//
//  CountriesTableViewManager.swift
//  CountryListOnepointTest
//
//  Created by Sébastien Rochelet on 12/07/2018.
//  Copyright © 2018 Sébastien Rochelet. All rights reserved.
//

import UIKit
import SVGKit

class CountriesTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    var listCountries: Array<Country> = Array()
    
    var filteredCountries: Array<Country>?
    
    var tableView: UITableView?
    
    static var flagDictionary: Dictionary<String, UIImage?> = Dictionary()
    
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
        print(country!.name)
        if !CountriesTableViewManager.flagDictionary.contains(where: {(key, _) in
            return (key == country!.name)}) {
            if country!.name != "Saint Helena, Ascension and Tristan da Cunha" {
                let flagImage = SVGKImage(contentsOf: URL(string: country!.flag))
                CountriesTableViewManager.flagDictionary[country!.name] = flagImage?.uiImage
            }
            else {
                CountriesTableViewManager.flagDictionary[country!.name] = UIImage()
            }
        }
        cell.FlagImageView.image = CountriesTableViewManager.flagDictionary[country!.name]!
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
