//
//  ANF_Code_TestTests.swift
//  ANF Code TestTests
//


import XCTest
@testable import ANF_Code_Test

class ANFExploreCardTableViewControllerTests: XCTestCase {

    var testInstance: ANFExploreCardTableViewController!
    
    private(set) var presenter: ANFViewPresenterProtocol = {
        let presenter = ANFViewPresenter()
        return presenter
    }()
    
    private var viewModel: ANFViewModelProtocol?
    private var isTableViewReloadData: Bool = false
    private var isErrorFlag = false
    
    override func setUp() {
        testInstance = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as? ANFExploreCardTableViewController
        
        presenter.delegate = self
        viewModel = ANFViewModel(withPresenter: presenter)
    }
    
    func testFetchProductsList() {
        let promise = XCTestExpectation(description: "testFetchCardListAPI")
        viewModel?.fetchProductsList()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10.0) {[weak self] in
            XCTAssertTrue(self?.presenter.cardList.count ?? 0 > 0)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 10.0)
    }
    
    func testNumberOfSectionsShouldBeOne() {
        let numberOfSections = testInstance.numberOfSections(in: testInstance.tableView)
        XCTAssert(numberOfSections == 1, "table view should have 1 section")
    }
    
    func testAvatarImageAPIRequest() {
        let promise = XCTestExpectation(description: "tesDownloadingImageAPI")
        viewModel?.downloadBackgroundImage("http://anf.scene7.com/is/image/anf/anf-US-20160415-app-women-jeans?$anf-ios-fullwidth-3x$", completionHandler: { image, error in
            promise.fulfill()
            if let avatarImage = image {
                XCTAssertNotNil(avatarImage)
            } else {
                XCTFail("Downloading an image was failed due to \(String(describing: error))")
            }
        })
        wait(for: [promise], timeout: 3.0)
    }
}

extension ANFExploreCardTableViewControllerTests: ANFViewControllerDelgate {
    func handleError(_ error: NetworkError) {
        isErrorFlag = true
    }
    
    func didPopulateUI(withData cardList: [ANFViewCardList]) {
        isTableViewReloadData = true
    }
}

