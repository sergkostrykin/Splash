//  
//  MovieListViewController.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    // MARK: - Properties
    private var output: MovieListViewOutput?
    private var movies = [Movie]()
    
    // MARK: - Outlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cells: ["MovieTableViewCell"])
        output?.didLoad()
    }
}

extension MovieListViewController {
    func attach(output: MovieListViewOutput) {
        self.output = output
    }
}

extension MovieListViewController: MovieListView {
    func showSpinner() {}
    func dismissSpinner() {}
    func showAlert(title: String?, message: String?) {}
    
    func refresh(movies: [Movie]) {
        self.movies = movies
        tableView.reloadData()
    }

}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.row]
        cell.setup(movie: movie, isSeparatorHidden: indexPath.row == movies.count - 1)
        return cell

    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        output?.showMovieDetails(movie: movie)
    }
}
