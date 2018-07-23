//
//  CountriesTableViewManager.swift
//  CountryListOnepointTest
//
//  Created by Sébastien Rochelet on 12/07/2018.
//  Copyright © 2018 Sébastien Rochelet. All rights reserved.
//

import UIKit
import SVGKit

class CountriesListTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    var listCountries: [Country] = []
    
    var filteredCountries: [Country]?
    
    var tableView: UITableView?
    
    //static var flagDictionary: Dictionary<String, UIImage?> = Dictionary()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries == nil ? listCountries.count : filteredCountries!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountriesListTableViewCell
        cell.FlagImageView.image = nil
        let country: Country = filteredCountries == nil ? listCountries[indexPath.row] : filteredCountries![indexPath.row]
        cell.CountryNameLabel.text = country.name
        cell.CountryCapitalLabel.text = country.capital
        if let image = flagDictionary[country.name] {
            cell.FlagImageView.image = image
        }
        else if country.alpha3Code != "SHN" {
            ApiManager.getFlag(flagUrl: country.flag) {(flagData) in
                let flagImage = SVGKImage(data: flagData)
                cell.FlagImageView.image = flagImage?.uiImage
                flagDictionary[country.name] = flagImage?.uiImage
            }
        }
        else {
            cell.FlagImageView.image = nil
            flagDictionary[country.name] = nil
        }
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
            filteredCountries = listCountries.filter {(country: Country) in
                let nameWords = country.name.split { (character) in
                    let testBool = character == " " || character == ","
                    let testBool2 = character == "(" || character == ")"
                    let testBool3 = character == "'" || character == "-" || character == "."
                    return testBool || testBool2 || testBool3
                }
                for word in nameWords {
                    if word.lowercased().starts(with: searchText!.lowercased()) {
                        return true
                    }
                }
                
                let capitalWords = country.capital.split { (character) in
                    let testBool = character == " " || character == ","
                    let testBool2 = character == "(" || character == ")"
                    let testBool3 = character == "'" || character == "-" || character == "."
                    return testBool || testBool2 || testBool3
                }
                for word in capitalWords {
                    if word.lowercased().starts(with: searchText!.lowercased()) {
                        return true
                    }
                }
                return false
            }
        }
        self.tableView?.reloadData()
    }
}
