//
//  ListTableViewManager.swift
//  CountryListOnepointTest
//
//  Created by Sébastien Rochelet on 22/07/2018.
//  Copyright © 2018 Sébastien Rochelet. All rights reserved.
//

import UIKit

class ListTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    var contentList: [String]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList == nil ? 0 : contentList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! ListTableViewCell
        cell.ContentListLabel.text = contentList?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
