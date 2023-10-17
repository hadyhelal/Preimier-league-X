//
//  ShowMessages.swift
//  Premier League X
//
//  Created by Hady on 15/10/2023.

import UIKit
import SwiftMessages

class ShowMessages: ShowMessageProtocol {
    
    
    let view = MessageView.viewFromNib(layout: .messageView)
    
    init() {
        view.configureDropShadow()
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        view.button?.isHidden  = true
    }
    
    func showErrorMessage(title: String, body: String) {
        view.configureTheme(.error)
        view.configureContent(title: title, body: body)
        SwiftMessages.show(view: view)
    }
    
    func showSuccessMessage(title: String, body: String) {
        view.configureTheme(.success)
        view.configureContent(title: title, body: body)
        SwiftMessages.show(view: view)
    }
    
    func showWarningMessage(title: String, body: String) {
        view.configureTheme(.warning)
        view.configureContent(title: title, body: body)
        SwiftMessages.show(view: view)
    }
    
    func showToastMessage(message: String) {
    }
    
}

protocol ShowMessageProtocol: AnyObject {
    func showErrorMessage(title: String, body: String)
    func showSuccessMessage(title: String, body: String)
    func showToastMessage(message: String)
    func showWarningMessage(title: String, body: String)
}

