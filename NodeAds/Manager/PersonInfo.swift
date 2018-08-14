//
//  PersonInfo.swift
//  NodeAds
//
//  Created by Polina on 8/11/18.
//  Copyright © 2018 Polina. All rights reserved.
//

import Foundation

struct PersonInfo: Codable {
    let page: Page
    let items: [Info]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case items
    }
}
    
    struct Page: Codable {
        let currentPage: Int
        let batchSize: Int
        let totalItems: String
        
        private enum CodingKeys: String, CodingKey {
            case currentPage
            case batchSize
            case totalItems
        }
    }
    
struct Info: Codable {
    let id: String?
    let firstname: String?
    let lastname: String?
    let placeOfWork: String?
    let position: String?
    let linkPDF: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case firstname
        case lastname
        case placeOfWork
        case position
        case linkPDF
    }
}
