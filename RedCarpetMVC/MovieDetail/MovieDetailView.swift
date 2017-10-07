//
//  MovieDetailView.swift
//  RedCarpetMVC
//
//  Created by Göksel Köksal on 7.10.2017.
//  Copyright © 2017 Packt. All rights reserved.
//

import UIKit
import Commons

class MovieDetailView: UIView {
    
    static func instantiate() -> MovieDetailView {
        let nibName = String(describing: self)
        guard let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? MovieDetailView else {
            fatalError("There is no nib named \(nibName)")
        }
        return view
    }
    
    private enum Const {
        static let cellId = "MovieDetailCell"
    }
    
    private struct Row {
        let title: String
        let value: String
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var movie: Movie? = nil {
        didSet {
            if let movie = movie {
                let nameRow = Row(title: "Name", value: movie.name)
                let artistNameRow = Row(title: "Starring", value: movie.artistName)
                
                let year = "\(movie.releaseDate.extract(.year))"
                let releaseDateRow = Row(title: "Year", value: year)
                
                var rows = [nameRow, artistNameRow, releaseDateRow]
                
                if let copyright = movie.copyright {
                    rows.append(Row(title: "Copyright", value: copyright))
                }
                
                self.rows = rows
            } else {
                self.rows = []
            }
        }
    }
    
    private var rows: [Row] = [] {
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
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if let someCell = tableView.dequeueReusableCell(withIdentifier: Const.cellId) {
            cell = someCell
        } else {
            cell = UITableViewCell(style: .value2, reuseIdentifier: Const.cellId)
        }
        
        let row = rows[indexPath.row]
        
        cell.textLabel?.text = row.title
        cell.detailTextLabel?.text = row.value
        
        return cell
    }
}
