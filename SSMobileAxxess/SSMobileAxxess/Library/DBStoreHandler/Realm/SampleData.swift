//
//  SampleData.swift
//  SSMobileAxxess
//
//  Created by Siddhant on 21/08/20.
//  Copyright © 2020 Siddhant. All rights reserved.
//

import Foundation
import RealmSwift

class SampleData : Object  {
    @objc dynamic var id = ""
    @objc dynamic var type = ""
    @objc dynamic var date = ""
    @objc dynamic var data = ""
    
//    override class func primaryKey() -> String {
//        return "date"
//    }
}
