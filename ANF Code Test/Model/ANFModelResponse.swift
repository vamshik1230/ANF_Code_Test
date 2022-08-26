//
//  ANFModelResponse.swift
//  ANF Code Test
//
//  Created by Vamshi on 08/25/22.
//

import Foundation

struct ANFViewListResponse: Codable {
    let title: String
    let backgroundImage: String
    let content: [ANFViewContent]?
    let promoMessage: String?
    let topDescription: String?
    let bottomDescription: String?
}

// MARK: - Content
struct ANFViewContent: Codable {
    let target: String
    let title: String
    let elementType: String?
}

typealias ANFViewResponse = [ANFViewListResponse]
