//  
//  ImageDetailsPresenter.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation
import URNNetworking

protocol ImageDetailsViewOutput: class {
    func didLoad()
    func back()
}

final class ImageDetailsPresenter {
    private var router: ImageDetailsRouter?
    private weak var view: ImageDetailsView?
    
    var image: Image?
    
    
    init(image: Image?) {
        self.image = image
    }
    

    func loadImage() {
        view?.refresh(image: image)
    }

}

extension ImageDetailsPresenter: ImageDetailsViewOutput {
    func didLoad() {
        print(#function)
        loadImage()
    }
    
    func back() {
        router?.routeBack()
    }
}

extension ImageDetailsPresenter {
    func attach(router: ImageDetailsRouter) {
        self.router = router
    }
    
    func attach(view: ImageDetailsView) {
        self.view = view
    }
}
