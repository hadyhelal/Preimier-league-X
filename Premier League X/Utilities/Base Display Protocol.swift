//
//  Base Display Protocol.swift
//  IEM-Drugs
//
//  Created by WAITEG on 03/09/2023.
//

import Foundation

enum LoadingView {
    case show, hide
}

protocol BaseDisplayProtocol: AnyObject {
    func loading(_ loading: LoadingView)
    func errorMessage(_ message: String)
    func successMessage(_ message: String)
    func networkError(_ error: AuthError)
}

protocol BasePresenterOutProtocol: AnyObject {
}

extension BaseViewController: BaseDisplayProtocol {
    func errorMessage(_ message: String) {
        showErrorMessage(message: message)
    }
    
    func successMessage(_ message: String) {
        showSuccessMessage(message: message)
    }
    
    func loading(_ loading: LoadingView) {
        switch loading {
        case .show:
            showNativeLoading()
        case .hide:
            hideNativeLoading()
        }
    }
    
    func networkError(_ error: AuthError) {
        checkNetworkError(authError: error)
    }

}
