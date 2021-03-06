//  
//  ImageDetailsScreen.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

protocol ImageDetailsRouter {
    func routeBack()
}

final class ImageDetailsScreen {
    private weak var viewController: ImageDetailsViewController?
    private weak var presenter: ImageDetailsPresenter?
    private var image: Image?
    
    init(image: Image?) {
        self.image = image
    }

    private func instantiateViewController() -> ImageDetailsViewController {
        guard let viewController = UIStoryboard(name: "ImageDetails", bundle: nil).instantiateViewController(withIdentifier: "ImageDetailsViewController") as? ImageDetailsViewController else { fatalError("Failed to load ImageDetailsViewСontroller") }
    
        let presenter = ImageDetailsPresenter(image: image)
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

extension ImageDetailsScreen: ImageDetailsRouter {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
