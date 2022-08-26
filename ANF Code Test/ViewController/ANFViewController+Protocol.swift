//
//  ANFViewController+Protocol.swift
//  ANF Code Test
//
//  Created by Vamshi on 25/08/22.
//

import Foundation

protocol ANFViewControllerDelgate: AnyObject {
    func didPopulateUI(withData cardList: [ANFViewCardList])
    func handleError(_ error: NetworkError)
}
