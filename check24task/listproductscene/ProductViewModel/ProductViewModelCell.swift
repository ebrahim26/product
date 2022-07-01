//
//  ProductViewModelCell.swift
//  check24task
//
//  Created by Ebrahim abdelhamid on 01/07/2022.
//

import Foundation
struct ProductCellViewModel {

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
