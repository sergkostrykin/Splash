//  
//  ImageSearchPresenter.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation
import URNNetworking

protocol ImageSearchViewOutput: class {
    func searchImages(query: String)
    func back()
    func showImage(image: Image)
}

final class ImageSearchPresenter {
    
    private var router: ImageSearchRouter?
    private weak var view: ImageSearchView?
    
    func search(query: String) {
        view?.showSpinner()
        URNNetworking.searchPhotos(query: query.lowercased()) { [weak self] (json, error) in
            DispatchQueue.main.async {
                self?.view?.dismissSpinner()
                if let error = error {
                    self?.view?.showAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: json ?? [:], options: .prettyPrinted)
                    let results = try JSONDecoder().decode(ImageSearchResult?.self, from: jsonData)
                    let images = results?.results ?? [Image]()
                    self?.view?.refresh(images: images)
                } catch {
                    self?.view?.showAlert(title: "Error", message: error.localizedDescription)
                    print(error)
                }
            }
        }
    }
}

extension ImageSearchPresenter: ImageSearchViewOutput {

    func showImage(image: Image) {
        router?.showImage(image: image)
    }

    func searchImages(query: String) {
        search(query: query)
    }
    
    func back() {
        router?.routeBack()
    }

}

extension ImageSearchPresenter {
    func attach(router: ImageSearchRouter) {
        self.router = router
    }
    
    func attach(view: ImageSearchView) {
        self.view = view
    }
}
