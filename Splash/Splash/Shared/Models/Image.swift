//
//  Movie.swift
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//
import Foundation


struct Image: Decodable {
    let id: String?
    let urls: Urls?
    
    enum CodingKeys: String, CodingKey {
        case id
        case urls
    }    
}


struct Urls: Decodable {
    
    let raw: String?
    let full: String?
    let regular: String?
    let small: String?
    let thumb: String?
    
    enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

