//
//  NetworkResources.swift
//  Premier League X
//
//  Created by Hady on 16/10/2023.
//

import Foundation
import Alamofire
import SystemConfiguration

struct NetworkResources {

    private static let apiKey = "bcb2e02c517443b5b63becb0d4f5ffea"
    
    static let baseURL = "https://api.football-data.org/"
    
    static var header: HTTPHeaders {
        
        HTTPHeaders([
            "X-Auth-Token" : apiKey
        ])
        
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
    

}
