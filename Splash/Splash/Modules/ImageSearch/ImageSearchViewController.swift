//  
//  ImageSearchViewController.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

final class ImageSearchViewController: UIViewController {
    
    // MARK: - Properties
    private var output: ImageSearchViewOutput?
    private var images = [Image]()
    
    // MARK: - Outlets
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var emptyResultsLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func backButtonClicked(_ sender: UIButton) {
        textField.resignFirstResponder()
        output?.back()
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(cells: ["ImageSearchCollectionViewCell"])
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray,
                                                         .font: UIFont.italicSystemFont(ofSize: 12)]
        textField.attributedPlaceholder = NSAttributedString(string: "Type something", attributes: attributes)

    }
    
    private func clear() {
        images.removeAll()
        collectionView.reloadData()
    }
}

extension ImageSearchViewController {
    func attach(output: ImageSearchViewOutput) {
        self.output = output
    }
}

extension ImageSearchViewController: ImageSearchView {
    
    func refresh(images: [Image]) {
        self.images = images
        emptyResultsLabel.isHidden = !images.isEmpty
        collectionView.reloadData()
    }
    
    func showSpinner() {}
    func dismissSpinner() {}
    func showAlert(title: String?, message: String?) {}
}

extension ImageSearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSearchCollectionViewCell", for: indexPath) as? ImageSearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let image = images[indexPath.item]
        cell.delegate = self
        cell.setup(image: image)
        return cell

    }
}

extension ImageSearchViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(Constants.searchResultsPerRow)
        return CGSize(width: width, height: width)
    }

}

extension ImageSearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.item]
        output?.showImage(image: image)
        textField.resignFirstResponder()
    }
}

extension ImageSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            clear()
            return true
        }
        let newValue = (text as NSString).replacingCharacters(in: range, with: string)
        if newValue.count < Constants.minSearchQuery {
            clear()
            return true
        }
        output?.searchImages(query: newValue)
        return true
    }
}

extension ImageSearchViewController: ImageSearchCollectionViewCellDelegate {
    
    func imageSearchCollectionViewCell(remove image: Image?) {
        guard let index = images.firstIndex(where: { $0.id == image?.id }) else { return }
        images.remove(at: index)
        collectionView.performBatchUpdates({
            collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        }) { (completed) in
            
        }
    }
}
