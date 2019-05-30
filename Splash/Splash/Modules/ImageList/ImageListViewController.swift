//  
//  ImageListViewController.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

final class ImageListViewController: UIViewController {
    
    // MARK: - Properties
    private var output: ImageListViewOutput?
    private var images = [Image]()
    
    // MARK: - Outlets
    @IBOutlet private var collectionView: UICollectionView!

    @IBOutlet weak var pageLabel: UILabel!
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(cells: ["ImageCollectionViewCell"])
        pageLabel.text = "1 / \(Constants.pagesMax)"
        output?.didLoad()
    }
}

extension ImageListViewController {
    func attach(output: ImageListViewOutput) {
        self.output = output
    }
}

extension ImageListViewController: ImageListView {
    func showSpinner() {}
    func dismissSpinner() {}
    func showAlert(title: String?, message: String?) {}
    
    func refresh(images: [Image]) {
        self.images = images
        collectionView.reloadData()
    }

}

extension ImageListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.item == images.count - 5 {
            output?.loadNext()
        }

        let image = images[indexPath.item]
        cell.setup(image: image)
        return cell

    }
}

extension ImageListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / CGFloat(Constants.imagesPerRow),
                      height: collectionView.frame.height / CGFloat(Constants.rowsPerPage))
    }

}

extension ImageListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.item]
        output?.showImage(image: image)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(collectionView.contentOffset.x / collectionView.bounds.width) + 1
        pageLabel.text = "\(page) / \(Constants.pagesMax)"
    }

}
