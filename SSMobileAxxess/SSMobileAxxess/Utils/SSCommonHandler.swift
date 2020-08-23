//
//  SSCommonHandler.swift
//  SSMobileAxxess
//
//  Created by Siddhant on 21/08/20.
//  Copyright © 2020 Siddhant. All rights reserved.
//

import Foundation
import UIKit

typealias alertPrimaryBtnCompletionHandler = () -> Void
typealias alertSecondaryBtnCompletionHandler = () -> Void

class SSCommonHandler {
    func showAlertWithAction(title:String, message:String, primaryBtnTitle:String, viewController:UIViewController,  actionPrimaryBtn : @escaping alertPrimaryBtnCompletionHandler) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: primaryBtnTitle, style: .default, handler: { (action: UIAlertAction!) in
            actionPrimaryBtn()
        }))
        
        viewController.present(alert, animated: true, completion: nil)
    }

    func showAlertWithTwoActions(title:String, message:String, primaryBtnTitle:String, secondaryBtnTitle:String, viewController:UIViewController,  actionPrimaryBtn : @escaping alertPrimaryBtnCompletionHandler,  actionSecondaryBtn : @escaping alertSecondaryBtnCompletionHandler) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: primaryBtnTitle, style: .default, handler: { (action: UIAlertAction!) in
            actionPrimaryBtn()
        }))
        
        alert.addAction(UIAlertAction(title: secondaryBtnTitle, style: .cancel, handler: { (action: UIAlertAction!) in
            actionSecondaryBtn()
        }))
        alert.preferredAction = alert.actions[0]

        viewController.present(alert, animated: true, completion: nil)
    }

}
