//
//  ResponseAnalyserManager.swift
//  Premier League X
//
//  Created by Hady on 15/10/2023.
//


import Alamofire
import UIKit

protocol ResponseAnalyserManagerProtocol {
    func analysAPIResponse(response: AFDataResponse<Data> ) -> AuthError?
    
    func apiCopmletion<M: Decodable>(_ result: Swift.Result<BaseResponse<M>?, AuthError>) -> (Swift.Result<BaseResponse<M>?, AuthError>)

    func checkApiErrors<M: Decodable>(dataModel: BaseResponse<M>?) -> String?

    func handleFormDataResponse<M: Decodable>(result: URLRequest,
                                              responseClass: M.Type, completed: @escaping (Swift.Result<M?, AuthError>) -> Void )
}


class ResponseAnalyserManager: ResponseAnalyserManagerProtocol {
    
    
     func analysAPIResponse(response: AFDataResponse<Data> ) -> AuthError? {
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
            return .invalidData(response.error?.localizedDescription ?? "ERROR")
        }
        
        guard response.value != nil else {
            return .invalidData(response.error?.localizedDescription ?? "ERROR")
        }
        
        return nil
    }
    
    
    func apiCopmletion<M: Decodable>(_ result: Swift.Result<BaseResponse<M>?, AuthError>) -> (Swift.Result<BaseResponse<M>?, AuthError>) {
        
        switch result {
        case .success(let success):
            
            if let error = self.checkApiErrors(dataModel: success) {
                return .failure(.invalidData(error))
            } else {
                return .success(success)
            }
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func apiCopmletionArr<M: Decodable>(_ result: Swift.Result<BaseResponseArrayOfData<M>?, AuthError>) -> (Swift.Result<BaseResponseArrayOfData<M>?, AuthError>) {
        
        switch result {
        case .success(let success):

            if let error = self.checkApiErrors(dataModel: success) {
                return .failure(.invalidData(error))
            } else {
                return .success(success)
            }
            
        case .failure(let error):
            return .failure(error)
        }
    }

    
    func checkApiErrors<M: Decodable>(dataModel: BaseResponse<M>?) -> String? {
        switch dataModel?.code {
        case 422:
            guard let validationM = dataModel?.validationMessage else {
                return nil
            }
            var validationMessage = ""
            for (_, message) in validationM {
                validationMessage += message.joined(separator: ", ")
            }
            return validationMessage
        case 404:
            return dataModel?.errorMessage ?? ""
        default:
            return nil
        }
    }
    
    func checkApiErrors<M>(dataModel: BaseResponseArrayOfData<M>?) -> String? where M : Decodable, M : Encodable {
        switch dataModel?.code {
//        case 410:
//            return rootToLogin()
        case 422:
            guard let validationM = dataModel?.validationMessage else {
                return nil
            }
            var validationMessage = ""
            for (_, message) in validationM {
                validationMessage += message.joined(separator: ", ")
            }
            return validationMessage
        case 404:
            return dataModel?.errorMessage ?? ""
        default:
            return nil
        }
    }
    
    func handleFormDataResponse<M: Decodable>(result: URLRequest,
                                              responseClass: M.Type, completed: @escaping (Swift.Result<M?, AuthError>) -> Void ) {

//        switch result {
//        case .failure(let error):
//            print(error)
//            completed(.failure(.invalidData(error.localizedDescription)))
//
//        case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
//            upload.responseJSON(completionHandler: { (response) in
//                switch response.result {
//                case .success(let value):
//                    print(value)
//                    let responseOBj = try? JSONDecoder().decode(M.self, from: response.data!)
//                    print("MYDATA = \(String(describing: responseOBj))")
//                    completed(.success(responseOBj))
//                case .failure(let error):
//                    print(error)
//                    guard let analysisError = self.analysAPIResponse(response: response) else {
//                        completed(.failure(.invalidData(error.localizedDescription)))
//                        return
//                    }
//                    completed(.failure(analysisError))
//                }
//            })
//
//        }

    }
    
}
