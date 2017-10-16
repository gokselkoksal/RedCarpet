//
//  MovieDetailView.swift
//  RedCarpetMVC
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

final class MovieDetailView: UIView {
    
    private enum Const {
        static let cellId = "MovieDetailCell"
    }
    
    
    static func instantiate() -> MovieDetailView {
        let nibName = String(describing: self)
        guard let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? MovieDetailView else {
            fatalError("There is no nib named \(nibName)")
        }
        return view
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var movie: Movie? = nil {
        didSet {
            if let movie = movie {
                presentation = MovieDetailPresentation(movie: movie)
            } else {
                presentation = nil
            }
        }
    }
    
    private var presentation: MovieDetailPresentation? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.alwaysBounceVertical = false
        tableView.tableFooterView = UIView()
    }
}

extension MovieDetailView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentation?.infoList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
