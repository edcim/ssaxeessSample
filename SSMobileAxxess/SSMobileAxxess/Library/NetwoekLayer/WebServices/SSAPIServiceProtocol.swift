//
//  SSAPIServiceProtocol.swift
//  SSMobileAxxess
//
//  Created by Siddhant on 21/08/20.
//  Copyright © 2020 Siddhant. All rights reserved.
//

import Foundation

public struct Constants {
    public typealias jsonErrors = [[String: Any]]
    public typealias data = Data
    public typealias success = Bool
    typealias completionHandler = (Data?, Error?) -> Void
    typealias completionHandlerWithString = (String?, Error?) -> Void
    typealias completionHandlerForService = (Data?, ECError?) -> Void

}

protocol SSAPIServiceProtocol {
  func getRequest(urlString:String, callback:@escaping Constants.completionHandlerForService)
}
