//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {
    
    struct Constants {
        static let cellIdentifier = "ANFTableViewCellIdentifer"
        static let nibName = "ANFTableViewCell"
    }

    private(set) var presenter: ANFViewPresenterProtocol = {
        let presenter = ANFViewPresenter()
        return presenter
    }()
    
    private var viewModel: ANFViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: Constants.nibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        presenter.delegate = self
        viewModel = ANFViewModel(withPresenter: presenter)
        viewModel?.fetchProductsList()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter.cardList.count > 0 {
            return presenter.cardList.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? ANFTableViewCell else { return UITableViewCell() }
        
        let cardData = presenter.cardList[indexPath.row]
        cell.configureUI(cardData.backgroundImage, topDescription: cardData.topDescription, title: cardData.title, promoMsg: cardData.promoMessage, bottomDescription: cardData.bottomDescription, contents: cardData.contents)
        
        if let resourceURL = cardData.backgroundImage {
            viewModel?.downloadBackgroundImage(resourceURL, completionHandler: { image, error in
                if let resource = image {
                    cell.configureImage(resource)
                } else if let placeholder = UIImage(named: "anf-US-20160518-app-men-tees") {
                    cell.configureImage(placeholder)
                }
            })
        }
        
        cell.shopMenButtoAction = {[weak self] in
            guard let target = cardData.contents?.first?.target, let targetURL = URL(string: target),  UIApplication.shared.canOpenURL(targetURL) else {
                return
            }
            
            self?.openAppURL(targetURL)
        }
        
        cell.shopWomenButtonAction = {[weak self] in
            
            guard let contents = cardData.contents else {
                return
            }
            
            guard contents.count > 1,  let targetURL = URL(string: contents[1].target) else {
                if let targetURL = URL(string: contents[0].target) {
                    self?.openAppURL(targetURL)
                }
                return
            }
            
            self?.openAppURL(targetURL)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    private func openAppURL(_ targetURL: URL) {
        UIApplication.shared.open(targetURL, options: [:], completionHandler: nil)
    }
}
