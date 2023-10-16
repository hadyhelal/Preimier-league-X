//
//  BaseViewModel.swift
//  Premier League X
//
//  Created by Hady on 16/10/2023.
//

import Foundation

//class BaseViewModel: BaseViewModelProtocol {
//
//    //@LazyInjected var api: UsersAPIProtocol
//
//    //Encapsulation (publishSubject doesn't need default value we use it on object not value)
//    private var loadingView       = PublishSubject<Bool>()
//    private var apiError          = PublishSubject<AuthError>()
//    private var errorMessage      = PublishSubject<String>()
//    private var successMessage    = PublishSubject<String>()
//    
//    var successMessageObservable: Observable<String> {
//        return successMessage
//    }
//    
//    var networkErrorObservable: Observable<AuthError> {
//        return apiError
//    }
//
//    var errorMessageObservable: Observable<String> {
//        return errorMessage
//    }
//    
//    var loadingViewObservable: Observable<Bool> {
//        return loadingView
//    }
//    
//    func checkApiErrors<M: Decodable>(dataModel: BaseResponse<M>?) -> Bool {
//        switch dataModel?.code {
//        case 410:
//            self.apiError.onNext(.badApiToken)
//            return false
//        case 422:
//            guard let validationM = dataModel?.validationMessage else {
//                return false
//            }
//            var validationMessage = ""
//            for (_, message) in validationM {
//                validationMessage += message.joined(separator: ", ")
//            }
//            self.showErrorMessage(message: validationMessage)
//
//            return false
//        case 404:
//            self.showErrorMessage(message: dataModel?.errorMessage)
//            return false
////        case 450:
////            self.showErrorMessage(message: dataModel?.errorMessage)
////            self.apiError.onNext(.noBalance)
////            return false
//        default:
//            return true
//        }
//    }
//    
//    func showMessage(message: String?) {
//        self.successMessage.onNext(message ?? "")
//    }
//    
//    func showErrorMessage(message: String?) {
//        self.errorMessage.onNext(message ?? "")
//    }
//    
//    func apiError(error: AuthError) {
//        self.apiError.onNext(error)
//    }
//    
//    func loadingView(load: LoadingView) {
//        switch load {
//        case .showLoading:
//            self.loadingView.onNext(true)
//        case .hideLoading:
//            self.loadingView.onNext(false)
//        }
//    }
//    
//}
