//
//  UIViewController + Ext.swift
//  Menna
//
//  Created by Hady Helal on 04/01/2022.
//

import UIKit
import MobileCoreServices
import SwiftMessages
import AVFoundation


fileprivate var scrollViewAnimator = [UIScrollView]()
fileprivate var enableLocationIsShowed: Bool = false


extension UIViewController {
    
//    MARK: - Viewcontrollers Navigations
    func removeAllVCsAndMoveTo(vc: UIViewController, creatNavigationC: Bool = false) {
        var viewController = vc
        
        
        if creatNavigationC { viewController = UINavigationController(rootViewController: viewController)}
        
        viewController.navigationController?.setNavigationBarHidden(true, animated: true)
        viewController.navigationController?.navigationBar.isHidden = true
        DispatchQueue.main.async { [weak self] in
            guard let window = self?.view.window else { return }
            window.rootViewController?.dismiss(animated: false, completion: nil)
            UIView.transition(with: window, duration: 0.7, options: [UIView.AnimationOptions.curveEaseInOut], animations: {
            }, completion: {_ in})
            
            UIApplication.shared.windows.first?.rootViewController = viewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
        }
    }

    
    func backToTabBarIndex(_ index: Int) {
        guard let tabBarController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? UITabBarController else {
            return
        }
        tabBarController.tabBar.isHidden = false
        tabBarController.tabBar.layer.zPosition = 0
        
        //tabBarController.selectedIndex = index
        let tabBar = self.tabBarController
        tabBar?.selectedIndex = index
        guard let HomeNavigation = tabBarController.viewControllers else { return }
        guard let navigation = HomeNavigation[0]  as? UINavigationController else { return }
        navigation.popToRootViewController(animated: false)
    }
    
    func changeTabBarRoot() {
        guard let tabBarController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? UITabBarController else {
            return
        }
        
        let tabBar = self.tabBarController
        tabBar?.selectedIndex = 1
        guard let HomeNavigation = tabBarController.viewControllers else { return }
        guard let navigation = HomeNavigation[0]  as? UINavigationController else { return }
        navigation.popToRootViewController(animated: false)
        
    }
    
    
    /// pop back to specific viewcontroller
    func popBack<T: UIViewController>(toControllerType: T.Type, completion:@escaping (T?) -> Void) {
        var didFound = false
        if var viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            viewControllers = viewControllers.reversed()
            for currentViewController in viewControllers {
                if currentViewController .isKind(of: toControllerType) {
                    self.navigationController?.popToViewController(currentViewController, animated: true)
                    didFound = true
                    completion(currentViewController as? T)
                    break
                }
            }
            
            if didFound == false { completion(nil) }
            
        } else { completion(nil)}
    }
    
    func animateShowViewCrossDissolver(animatedViews: [UIView]) {
        for animatedView in animatedViews {
            UIView.transition(with: animatedView, duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                animatedView.isHidden = false
                animatedView.alpha    = 1
                self?.view.layoutIfNeeded()
            })
        }
    }
    
    func animateHideViewCrossDissolver(animatedViews: [UIView]) {
        for animatedView in animatedViews {
            UIView.transition(with: animatedView, duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                animatedView.isHidden = true
                animatedView.alpha    = 0
                self?.view.layoutIfNeeded()
            })
        }
    }
    
    //MARK: - Alerts & Messages

    func showErrorAlertWithAction(message: String, btnTitle: String, task: (() -> Void)? = nil) {
        let alert  = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: btnTitle, style: .cancel) { _ in
            if let task = task { task()}
        }
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func showEmptyAlert(title: String = "", message: String, buttonTitle: String = "Ok", task: (() -> Void)? = nil) {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .cancel) { _ in
            if let task = task { task()}
        }
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func showNormalAlert(title: String, message: String, btnTitle: String, completed: @escaping((Bool) -> Void)) {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionA = UIAlertAction(title: btnTitle, style: .default) { _ in
            completed(true)
        }
        let actionB = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completed(false)
        }
        alert.addAction(actionA)
        alert.addAction(actionB)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func notificationMessage(message: String?,title: String?, type: UIAlertController.Style? = nil) {
        let optionMenu = UIAlertController(title: title, message: message, preferredStyle: type ?? UIAlertController.Style.actionSheet)
        let action = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
        }

        optionMenu.addAction(action)
        // 5
        optionMenu.modalPresentationStyle = .popover
        if let popoverController = optionMenu.popoverPresentationController {
            popoverController.sourceView = view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        
        present(optionMenu, animated: true)
    }
    
    
}
