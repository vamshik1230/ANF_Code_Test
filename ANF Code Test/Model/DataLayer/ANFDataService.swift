//
//  ANFDataService.swift
//  ANF Code Test
//
//  Created by Vamshi on 08/26/22.
//

import Foundation
import UIKit

class ANFDataService: ANFDataServiceProtocol {
    
    private var networkService: ANFNetworkServiceProtocol!
    required init(networkService: ANFNetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchCardList(completion: @escaping (Result<ANFViewResponse, NetworkError>) -> Void) {
        guard let baseURL = URL(string: Constants.BaseURL) else { return }
        guard let urlRequest = URLRequestBuilder(baseURL: baseURL, path: Constants.List.Endpoint)
                         .set(method: HTTPMethod.get)
                         .set(headers: ["Content-Type": "application/json"])
                        .build() else {
                completion(.failure(NetworkError.badRequest))
                return
        }
        self.networkService.fetchCardListAPI(request: urlRequest, completion: completion)
    }
    
    func downloadImage(url urlString: String, completion: @escaping (Result<UIImage?, NetworkError>) -> Void) {
        guard let baseURL = URL(string: urlString) else { return }
        guard let urlRequest = URLRequestBuilder(baseURL: baseURL, path: Constants.List.ImageEndpoint)
                         .set(method: HTTPMethod.get)
                         .set(headers: ["Content-Type": "application/json"])
                        .build() else {
                completion(.failure(NetworkError.badRequest))
                return
        }
        self.networkService.downloadImageAPI(request: urlRequest, completion: completion)
    }
}
