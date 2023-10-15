//
//  BaseResponse.swift
//  Car
//
//  Created by hady helal on 03/06/2023.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let data: T?
    let status: Bool?
    let code: Int?
    let successMessage: String?
    let errorMessage, apiToken: String?
    let validationMessage: [String: [String]]?

    enum CodingKeys: String, CodingKey {
        case data, status, code, successMessage, errorMessage, validationMessage
        case apiToken = "api_token"
    }
}

struct BaseResponseArrayOfData<T: Codable>: Codable {
    let data: [T]?
    let status: Bool?
    let code: Int?
    let successMessage: String?
    let errorMessage, apiToken: String?
    let validationMessage: [String: [String]]?

    enum CodingKeys: String, CodingKey {
        case data, status, code, successMessage, errorMessage, validationMessage
        case apiToken = "api_token"
    }
}
