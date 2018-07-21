//
//  ApiManager.swift
//  CountryListOnepointTest
//
//  Created by Sébastien Rochelet on 10/07/2018.
//  Copyright © 2018 Sébastien Rochelet. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager {
    static func getCountriesFromApi(completionHandler:@escaping (_ countries: Array<Country>) -> Void) {
        Alamofire.request("https://restcountries.eu/rest/v2/all").responseDecodable{ (response: DataResponse<Array<Country>>) in
            switch response.result {
            case .success(let countries):
                print(countries)
                completionHandler(countries)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getFlag(flagUrl: String, completionHandler:@escaping (_ flagData: Data) -> Void) {
        Alamofire.request(flagUrl).responseData { (response) in
            switch response.result {
            case .success(let flagData):
                completionHandler(flagData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
