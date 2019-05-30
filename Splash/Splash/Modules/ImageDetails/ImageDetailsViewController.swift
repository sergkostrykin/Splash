//  
//  ImageDetailsViewController.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

final class ImageDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private var output: ImageDetailsViewOutput?
    
    private var image: Image?

    // MARK: - Outlets

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Actions

    @IBAction func backButtonClicked(_ sender: UIButton) {
        output?.back()
    }
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didLoad()
    }
}

extension ImageDetailsViewController {
    func attach(output: ImageDetailsViewOutput) {
        self.output = output
    }
}

extension ImageDetailsViewController: ImageDetailsView {
    

    func refresh(image: Image?) {
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
