//
//  DataServiceManager.swift
//  ANF Code Test
//
//  Created by Vamshi on 08/25/22.
//

import Foundation
import UIKit

protocol ANFDataServiceProtocol {
    init(networkService: ANFNetworkServiceProtocol)
    func fetchCardList(completion: @escaping (Result<ANFViewResponse, NetworkError>) -> Void)
    func downloadImage(url urlString: String, completion: @escaping (Result<UIImage?, NetworkError>) -> Void)
}

final class ANFDataServiceManager {
    private(set) lazy var dataService: ANFDataServiceProtocol = {
        let networkService = ANFNetworkService(session: URLSession.shared)
        let service: ANFDataServiceProtocol = ANFDataService(networkService: networkService)
        return service
    }()
}

