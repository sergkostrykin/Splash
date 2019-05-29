//  
//  MovieDetailsScreen.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

protocol MovieDetailsRouter {
    func routeBack()
}

final class MovieDetailsScreen {
    private weak var viewController: MovieDetailsViewController?
    private weak var presenter: MovieDetailsPresenter?
    private var movie: Movie?
    
    init(movie: Movie?) {
        self.movie = movie
    }

    private func instantiateViewController() -> MovieDetailsViewController {
        guard let viewController = UIStoryboard(name: "MovieDetails", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else { fatalError("Failed to load MovieDetailsViewСontroller") }
    
        let presenter = MovieDetailsPresenter(movie: movie)
        presenter.attach(router: self)
        presenter.attach(view: viewController)
        viewController.attach(output: presenter)
    
        self.presenter = presenter
        self.viewController = viewController
    
        return viewController
    }
    
    func push(to: UINavigationController?, animated: Bool = true) {
        to?.pushViewController(instantiateViewController(), animated: animated)
    }
}

extension MovieDetailsScreen: MovieDetailsRouter {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
