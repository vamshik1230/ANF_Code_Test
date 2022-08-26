//
//  ANFViewModelTests.swift
//  ANF Code TestTests
//
//  Created by Vamshi on 08/26/22.
//

import Foundation
import XCTest
@testable import ANF_Code_Test

extension ANFViewModelTests: ANFViewControllerDelgate {
    func didPopulateUI(withData cardList: [ANFViewCardList]) {
        isSuccess = true
    }
    
    func handleError(_ error: NetworkError) {
        isErrorCalled = true
        self.error = error
    }
}

class ANFViewModelTests: XCTestCase {
    
    var viewModel: ANFViewModelProtocol?
    var presenter: ANFViewPresenterProtocol = {
       let presenter = ANFViewPresenter()
       return presenter
    }()
    fileprivate var isSuccess: Bool = false
    fileprivate var isErrorCalled: Bool = false
    fileprivate var error: NetworkError?
    
    override func setUp() {
        super.setUp()
        presenter.delegate = self
        viewModel = MockANFViewModel(withPresenter: presenter)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAvatarImageAPIRequestFail() {
        let promise = XCTestExpectation(description: "testDownloadingImageAPI")
        viewModel?.downloadBackgroundImage("http://anf.scene7.com/example.png", completionHandler: { image, error in
            promise.fulfill()
            if let avatarImage = image {
                XCTAssertNotNil(avatarImage)
            } else {
                XCTAssertNotNil(error?.errorDescription())
            }
        })
        wait(for: [promise], timeout: 10.0)
    }
    
    
    func testFetchRecordForInvalidEndpoint() {
        let promise = XCTestExpectation(description: "testFetchCardListAPI")
        viewModel?.fetchProductsList()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10.0) {[weak self] in
            XCTAssertNotNil(self?.error?.errorDescription())
            promise.fulfill()
        }
        wait(for: [promise], timeout: 10.0)
    }
}
