//
//  productmodel.swift
//  check24task
//
//  Created by Ebrahim abdelhamid on 01/07/2022.

import Foundation

// MARK: - Welcome
struct ProductResponse: Codable {
    let header: Header
    let filters: [String]
    let products: [Product]
}

// MARK: - Header
struct Header: Codable {
    let headerTitle, headerDescription: String
}

// MARK: - Product
struct Product: Codable {
    var name: String
    var type: String
    var id: Int
    var color: String
    var imageURL: String
    var colorCode: String
    var available: Bool
    var releaseDate: Int
    var description,longDescription: String
    var rating: Double
    var price: Price

}


// MARK: - Price
struct Price: Codable {
    var value: Double
    var currency: String
}
 
