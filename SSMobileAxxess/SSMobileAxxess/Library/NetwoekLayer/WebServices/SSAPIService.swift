//
//  SSAPIService.swift
//  SSMobileAxxess
//
//  Created by Siddhant on 21/08/20.
//  Copyright © 2020 Siddhant. All rights reserved.
//

import Foundation

class SSAPIService : SSBaseService {
    let apiService:SSAPIServiceProtocol
    init( apiService: SSAPIServiceProtocol = SSBaseService()) {
        self.apiService = apiService
    }
    
    func getJSONFromNetwork(urlString : String, completed: ((_ responseModel: [SSAxxessResponse]?,_ error:ECError?) -> ())?) {
        
        apiService.getRequest(urlString: urlString, callback: { (data:Data?,error:ECError?) -> Void in
            if(error == nil && data != nil){
                do {
                    
                    let responseString = String(data: data!, encoding: .utf8)
                    
                    print("responseString = \(String(describing: responseString))")
                    let ggg = responseString?.replacingOccurrences(of: "\\", with: "")
                    print("responseString = \(String(ggg ?? ""))")
                    
                    let decoder = JSONDecoder()
                    let eventCheckInData = try decoder.decode([SSAxxessResponse].self, from: data!)
                    completed?(eventCheckInData,error)
                    
                } catch let error {
                    
                    let serverError = ECError.init(code: "00", type: "Unknown", message: error.localizedDescription)
                    
                    completed?(nil,serverError)
                    
                }
                
                
            }else{
                completed?(nil,error)
                
            }
            
        })
    }
    
}
