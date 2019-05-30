//  
//  ImageListScreen.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

protocol ImageListRouter {
    func showImage(image: Image)
}

final class ImageListScreen {
    private weak var viewController: ImageListViewController?
    private weak var presenter: ImageListPresenter?
    
    private func instantiateViewController() -> ImageListViewController {
        guard let viewController = UIStoryboard(name: "ImageList", bundle: nil).instantiateViewController(withIdentifier: "ImageListViewController") as? ImageListViewController else { fatalError("Failed to load ImageListViewСontroller") }
    
        let presenter = ImageListPresenter()
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

extension ImageListScreen: ImageListRouter {
    
    func showImage(image: Image) {
        ImageDetailsScreen(image: image).push(to: viewController?.navigationController)
    }

}
