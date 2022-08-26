//
//  MockDataManager.swift
//  ANF Code TestTests
//
//  Created by Vamshi on 08/26/22.
//

import Foundation
@testable import ANF_Code_Test

final class MockANFDataServiceManager {
    private(set) lazy var dataService: ANFDataServiceProtocol = {
        let networkService = ANFNetworkService(session: URLSession.shared)
        let service: ANFDataServiceProtocol = MockDataService(networkService: networkService)
        return service
    }()
}
