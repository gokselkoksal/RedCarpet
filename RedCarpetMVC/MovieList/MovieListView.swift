//
//  MovieListView.swift
//  RedCarpetMVC
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

class MovieListView: UIView {
    
    private enum Const {
        static let cellId = "MovieCell"
    }
    
    static func instantiate() -> MovieListView {
        let nibName = String(describing: self)
        guard let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? MovieListView else {
            fatalError("There is no nib named \(nibName)")
        }
        return view
    }

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
        backgroundColor = .white
    }
}

extension MovieListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if let someCell = tableView.dequeueReusableCell(withIdentifier: Const.cellId) {
            cell = someCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: Const.cellId)
        }
        
        let movie = movies[indexPath.row]
        let year = movie.releaseDate.extract(.year)
        
        cell.textLabel?.text = movie.name
        cell.detailTextLabel?.text = "\(year) | \(movie.artistName)"
        
        return cell
    }
}
