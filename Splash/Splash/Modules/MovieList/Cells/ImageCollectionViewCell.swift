//
//  ImageCollectionViewCell.swift
//  Splash
//
//  Created by Sergiy Kostrykin on 5/30/19.
//  Copyright © 2019 SSK. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var imageView: UIImageView!
    
    func setup(image: Image?) {
        imageView.kf.setImage(with: image?.urls?.thumb?.asURL, placeholder: UIImage(named: "placeholder"))
     }
}
