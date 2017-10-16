//
//  MovieListView.swift
//  RedCarpetMVC
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

protocol MovieListViewDelegate: class {
    func movieListView(_ view: MovieListView, didSelectMovie movie: Movie)
}

final class MovieListView: UIView {
    
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
    weak var delegate: MovieListViewDelegate?
    
    var movies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.delegate = self
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
        let presentation = MovieListPresentation(movie: movie)
        
        cell.textLabel?.text = presentation.title
        cell.detailTextLabel?.text = presentation.detail
        
        return cell
    }
}

extension MovieListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let movie = movies[indexPath.row]
        delegate?.movieListView(self, didSelectMovie: movie)
    }
}
