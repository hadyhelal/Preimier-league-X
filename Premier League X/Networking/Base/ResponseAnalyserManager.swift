//
//  ResponseAnalyserManager.swift
//  Premier League X
//
//  Created by Hady on 15/10/2023.
//


import Alamofire
import UIKit

protocol ResponseAnalyserManagerProtocol {
    func analyseAPIResponse(response: AFDataResponse<Data>) -> AuthError?
}


class ResponseAnalyserManager: ResponseAnalyserManagerProtocol {
    
    
     func analyseAPIResponse(response: AFDataResponse<Data> ) -> AuthError? {
        let status = response.response?.statusCode
        
        switch status {
        case 200:
            return nil
        case 500:
            return .internalServerError
        case 404:
            return .pageNotFound
        default:
            break
        }
        
        guard response.error == nil else {
            return .invalidData(response.error?.localizedDescription ?? "Unknow Error Occured")
        }
        
        guard response.value != nil else {
            return .invalidData(response.error?.localizedDescription ?? "Unknow Error Occured")
        }
        
        return nil
    }
    
}
