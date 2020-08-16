//
//  ListViewController.swift
//  CavistaiosCodeChallenge
//
//  Created by Sourabh Kumbhar on 12/08/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import UIKit
import SnapKit

class ListViewController: UIViewController {

    // Variables
    private let tableView           = UITableView()
    private var progreeView         : ProgressHUD?
    private var responseModelArray  = Array<ResponseDataModel>()
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.callFetchData()
    }
    
    private func setupUI() {
        setupTableView()
        setupProgressView()
    }
    
    private func setupTableView() {
        // Add view to superView
        self.view.addSubview(tableView)
        // Add constraint to view
        tableView.snp.makeConstraints{ (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0))
        }
        // Add appearance to view
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: TableCellIdentifire.listTableViewCell)
        tableView.separatorColor = .clear
        tableView.backgroundView = getTableViewBackgroundLabel()
    }
    
    private func setupProgressView() {
        progreeView = ProgressHUD(text: ConstantHelper.fetchingData)
        self.view.addSubview(progreeView!)
        progreeView?.backgroundColor = UIColor.lightGray
        progreeView?.hide()
    }
    
}

extension ListViewController {
    
    // Network request
    private func callFetchData() {
        // Check if internet connection is there if yes then get data from webservice and no then get data from database
        if Connectivity.isConnectedToInternet() {
            let networkServices = NetworkSerives()
            networkServices.fetchData()
            networkServices.delegate = self
            progreeView?.show()
        } else {
            responseModelArray = RealmHelper.getResponseData()
        }
    }
    
    private func filterArray(dataModelArray: Array<ResponseDataModel>) {
        // filter according to empty data
        self.responseModelArray = dataModelArray.filter({
            datamodel in
            !(datamodel.data?.isEmpty ?? false)
        })
        // filter according valid image url
        self.responseModelArray = responseModelArray.filter({
            datamodel in
            if datamodel.type == ConstantHelper.image {
                let status = datamodel.data?.isValidURL ?? false ? true : false
                return status
            } else {
                return true
            }
        })
    }
}

// MARK:- Custom delegate

extension ListViewController: NetworkServicesDelegate {
    
    // Here got the data from webservice and store into database
    func didGetData(dataModelArray: Array<ResponseDataModel>) {
        self.progreeView?.hide()
        // Filter array and assign to tableView array
        filterArray(dataModelArray: dataModelArray)
        tableView.backgroundView?.isHidden = true
        RealmHelper.storeResponseData(responseDataArray: responseModelArray)
        self.tableView.reloadData()
    }
    
    // Error from webservice
    func didGetError(error: String) {
        self.progreeView?.hide()
        tableView.backgroundView?.isHidden = false
        self.showAlert(title: ConstantHelper.error, message: error)
    }

}

// MARK:- UITableView delegates and datasource

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if responseModelArray.count == 0 {
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.backgroundView?.isHidden = true
        }
        return responseModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifire.listTableViewCell, for: indexPath) as! ListTableViewCell
        // check condition for indexPath out of bound then assign data to the cell
        if responseModelArray.count > indexPath.row {
            let responseModel = responseModelArray[indexPath.row]
            cell.configurCell(responseData: responseModel)
        }
        cell.separatorInset = .zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        // Navigate to details view controller
        let detailsVC = DetailsViewController()
        detailsVC.responseDataModel = responseModelArray[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
