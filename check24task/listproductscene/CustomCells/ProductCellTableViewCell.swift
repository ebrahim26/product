//
//  ProductCellTableViewCell.swift
//  check24task
//
//  Created by Ebrahim abdelhamid on 01/07/2022.
//

import UIKit
import Cosmos
import Kingfisher
class ProductCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productDate: UILabel!
    
    @IBOutlet weak var productDescription: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var rateView: CosmosView!
    var productListCellViewModel :ProductCellViewModel? {
           didSet {
               productName.text = productListCellViewModel?.name
               productDescription.text = productListCellViewModel?.description
               productPrice.text = "\( productListCellViewModel?.price.value ?? 0.0)" +  (productListCellViewModel?.price.currency ?? "")
               productDescription.text = productListCellViewModel?.description
               rateView.rating = productListCellViewModel?.rating ?? 0
               let urls = URL(string:productListCellViewModel?.imageURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? "")
               productImage.kf.setImage(with: urls!)
               var epocTime = TimeInterval(productListCellViewModel?.releaseDate ?? 0)

               let myDate = NSDate(timeIntervalSince1970: epocTime)
               productDate.text = "\(myDate)"
       
           }
       }

}
