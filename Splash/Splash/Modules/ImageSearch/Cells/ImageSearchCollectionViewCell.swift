//
//  ImageCollectionViewCell.swift
//  Splash
//
//  Created by Sergiy Kostrykin on 5/30/19.
//  Copyright © 2019 SSK. All rights reserved.
//

import UIKit
import Kingfisher

protocol ImageSearchCollectionViewCellDelegate: class {
    
    func imageSearchCollectionViewCell(remove image: Image?)
}

class ImageSearchCollectionViewCell: UICollectionViewCell {

    weak var delegate: ImageSearchCollectionViewCellDelegate?

    private var image: Image?
    
    @IBOutlet private var imageView: UIImageView!
    
    @IBAction func removeButtonClicked(_ sender: UIButton) {
        delegate?.imageSearchCollectionViewCell(remove: image)
    }
    
    func setup(image: Image?) {
        self.image = image
        let placeholder = UIImage(named: "placeholder")
        imageView.image = placeholder
        guard let image = image else { return }
        let url = image.urls?.full
        imageView.kf.setImage(with: image.urls?.thumb?.asURL, placeholder: placeholder) { [weak self] (thumbnailResult) in
            switch thumbnailResult {
            case .success(let value):
                if self?.image?.urls?.full == url {
                    self?.imageView.kf.setImage(with: image.urls?.full?.asURL, placeholder: value.image) { (result) in
                    }
                }
            case .failure(let error):
                self?.imageView.image = placeholder
                print ("Error loading image: \(error)")
            }
        }
     }
}
