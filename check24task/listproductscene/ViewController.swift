//
//  ViewController.swift
//  check24task
//
//  Created by Ebrahim abdelhamid on 01/07/2022.
//

import UIKit
import Cosmos

class ProductViewController: UIViewController {

    @IBOutlet weak var alleButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var descriptionHeader: UILabel!
    @IBOutlet weak var titleHeader: UILabel!
    @IBOutlet weak var verfügbarButton: UIButton!
    
    @IBOutlet weak var vorgemerktButton: UIButton!
    lazy var viewModel: ProductListViewModel = {
        return ProductListViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        initVM()

    }
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        initVM()
    }

    @IBAction func alleButton(_ sender: UIButton) {
        viewModel.filterMethod(type: "all")
    }
    
    
    @IBAction func verfugbarAction(_ sender: UIButton) {
        viewModel.filterMethod(type: "available")
    }
    @IBAction func vorgemerktAction(_ sender: UIButton) {
        
    }
    let refreshControl = UIRefreshControl()
    func initView(){
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           tableView.addSubview(refreshControl)
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        customView.backgroundColor = UIColor(red: 23/100, green: 54/100, blue: 111/100, alpha: 1)
        //rgb(23, 54, 111)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        button.setTitle("footer", for: .normal)
        button.addTarget(self, action: #selector(openLink), for: .touchUpInside)
        customView.addSubview(button)
        tableView.tableFooterView = customView

    }
    @objc func openLink(_ sender: UIButton!) {
        print("Button tapped")
        if let url = URL(string: "http://m.check24.de/rechtliche-hinweise?deviceoutput=app") {
            UIApplication.shared.open(url)
        }
    }
    
    func initVM(){
        viewModel.initFetch()
        
        viewModel.reloadTableViewClosure = { [weak self] () in
         
            DispatchQueue.main.async {
                self?.titleHeader.text = self?.viewModel.headerTitle ?? ""
                self?.descriptionHeader.text = self?.viewModel.headerDescription ?? ""
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()

            }
           
        }
    

    }
}

extension ProductViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       if viewModel.cellViewModels[indexPath.row].available {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "availableCell", for: indexPath) as? ProductCellTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.productListCellViewModel = cellVM
        cell.selectionStyle = .none
        return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "nonAvailableCell", for: indexPath) as? ProductNonAvailableTableViewCell else {
                fatalError("Cell not exists in storyboard")
            }
            let cellVM = viewModel.getCellViewModel( at: indexPath )
            cell.productListCellViewModel = cellVM
            cell.selectionStyle = .none
            return cell
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if viewModel.state == .error {
//          return 1
//        }else{
       return viewModel.numberOfCells
       // }
    }
    
    
}
