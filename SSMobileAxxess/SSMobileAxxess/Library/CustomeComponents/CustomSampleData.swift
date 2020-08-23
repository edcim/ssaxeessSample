//
//  CustomSampleData.swift
//  SSMobileAxxess
//
//  Created by Siddhant on 22/08/20.
//  Copyright © 2020 Siddhant. All rights reserved.
//

import UIKit
import SnapKit

class SampleDataCellModel {
    var idString : String
    var typeString: String
    var dateString : String
    var dataString : String
    
    init(id:String, type:String, date:String, data:String) {
        self.idString = id
        self.typeString = type
        self.dateString = date
        self.dataString = data
    }
    
}

class CustomSampleData: UITableViewCell {

    static let identifier: String = "test_cell_identifier"
//    @IBOutlet weak var idLabel: UILabel!
//    @IBOutlet weak var dataLabel: UILabel!
//    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var typeLabel: UILabel!
//    @IBOutlet weak var mainLabelStackView: UIStackView!
    let lblId = UILabel()
    let lblType = UILabel()
    let lblDate = UILabel()
    let lblData = UILabel()
    let stackView   = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialize UI
        initialUISetUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    fileprivate func lblSetUp() {
        lblId.translatesAutoresizingMaskIntoConstraints = false
        lblId.numberOfLines = 0
        lblId.lineBreakMode = .byWordWrapping
        lblType.translatesAutoresizingMaskIntoConstraints = false
        lblType.numberOfLines = 0
        lblType.lineBreakMode = .byWordWrapping
        lblType.font = UIFont.boldSystemFont(ofSize: 18.0)
        lblDate.translatesAutoresizingMaskIntoConstraints = false
        lblDate.numberOfLines = 0
        lblDate.lineBreakMode = .byWordWrapping
        lblData.translatesAutoresizingMaskIntoConstraints = false
        lblData.numberOfLines = 0
        lblData.lineBreakMode = .byWordWrapping
    }
    
    fileprivate func stackViewSetUp() {
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.fill
        stackView.distribution  = UIStackView.Distribution.fillProportionally
        stackView.spacing   = 10.0
        stackView.addArrangedSubview(lblId)
        stackView.addArrangedSubview(lblType)
        stackView.addArrangedSubview(lblDate)
        stackView.addArrangedSubview(lblData)
        self.contentView.addSubview(stackView)
    }
    
    fileprivate func setUpConstraintForStackView() {
        stackView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.contentView.snp.leading).offset(20)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-20)
            make.top.equalTo(self.contentView.snp.top).offset(20)
            make.bottom.equalTo(self.contentView.snp.bottom).inset(20)
        }
    }
    
    func initialUISetUp() {
        lblSetUp()
        stackViewSetUp()
        setUpConstraintForStackView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Setup data for UI
    func setupUI(sampleDataModel: SampleDataCellModel) {
        lblId.text = "Id: " + (sampleDataModel.idString) 
        lblType.text = "Type: " + (sampleDataModel.typeString) 
        lblDate.text = "Date: " + (sampleDataModel.dateString) 
        lblData.text = "Data: " + (sampleDataModel.dataString) 
    }
 
}
