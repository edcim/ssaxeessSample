//
//  DetailsViewController.swift
//  SSMobileAxxess
//
//  Created by Siddhant on 22/08/20.
//  Copyright © 2020 Siddhant. All rights reserved.
//

import UIKit
import Kingfisher
import Foundation

class DetailsViewController: UIViewController {
    
    var data = ListingViewModel()
    
    lazy var backView: UIView = {
    let view = UIView()
    view.backgroundColor = .darkGray
    return view
    }()
    
    lazy var backBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    lazy var dataLabel : UITextView = {
        let lblData = UITextView()
        lblData.font = UIFont.systemFont(ofSize: 18)
        lblData.isUserInteractionEnabled = true
        lblData.isScrollEnabled = true
        lblData.isEditable = false
        return lblData
    }()
    
    lazy var idLabel : UILabel = {
       let lblid = UILabel()
        return lblid
    }()

    lazy var dateLabel : UILabel = {
        let lblDate = UILabel()
        return lblDate
    }()

    lazy var typeLabel : UILabel = {
       let lblData = UILabel()
        lblData.numberOfLines = 0
        lblData.lineBreakMode = .byWordWrapping
        return lblData
    }()
    
    lazy var photoView: UIImageView = {
        let uiImageView = UIImageView()
        return uiImageView
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis  = NSLayoutConstraint.Axis.vertical
        stack.alignment = UIStackView.Alignment.fill
        stack.distribution  = UIStackView.Distribution.fillProportionally
        stack.spacing   = 10.0
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialUSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkType()
        setUpDataForUI()
    }
    
    func checkType() {
        if((self.data.type?.contains("text"))!) {
            self.photoView.isHidden = true
            self.dataLabel.isHidden = false
        } else {
            self.photoView.isHidden = false
            self.dataLabel.isHidden = true
        }
    }
    
    func setUpDataForUI() {
        self.idLabel.text = "Id: " + (data.id ?? "Nothing")
        self.typeLabel.text = "Type: " + (data.type ?? "Nothing")
        self.dateLabel.text = "Date: " + (data.date ?? "Nothing")
        if((data.type?.contains("text"))!) {
            dataLabel.text = "Data: " + (data.data ?? "Nothing")
        } else {
            if let urlString = data.data {
                let url = URL(string: urlString)
                photoView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                    if(error == nil ) {
                        
                    } else {
                        self.dataLabel.isHidden = false
                        self.dataLabel.text = "Data: " + "Image not available for link" + "\n" + urlString
                    }
                }
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK :- Subviews
    fileprivate func addBasicSubiews() {
        self.view.addSubview(backView)
        self.backView.addSubview(backBtn)
        self.view.addSubview(stackView)
        self.stackView.addArrangedSubview(idLabel)
        self.stackView.addArrangedSubview(typeLabel)
        self.stackView.addArrangedSubview(dateLabel)
        
        self.view.addSubview(photoView)
        self.view.addSubview(dataLabel)
        
        self.dataLabel.isHidden = true
        self.photoView.isHidden = true
    }
    
    //MARK :- Constraint
    fileprivate func backViewConstraint() {
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(40)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.height.equalTo(50)
        }
        
        backBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.equalTo(backView.snp.leading).offset(-10)
            make.width.equalTo(backView.snp.width).dividedBy(3)
        }
    }
    
    fileprivate func stackViewConstaint() {
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(backView.snp.bottom).offset(10)
            make.leading.equalTo(self.view.snp.leading).offset(10)
            make.trailing.equalTo(self.view.snp.trailing).offset(-10)
            make.trailing.equalToSuperview()
        }
    }
    
    fileprivate func photoViewConstraint() {
        photoView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            
        }
    }
    
    fileprivate func dataLabelConstraint() {
        dataLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.view.snp.leading).offset(10)
            make.trailing.equalTo(self.view.snp.trailing).offset(-10)
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }
    
    func initialUSetUp() {
        addBasicSubiews()
        backViewConstraint()
        stackViewConstaint()
        photoViewConstraint()
        dataLabelConstraint()
    }
    
    //MARK :- Actions
    @objc func close(){
        self.navigationController?.popViewController(animated: true)
    }
    

}
