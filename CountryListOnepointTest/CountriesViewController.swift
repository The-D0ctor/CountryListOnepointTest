//
//  ViewController.swift
//  CountryListOnepointTest
//
//  Created by Sébastien Rochelet on 09/07/2018.
//  Copyright © 2018 Sébastien Rochelet. All rights reserved.
//

import UIKit
import Alamofire

class CountriesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ApiManager.getCountriesFromApi() { (_ countries: Array<Country>) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

