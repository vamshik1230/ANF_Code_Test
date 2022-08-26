//
//  ANFViewModel.swift
//  ANF Code Test
//
//  Created by Vamshi on 08/25/22.
//

import Foundation
import UIKit


struct ANFViewModel: ANFViewModelProtocol {
    private let dataManager = ANFDataServiceManager()
    private var presenter: ANFViewPresenterProtocol?
    private var dataService: ANFDataServiceProtocol
    
    init(withPresenter presenter: ANFViewPresenterProtocol) {
        self.presenter = presenter
        self.dataService = dataManager.dataService
    }
    
    func fetchProductsList() {
        self.dataService.fetchCardList { result in
            switch result {
            case .success(let response):
                self.presenter?.formatResponseData(response)
            case .failure(let error):
                self.presenter?.handleErrorData(error)
            }
        }
    }
    
    func downloadBackgroundImage(_ url: String, completionHandler: @escaping (UIImage?, NetworkError?) -> Void) {
        self.dataService.downloadImage(url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completionHandler(response, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
            }
        }
    }
}

