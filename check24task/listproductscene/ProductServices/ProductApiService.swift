//
//  ProductApiService.swift
//  check24task
//
//  Created by Ebrahim abdelhamid on 01/07/2022.
//
import Foundation
import Alamofire
public class APIService  : APIServiceProtocol {
    var productList = [Product]()
    var filterArray = [String]()
    var headerTitle = ""
    var headerDescription = ""
    
    func getProductList(cb : @escaping ([Product]?,[String]?,String,String,Error?) -> () ){
        if let filePath = Bundle.main.url(forResource: "productresponse", withExtension: "json") {

            do {
                let data = try Data(contentsOf: filePath)
                let decoder = JSONDecoder()
                let productSucessRequest = try decoder.decode(ProductResponse.self, from: data)
                cb(productSucessRequest.products ,productSucessRequest.filters,productSucessRequest.header.headerTitle,productSucessRequest.header.headerDescription , nil )


              //  print(speciesList)
            } catch {
                print("Can not load JSON file.")
                cb([],[],"","",error)

            }
        }
    }
    
}
protocol APIServiceProtocol {
    func  getProductList(cb : @escaping ([Product]? , [String]?,String,String,Error?) -> () )
}
