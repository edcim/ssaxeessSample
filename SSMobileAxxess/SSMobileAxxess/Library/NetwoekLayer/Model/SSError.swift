//
//  SSError.swift
//  SSMobileAxxess
//
//  Created by Siddhant on 21/08/20.
//  Copyright © 2020 Siddhant. All rights reserved.
//

import Foundation


class ECError {
    
    var code: String?
    var type: String?
    var message: String?
    
    init(code: String, type:String, message:String) {
        self.code = code
        self.type = type
        self.message = message
    }

}
