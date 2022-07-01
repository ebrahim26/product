//
//  ProductNonAvailableTableViewCell.swift
//  check24task
//
//  Created by Ebrahim abdelhamid on 01/07/2022.
//

import UIKit
import Cosmos

class ProductNonAvailableTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productDescription: UILabel!
    
    @IBOutlet weak var rateView: CosmosView!

    var productListCellViewModel :ProductCellViewModel? {
           didSet {
               productName.text = productListCellViewModel?.name
               productDescription.text = productListCellViewModel?.description
               rateView.rating = productListCellViewModel?.rating ?? 0
               let urls = URL(string:productListCellViewModel?.imageURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? "")
               productImage.kf.setImage(with: urls!)

           }
       }

}
