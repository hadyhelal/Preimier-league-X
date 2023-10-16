//
//  TargetType.swift
//  Premier League X
//
//  Created by Hady on 15/10/2023.
//

import Alamofire
import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

enum Task {
    case requestPlain /// A request with no additional data.
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding) /// A requests body set with encoded parameters.
}

protocol TargetType {
    var baseURL: String { get }            /// The target's base `URL`.
    var path: String { get }               /// The path to be appended to `baseURL` to form the full `URL`
    var method: HTTPMethod { get }         /// The HTTP method used in the request.
    var task: Task { get }                 /// The type of HTTP task to be performed.
    var paramter: [String: Any]? { get }   /// Body Paramter
    var headers: HTTPHeaders {get}
}
