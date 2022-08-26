//
//  NetworkErrorConstants.swift
//  ANF Code Test
//
//  Created by Vamshi on 08/25/22.
//

import Foundation

enum NetworkError: Error {
    case fetch
    case parse
    case badRequest
    case nointernetConnection
    case invalidImage
    func errorDescription() -> String {
        switch self {
        case .fetch:
            return "Failed in fetching the records."
        case .parse:
            return "Failed in fetching the records."
        case .badRequest:
            return "Bad request"
        case .nointernetConnection:
            return "No Internet Connection"
        case .invalidImage:
            return "Invalid image"
        }
    }
}
