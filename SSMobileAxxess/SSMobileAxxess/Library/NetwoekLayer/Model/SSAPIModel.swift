//
//  SSAPIModel.swift
//  SSMobileAxxess
//
//  Created by Siddhant on 21/08/20.
//  Copyright © 2020 Siddhant. All rights reserved.
//

import Foundation

struct SSMainAPIResponse : Codable {
    var data:SSAxxessResponse?
    var status: String?
    var message: String?
}

struct SSAxxessResponse : Codable {
    var id:String?
    var type:String?
    var date:String?
    var data:String?
}
