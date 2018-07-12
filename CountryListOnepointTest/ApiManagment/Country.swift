//
//  Country.swift
//  CountryListOnepointTest
//
//  Created by Sébastien Rochelet on 10/07/2018.
//  Copyright © 2018 Sébastien Rochelet. All rights reserved.
//

import UIKit

class Country: Decodable, CustomStringConvertible {
    var name: String = ""
    var capital: String = ""
    var flag: String = ""
    var population: Int = 0
    var borders: [String] = []
    var currencies: [Currency] = []
    
    enum CodingKeys: String, CodingKey {
        case name
        case capital
        case flag
        case population
        case borders
        case currencies
    }
    
    var description: String {
        return "Country: { name: \(name), capital: \(capital), flag: \(flag), population: \(population), borders: \(borders), currencies: \(currencies) }"
    }
    
    class Currency: Decodable, CustomStringConvertible {
        var name: String? = ""
        
        enum CodingKeys: String, CodingKey {
            case name
        }
        
        var description: String {
            return String(describing: name)
        }
    }
}
