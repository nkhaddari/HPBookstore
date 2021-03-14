//
//  APIError.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 04/03/2021.
//

import Foundation

enum APIError: Error {
    case errorCode(Int)
    case decode
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .errorCode(let code):
            return String(format: "error_with_code".localized, "\(code)")
        case .decode:
            return "error_decode".localized
        case .unknown:
            return "error_unknown".localized
        }
    }
}
