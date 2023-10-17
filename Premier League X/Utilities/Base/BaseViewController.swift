//
//  ReviewYourReservationVC + VMEX.swift
//  Car
//
//  Created by hady helal on 14/06/2022.
//

import UIKit
import AVFoundation

class BaseViewController: UIViewController {
    
    fileprivate var containerView: UIView!
    
     private var showMessages: ShowMessageProtocol = ShowMessages()

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: - Subscribtion to all basic  actions
    
    func showErrorMessage(title: String = "Error", message: String) {
        showMessages.showErrorMessage(title: title, body: message)
        AudioServicesPlaySystemSound (1102)
    }
    
    func showSuccessMessage(title: String = "", message: String) {
        showMessages.showSuccessMessage(title: title, body: message)
    }
    
    func checkNetworkError(authError: AuthError?) {
        guard let error = authError else {return}
        
        switch error {
        case .serverError:
            self.serverError()
        case .noInternet:
            self.noInternet()
        default:
            errorMessage(error.rawValue)
        }
    }
    
    
    private func noInternet() {
        print("noInternet")
        showMessages.showErrorMessage(title: "Error", body: "No internet connection, please try again later")
    }
    
    private func serverError() {
        print("ServerError")
        showMessages.showErrorMessage(title: "Server error", body: "Failed to connect to the server")
    }

    
    @objc func setupRefresh(_ scrollView: UIScrollView, refreshAction: Selector) {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: refreshAction, for: .valueChanged)
        scrollView.refreshControl = refresh
    }
    
    func showNativeLoading() {
        
        hideNativeLoading()
        
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .secondarySystemGroupedBackground.withAlphaComponent(0.70)
        containerView.alpha           = 0
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        UIView.animate(withDuration: 0.20) { self.containerView.alpha = 1.0  }
        activityIndicator.startAnimating()
        
    }
    
    func hideNativeLoading() {
        guard self.containerView != nil else {return}
        self.containerView.removeFromSuperview()
        self.containerView = nil
    }
    
    func hideLoadingView(withRefresh: Bool = true){
        guard containerView != nil else { return }
        containerView.removeFromSuperview()
        containerView = nil
    }
    

    
}
