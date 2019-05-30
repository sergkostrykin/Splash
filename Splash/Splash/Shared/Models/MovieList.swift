//
//  ImageList.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

struct ImageList: Decodable {
    
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [Image]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
