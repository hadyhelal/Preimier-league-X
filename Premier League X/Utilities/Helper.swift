//
//  Helper.swift
//  Car
//
//  Created by hady helal on 01/06/2022.
//

import UIKit
import SystemConfiguration
import Kingfisher
import AVFoundation

struct Helper {
    
    static func liteVibration() {
        UIImpactFeedbackGenerator.init(style: .light).impactOccurred()
    }
    
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    
    static func downloadImages(_ images: [String?], completed: @escaping ([UIImage]) -> Void ) {
        let images = images.compactMap { URL(string: $0 ?? "") }
        var imagesArray = [UIImage]()
        
        for (idx,url) in images.enumerated() {
            let resource = KF.ImageResource(downloadURL: url)
            
            KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
                switch result {
                case .success(let value):
                    print("Image: \(value.image). Got from: \(value.cacheType)")
                    imagesArray.append(value.image)
                    if idx == images.count - 1 {
                        completed(imagesArray)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    if idx == images.count - 1 {
                        completed(imagesArray)
                    }
                }
            }
            
        }
    }


}
