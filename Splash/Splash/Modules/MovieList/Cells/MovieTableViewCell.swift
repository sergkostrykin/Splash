//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet private var movieImageView: UIImageView!
    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var releaseLabel: UILabel!
    @IBOutlet private var separator: UIView!
    @IBOutlet private var ratingView: UIView!
    @IBOutlet private var likedLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var likedLabelViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var likedLabelRatingLeadingConstraint: NSLayoutConstraint!
    
    
    func setup(movie: Movie?, isSeparatorHidden: Bool = false) {
        
        movieTitleLabel.text = movie?.title
        let placeholder = UIImage(named: "placeholder")
        if let urlString = movie?.posterPath {
//            let url = "\(Environment.imageUrl)\(urlString)"
//            movieImageView.kf.setImage(with: url.asURL, placeholder: placeholder)
        } else {
            movieImageView.image = placeholder
        }
        let popularity = movie?.popularity ?? 0.0
        let voteAverage = movie?.voteAverage ?? 0.0
        if voteAverage == 0.0 {
            ratingView.isHidden = true
            likedLabelViewLeadingConstraint.isActive = true
            likedLabel.text = "\(Int(popularity))% liked this movie"
        } else {
            ratingView.isHidden = false
            likedLabelViewLeadingConstraint.isActive = false
            likedLabel.text = "\(voteAverage) | \(Int(popularity))% liked this movie"
        }
        
        likedLabelRatingLeadingConstraint.isActive = !likedLabelViewLeadingConstraint.isActive
        let releaseDate = movie?.releaseDate?.apiDate?.releaseDateString ?? ""
        releaseLabel.text = "In theatres \(releaseDate)"
        descriptionLabel.text = movie?.overview
        separator.isHidden = isSeparatorHidden
    }
}
