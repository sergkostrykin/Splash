//  
//  MovieDetailsPresenter.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation
import URNNetworking

protocol MovieDetailsViewOutput: class {
    func didLoad()
    func back()
}

final class MovieDetailsPresenter {
    private var router: MovieDetailsRouter?
    private weak var view: MovieDetailsView?
    
    var movie: Movie?
    
    
    init(movie: Movie?) {
        self.movie = movie
    }
    

    func loadMovieDetails() {
        guard let id = movie?.id else { return }
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
                    self?.view?.refresh(movie: movie)
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

extension MovieDetailsPresenter: MovieDetailsViewOutput {
    func didLoad() {
        print(#function)
        loadMovieDetails()
    }
    
    func back() {
        router?.routeBack()
    }
}

extension MovieDetailsPresenter {
    func attach(router: MovieDetailsRouter) {
        self.router = router
    }
    
    func attach(view: MovieDetailsView) {
        self.view = view
    }
}
