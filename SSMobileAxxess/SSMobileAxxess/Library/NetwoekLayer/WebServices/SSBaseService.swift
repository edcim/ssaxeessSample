//
//  SSBaseService.swift
//  SSMobileAxxess
//
//  Created by Siddhant on 21/08/20.
//  Copyright © 2020 Siddhant. All rights reserved.
//

import Foundation
import Alamofire

class SSBaseService:SSAPIServiceProtocol {
    func getRequest(urlString: String, callback: @escaping Constants.completionHandlerForService) {
        var serverError:ECError?
        AF.request(urlString).responseJSON { response in
//            callback(response.data,response.error)
            if(response.data != nil && response.error == nil) {
                debugPrint(response)
                callback(response.data,serverError)
            } else {
                serverError = ECError(code: (response.error?.errorDescription)!, type: (response.error?.responseContentType)!, message: (response.error?.errorDescription)!)
                callback(nil,serverError)
            }
        }
    }
    
    
}
