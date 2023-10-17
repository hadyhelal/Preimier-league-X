//
//  BackgroundTaskManager.swift
//  IEM-Drugs
//
//  Created by Hady on 16/06/2023.
//

import UIKit

protocol BackgroundTaskManagerProtocol {
    func backgroundTasksCofigurations()
    func registerBackgroundTask()
    func endBackgroundTask()
}

class BackgroundTaskManager: BackgroundTaskManagerProtocol {
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    
    func backgroundTasksCofigurations() {
        //call endBackgroundTask() on completion..
        switch UIApplication.shared.applicationState {
        case .active, .background:
            registerBackgroundTask()
            print("App is in background.")
            print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
        case .inactive:
            endBackgroundTask()
            break
        @unknown default:
            endBackgroundTask()
            break
        }
    }
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskIdentifier.invalid)
    }
    
    func endBackgroundTask() {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskIdentifier.invalid
    }

}
