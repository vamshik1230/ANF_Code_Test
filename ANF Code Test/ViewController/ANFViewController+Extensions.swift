//
//  ANFViewController+Extensions.swift
//  ANF Code Test
//
//  Created by Vamshi on 25/08/22.
//

import Foundation

extension ANFExploreCardTableViewController: ANFViewControllerDelgate {
    func didPopulateUI(withData cardList: [ANFViewCardList]) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
        }
    }
    
    func handleError(_ error: NetworkError) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isHidden = true
        }
    }
}

