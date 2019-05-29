//  
//  MovieDetailsView.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/17/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

protocol MovieDetailsView: class {
    
    func refresh(movie: Movie?)
    
    func showAlert(title: String?, message: String?)

    func showSpinner()

    func dismissSpinner()
}
