//  
//  ImageListView.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

protocol ImageListView: class {

    func showSpinner()
    func dismissSpinner()
    func showAlert(title: String?, message: String?)
    func refresh(images: [Image])
}
