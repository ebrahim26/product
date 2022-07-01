//
//  ProductViewModel.swift
//  check24task
//
//  Created by Ebrahim abdelhamid on 01/07/2022.
//

import Foundation

class ProductListViewModel {
    
    let apiService: APIServiceProtocol

     var productModelListOriginal: [Product] = [Product]()
     var productModelListDesign: [Product] = [Product]()
    var filterArray :[String] = [String]()
    var headerTitle = ""
    var headerDescription = ""

    
     var cellViewModels: [ProductCellViewModel] = [ProductCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var state: State = .error
        
       
    var numberOfCells: Int {
        return cellViewModels.count
    }
    var recipeModel: Product?

    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        apiService.getProductList(){ [weak self](productList,filterList,headerTitle,headerDescription, error) in
            guard let self = self else {
                return
            }

            guard error == nil else {
                self.state = .error
                return
            
            }
            self.productModelListOriginal = productList!
            self.productModelListDesign = self.productModelListOriginal
            self.filterArray = filterList!
            self.headerTitle = headerTitle
            self.headerDescription = headerDescription
            self.processFetchedSpecies(productModelList: self.productModelListDesign)
        }
    }
    
   
 
    func filterMethod(type:String){
//
        if type == "all"{
    productModelListDesign = productModelListOriginal
            processFetchedSpecies(productModelList: productModelListDesign)
        }else{
            var availableArray = productModelListOriginal.filter{$0.available == true}
            productModelListDesign = availableArray
            print(availableArray.count)
           processFetchedSpecies(productModelList: productModelListDesign)
        }
        
    }
   
    
     func processFetchedSpecies( productModelList: [Product] ) {
        //self.speciesModelListDesign = recipeModelList // Cache
        var vms = [ProductCellViewModel]()
        for products in productModelList {
            vms.append( createCellViewModel(productModel: products) )
        }
        self.cellViewModels = vms
    }
    func createCellViewModel( productModel : Product ) -> ProductCellViewModel {

        return ProductCellViewModel(name:productModel.name , type:productModel.type , id: productModel.id, color: productModel.color, imageURL: productModel.imageURL, colorCode: productModel.colorCode, available: productModel.available, releaseDate: productModel.releaseDate, description: productModel.description, longDescription: productModel.longDescription, rating: productModel.rating, price: productModel.price)
    }
    func getCellViewModel( at indexPath: IndexPath ) -> ProductCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    
}
