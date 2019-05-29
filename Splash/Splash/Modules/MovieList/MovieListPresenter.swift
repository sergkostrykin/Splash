//  
//  MovieListPresenter.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation
import URNNetworking

protocol MovieListViewOutput: class {
    func didLoad()
    func showMovieDetails(movie: Movie)
}

final class MovieListPresenter {
    
    private var router: MovieListRouter?
    
    private weak var view: MovieListView?
    
    
    func loadMovies() {
        view?.showSpinner()
        URNNetworking.fetchPhotos { [weak self] (json, error) in
            DispatchQueue.main.async {
                self?.view?.dismissSpinner()
                if let error = error {
                    self?.view?.showAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: json ?? [:], options: .prettyPrinted)
                    let movie = try JSONDecoder().decode(Movie?.self, from: jsonData)
//                    self?.view?.refresh(movie: movie)
                } catch {
                    DispatchQueue.main.async {
                        self?.view?.showAlert(title: "Error", message: error.localizedDescription)
                    }
                    print(error)
                }
            }
        }
    }
}

extension MovieListPresenter: MovieListViewOutput {
    func didLoad() {
        loadMovies()
    }
    
    func showMovieDetails(movie: Movie) {
        router?.showMovieDetails(movie: movie)
    }
}

extension MovieListPresenter {
    func attach(router: MovieListRouter) {
        self.router = router
    }
    
    func attach(view: MovieListView) {
        self.view = view
    }
}
