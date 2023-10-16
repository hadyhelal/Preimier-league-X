//
//  MatchesAPI.swift
//  Premier League X
//
//  Created by Hady on 16/10/2023.
//

import Foundation
import Alamofire

protocol MatchesAPIProtocol {
    func getMatches(completion: @escaping(Result<MatchesModel?,AuthError>) -> Void)
}

class MatchesAPI: BaseAPI<MatchesAPINetwork>, MatchesAPIProtocol {
    
    func getMatches(completion: @escaping (Result<MatchesModel?, AuthError>) -> Void) {
        fetchData(target: .getMatches, responseClass: MatchesModel.self) { result in
            completion(result)
        }
    }
    
    
}
