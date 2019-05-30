//  
//  MovieListScreen.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

protocol MovieListRouter {
    func showImage(image: Image)
}

final class MovieListScreen {
    private weak var viewController: MovieListViewController?
    private weak var presenter: MovieListPresenter?
    
    private func instantiateViewController() -> MovieListViewController {
        guard let viewController = UIStoryboard(name: "MovieList", bundle: nil).instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController else { fatalError("Failed to load MovieListViewСontroller") }
    
        let presenter = MovieListPresenter()
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

extension MovieListScreen: MovieListRouter {
    
    func showImage(image: Image) {
        MovieDetailsScreen(image: image).push(to: viewController?.navigationController)
    }

}
