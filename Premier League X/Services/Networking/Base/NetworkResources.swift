//
//  NetworkResources.swift
//  Premier League X
//
//  Created by Hady on 16/10/2023.
//

import Foundation
import Alamofire

struct NetworkResources {

    private static let apiKey = "bcb2e02c517443b5b63becb0d4f5ffea"
    
    static let baseURL = "https://api.football-data.org/"
    
    static var header: HTTPHeaders {
        
        HTTPHeaders([
            "X-Auth-Token" : apiKey
        ])
        
    }
    

}
