//
//  ImageList.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

struct ImageSearchResult: Decodable {
    
    let total: Int?
    let totalPages: Int?
    let results: [Image]?
    
    enum CodingKeys: String, CodingKey {
        case total
        case results
        case totalPages = "total_pages"
    }
}
