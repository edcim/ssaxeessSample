//
//  ListingViewModel.swift
//  SSMobileAxxess
//
//  Created by Siddhant on 23/08/20.
//  Copyright © 2020 Siddhant. All rights reserved.
//

import Foundation

class ListingViewModel {
    var id:String?
    var type:String?
    var date:String?
    var data:String?
    
    init() {
        
    }
    
    init(id:String, type:String, date:String, data:String) {
        self.id = id
        self.type = type
        self.date = date
        self.data = data
    }
}
