//
//  BaseAPI.swift
//  Premier League X
//
//  Created by Hady on 15/10/2023.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {
    
    //var backgroundTaskManager: BackgroundTaskManagerProtocol = BackgroundTaskManager()
    var responseAnalyser: ResponseAnalyserManagerProtocol    = ResponseAnalyserManager()
    
    func fetchData<M: Codable>(target: T, responseClass: M.Type, header:HTTPHeaders, completion:@escaping (Swift.Result<M?,AuthError>) -> Void) {
        
        let method   = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let params   = buildParams(task: target.task)
        print(params)
        
        
        guard Helper.isConnectedToNetwork() else {
            completion(.failure(.noInternet))
            return
        }
        print("HEADER ===== >>>")
        print(header)
        
        
        AF.request(target.baseURL + target.path,
                   method: method,
                   parameters: params.0,
                   encoding: params.1,
                   headers: header).responseData { [weak self] response in
            
            print("😳==URl==\(target.baseURL + target.path) 💁🏻‍♀️==params==\(params)")
            
            //1- Analyse API Response
            if let error = self?.responseAnalyser.analysAPIResponse(response: response) {
                completion(.failure(error))
                return
            }
            
            //2- Get Parsed Model
            guard let responseData = response.data?.convertTo(to: M.self) else {
                completion(.failure(.serverError))
                return
            }
            
            completion(.success(responseData))
            
        }
    }
    
    private func buildParams(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
    
    
}

