//  
//  ImageSearchScreen.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

protocol ImageSearchRouter {
    func showImage(image: Image)
    func routeBack()
}

final class ImageSearchScreen {
    private weak var viewController: ImageSearchViewController?
    private weak var presenter: ImageSearchPresenter?
    
    private func instantiateViewController() -> ImageSearchViewController {
        guard let viewController = UIStoryboard(name: "ImageSearch", bundle: nil).instantiateViewController(withIdentifier: "ImageSearchViewController") as? ImageSearchViewController else { fatalError("Failed to load ImageSearchViewСontroller") }
    
        let presenter = ImageSearchPresenter()
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

extension ImageSearchScreen: ImageSearchRouter {
    
    func showImage(image: Image) {
        ImageDetailsScreen(image: image).push(to: viewController?.navigationController)
    }
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }

}
