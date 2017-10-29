//
//  MovieDetailViewController.swift
//  RedCarpetRedux
//
//  Created by Göksel Köksal on 29.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.willAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Beware that this method can also be called when something is pushed
        // onto it. Assuming nothing will be pushed onto it for now to keep
        // things simple.
        presenter.didDisappear()
        presenter.didClose()
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
