//
//  SSViewModelObjectMapper.swift
//  SSMobileAxxess
//
//  Created by Siddhant on 23/08/20.
//  Copyright © 2020 Siddhant. All rights reserved.
//

import Foundation
import UIKit

class SSViewModelObjectMapper {
    static func getEventViewModelObject(serverObjs:[SSAxxessResponse]) -> [ListingViewModel]{
        var listingData:[ListingViewModel] = [ListingViewModel]()
        
        for serverObj in serverObjs {
            let listDataVM = ListingViewModel(id: serverObj.id ?? "Nothing", type: serverObj.type ?? "Nothing", date: serverObj.date ?? "Nothing", data: serverObj.data ?? "Nothing")
            listingData.append(listDataVM)
        }
        return listingData
    }
}
