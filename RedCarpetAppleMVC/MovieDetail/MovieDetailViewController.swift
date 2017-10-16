//
//  MovieDetailViewController.swift
//  RedCarpetAppleMVC
//
//  Created by Göksel Köksal on 9.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

class MovieDetailViewController: UITableViewController {
    
    private enum Const {
        static let cellId = "DetailCell"
    }
    
    var movie: Movie!
    var presentation: MovieDetailPresentation? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie Detail"
        configureTableView()
        presentation = MovieDetailPresentation(movie: movie)
    }
}

private extension MovieDetailViewController {
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.alwaysBounceVertical = false
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource

extension MovieDetailViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentation?.infoList.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if let someCell = tableView.dequeueReusableCell(withIdentifier: Const.cellId) {
            cell = someCell
        } else {
            cell = UITableViewCell(style: .value2, reuseIdentifier: Const.cellId)
        }
        
        // Presentation can't possibly be nil at this point.
        // If it is nil, there's a programmer error.
        let row = presentation!.infoList[indexPath.row]
        
        cell.textLabel?.text = row.title
        cell.detailTextLabel?.text = row.detail
        
        return cell
    }
}
