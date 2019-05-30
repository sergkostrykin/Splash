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
    
    var image: Image?
    
    
    init(image: Image?) {
        self.image = image
    }
    

    func loadImage() {
        view?.refresh(image: image)
    }

}

extension MovieDetailsPresenter: MovieDetailsViewOutput {
    func didLoad() {
        print(#function)
        loadImage()
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
