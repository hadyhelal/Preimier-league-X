//
//  MatchesAPINetwork.swift
//  Premier League X
//
//  Created by Hady on 16/10/2023.
//

import Foundation
import Alamofire

enum MatchesAPINetwork {
    case getMatches
}

extension MatchesAPINetwork: TargetType {
    var baseURL: String {
        switch self {
        case .getMatches:
            return NetworkResources.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .getMatches:
            return "v4/competitions/2021/matches"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMatches:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getMatches:
            return .requestPlain
        }
    }
    
    var paramter: [String : Any]? {
        switch self {
        case .getMatches:
            return nil
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        default:
            return NetworkResources.header
        }
    }
    
}
