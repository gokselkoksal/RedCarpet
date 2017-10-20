//
//  MovieDetailViewController.swift
//  RedCarpetVIPER
//
//  Created by Göksel Köksal on 16.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

final class MovieDetailViewController: UITableViewController {
    
    var presenter: MovieDetailPresenterProtocol!
    
    var presentation: MovieDetailPresentation {
        return presenter.moviePresentation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie Detail"
        configureTableView()
        tableView.reloadData()
    }
}

private extension MovieDetailViewController {
    
    func configureTableView() {
        tableView.allowsSelection = false
        tableView.alwaysBounceVertical = false
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource

extension MovieDetailViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentation.infoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let cellId = "defaultCell"
        
        if let someCell = tableView.dequeueReusableCell(withIdentifier: cellId) {
            cell = someCell
        } else {
            cell = UITableViewCell(style: .value2, reuseIdentifier: cellId)
        }
        
        // Presentation can't possibly be nil at this point.
        // If it is nil, there's a programmer error.
        let row = presentation.infoList[indexPath.row]
        
        cell.textLabel?.text = row.title
        cell.detailTextLabel?.text = row.detail
        
        return cell
    }
}
