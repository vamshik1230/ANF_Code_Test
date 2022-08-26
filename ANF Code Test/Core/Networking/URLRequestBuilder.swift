//
//  URLRequestBuilder.swift
//  ANF Code Test
//
//  Created by Vamshi on 08/25/22.
//

import Foundation

struct Constants {
    static let BaseURL = "https://www.abercrombie.com/anf/nativeapp/qa"
    struct List {
        static let Endpoint = "/codetest/codeTest_exploreData.json"
        static let ImageEndpoint = ""
    }
}

enum HTTPMethod: String {
    case post   = "POST"
    case put    = "PUT"
    case get    = "GET"
    case delete = "DELETE"
    case patch  = "PATCH"
}

class URLRequestBuilder {
    typealias Header = [String: String]
    typealias HTTPBody = [String: Any]
    private var baseURL: URL
    private var path: String
    private var method: HTTPMethod = .get
    private var headers: Header = [:]
    private var httpBody: HTTPBody = [:]
    private var parameters: [URLQueryItem] = []
    
    init(baseURL: URL, path: String) {
        self.baseURL = baseURL
        self.path = path
    }
    
    @discardableResult func set(method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    @discardableResult func set(headers: Header) -> Self {
        self.headers = headers
        return self
    }
    
    @discardableResult func set(parameters: [URLQueryItem]) -> Self {
        self.parameters = parameters
        return self
    }
}

extension URLRequestBuilder {
    func build() -> URLRequest? {
        let completePath = path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
        var urlComponents = URLComponents(url: completePath, resolvingAgainstBaseURL: true)
        let queryItems = urlComponents?.queryItems
        urlComponents?.queryItems = parameters.isEmpty ? queryItems : parameters
        guard let requestUrl = urlComponents?.url else {
            return nil
        }
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = method.rawValue
        headers.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return urlRequest
    }
}
