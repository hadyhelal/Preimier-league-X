//
//  AuthError.swift
//  Premier League X
//
//  Created by Hady on 15/10/2023.
//
import Foundation

enum AuthError: Error {
    
    case unableToComplete
    case invalidResponse
    case internalServerError
    case invalidData(String)
    case serverError
    case noInternet
    case pageNotFound

    var rawValue: String {
        switch  self {
        case .unableToComplete:
            return "Response could not be decoded because of error:\nThe data couldn’t be read because it is missing"
        case .invalidResponse:
            return "Invalid response has been recieved"
        case .internalServerError:
            return "Internal server error"
        case .invalidData(let str):
            return str
        case .serverError:
            return "Server Error"
        case .noInternet:
            return "No internet, please check your internet connection and try again"
        case .pageNotFound:
            return "Invalid URL path page not found!"
        }
    }
}
