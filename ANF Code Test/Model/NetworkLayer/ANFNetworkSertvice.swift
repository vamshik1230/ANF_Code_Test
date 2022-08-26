//
//  ANFNetworkSertvice.swift
//  ANF Code Test
//
//  Created by Vamshi on 08/25/22.
//

import Foundation
import UIKit

protocol ANFNetworkServiceProtocol {
    func fetchCardListAPI(request: URLRequest, completion: @escaping (Result<ANFViewResponse, NetworkError>) -> Void)
    func downloadImageAPI(request: URLRequest, completion: @escaping (Result<UIImage?, NetworkError>) -> Void)
}

struct ANFNetworkService: ANFNetworkServiceProtocol {
    private let session: URLSession
   
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchCardListAPI(request: URLRequest, completion: @escaping (Result<ANFViewResponse, NetworkError>) -> Void) {
        self.session.dataTask(with: request) { (rawData, response, error) in
            if let aError = error {
                print(aError)
            } else {
                if let validData = rawData {
                    do {
                        let reponseList = try JSONDecoder().decode(ANFViewResponse.self, from: validData)
                        completion(.success(reponseList))
                    } catch {
                        print("Error == \(error)")
                        completion(.failure(.parse))
                    }
                }
            }
        }.resume()
    }
    
    func downloadImageAPI(request: URLRequest, completion: @escaping (Result<UIImage?, NetworkError>) -> Void) {
        self.session.dataTask(with: request) { (rawData, response, error) in
            if let _ = error {
                completion(.failure(.invalidImage))
            } else {
                if let validData = rawData {
                    let image = UIImage(data: validData)
                    if image == nil {
                        completion(.failure(.invalidImage))
                    } else {
                        completion(.success(image))
                    }
                } else {
                    completion(.failure(.parse))
                }
            }
        }.resume()
    }
}
