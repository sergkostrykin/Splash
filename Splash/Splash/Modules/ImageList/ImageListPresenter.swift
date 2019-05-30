//  
//  ImageListPresenter.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation
import URNNetworking

protocol ImageListViewOutput: class {
    func didLoad()
    func showImage(image: Image)
    func loadNext()
}

final class ImageListPresenter {
    
    private var router: ImageListRouter?
    private weak var view: ImageListView?
    private var currentPage: Int = 1
    private var images = [Image]()
    
    func loadMovies() {
        view?.showSpinner()
        let perPage = Constants.rowsPerPage * Constants.imagesPerRow
        URNNetworking.fetchPhotos(page: currentPage, perPage: perPage) { [weak self] (json, error) in
            DispatchQueue.main.async {
                self?.view?.dismissSpinner()
                if let error = error {
                    self?.view?.showAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: json ?? [:], options: .prettyPrinted)
                    let images = try JSONDecoder().decode([Image]?.self, from: jsonData) ?? [Image]()
                    self?.refresh(newImages: images)
                } catch {
                    self?.view?.showAlert(title: "Error", message: error.localizedDescription)
                    print(error)
                }
            }
        }
    }
    
    private func refresh(newImages: [Image]) {
        self.images.append(contentsOf: newImages)
        view?.refresh(images: images)
    }
}

extension ImageListPresenter: ImageListViewOutput {
    func didLoad() {
        currentPage = 1
        loadMovies()
    }
    
    func showImage(image: Image) {
        router?.showImage(image: image)
    }
    
    func loadNext() {
        if currentPage < Constants.pagesMax {
            currentPage += 1
            loadMovies()
        }
    }
}

extension ImageListPresenter {
    func attach(router: ImageListRouter) {
        self.router = router
    }
    
    func attach(view: ImageListView) {
        self.view = view
    }
}
