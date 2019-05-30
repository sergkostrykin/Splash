//
//  UICollectionViewExtension.swift
//  Enterprise
//
//  Created by Sergiy Kostrykin on 4/19/18.
//  Copyright © 2018 Jens Borghardt. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register(cells: [String]) {
        cells.forEach({ self.register(UINib.init(nibName: $0, bundle: nil), forCellWithReuseIdentifier: $0) })
    }
}
