//
//  ListingViewController.swift
//  SSMobileAxxess
//
//  Created by Siddhant on 22/08/20.
//  Copyright © 2020 Siddhant. All rights reserved.
//

import UIKit
import SwiftSpinner
import SnapKit


class ListingViewController: UIViewController {

    let sampleStore = SampleDataStore()
    var tblSampleData : UITableView!

//    var data : [SSAxxessResponse] = []
    var data : [ListingViewModel] = []
    
    lazy var backView: UIView = {
        let view = UIView()
        return view
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize UI
        initialUSetUp()
    }

    // InitialUISetUp
    func initialUSetUp() {
        tblViewSampleDataSetUp()
    }
    
    fileprivate func tblViewSampleDataSetUp() {
        
        self.view.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(40)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        tblSampleData = UITableView(frame: .zero)
        self.backView.addSubview(tblSampleData)
        tblSampleData.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tblSampleData.register(CustomSampleData.self, forCellReuseIdentifier: CustomSampleData.identifier)
        self.tblSampleData.rowHeight = 100
        self.tblSampleData.estimatedRowHeight = UITableView.automaticDimension
        
        tblSampleData.dataSource = self
        tblSampleData.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SwiftSpinner.show("Fetching Data")
        if SSNetworkRechability.isConnectedToNetwork() {
            self.callForNetwork()
        } else {
            self.getObjectsFromDB()
        }
    }
    
    // get offlie data
    func getObjectsFromDB() {
        data.removeAll()
        let resultArray = self.sampleStore.getAllObjects()
        for i in resultArray {
            data.append(ListingViewModel(id: i.id, type: i.type, date: i.date, data: i.data))
        }
        self.data = self.data.sorted(by: { (Obj1, Obj2) -> Bool in
           let type0 = Obj1.type ?? ""
           let type1 = Obj2.type ?? ""
            return (type0.lowercased().localizedCaseInsensitiveCompare(type1.lowercased()) == .orderedAscending)
        })
        self.tblSampleData.reloadData()
        SwiftSpinner.hide()
    }
    
    // save data into DB
    fileprivate func saveDBOperation(_ response: [SSAxxessResponse]?) {
        self.sampleStore.deleteAllData()
        if let listData = response {
            for data in listData {
                let sample = self.sampleStore.makeNewSampleData(data.id ?? "", type: data.type ?? "" , date: data.date ?? "", data: data.data ?? "")
                self.sampleStore.saveComicBook(sample)
            }
        }
    }
    
    // API call
    func callForNetwork() {
        SSAPIService().getJSONFromNetwork(urlString: "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json") { (response:[SSAxxessResponse]?, error:ECError?) in
            if(response != nil && error == nil) {
                if let listData = response {
                    self.data = SSViewModelObjectMapper.getEventViewModelObject(serverObjs: listData)
                    self.data = self.data.sorted(by: { (Obj1, Obj2) -> Bool in
                        let type0 = Obj1.type ?? ""
                        let type1 = Obj2.type ?? ""
                        return (type0.lowercased().localizedCaseInsensitiveCompare(type1.lowercased()) == .orderedAscending)
                    })
                    self.saveDBOperation(listData)
                }
                SwiftSpinner.hide()
                self.tblSampleData.reloadData()
            } else {
                SwiftSpinner.hide()
                SSCommonHandler().showAlertWithAction(title: "Error", message: error.debugDescription, primaryBtnTitle: "Ok", viewController: self){
                    
                }
            }
        }
    }
}

extension ListingViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- Tablbiew delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomSampleData.identifier, for: indexPath) as! CustomSampleData
        var idString = ""
        var typeString = ""
        var dateString = ""
        var dataString = ""
        
        if let id = data[indexPath.row].id {
            idString = id
        } else {
            idString = "Nothing"
        }
        
        if let type = data[indexPath.row].type {
            typeString = type
        } else {
            typeString = "Nothing"
        }
        
        if let date = data[indexPath.row].date {
            dateString = date
        } else {
            dateString = "Nothing"
        }
        
        if let data = data[indexPath.row].data {
            dataString = data
        } else {
            dataString = "Nothing"
        }
        let sampleDataCellModel = SampleDataCellModel(id: idString, type: typeString, date: dateString, data: dataString)
        cell.setupUI(sampleDataModel: sampleDataCellModel)
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = DetailsViewController()
        detailsViewController.data = data[indexPath.row]
        detailsViewController.view.backgroundColor = .white
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
