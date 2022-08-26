//
//  ANFViewPresenter.swift
//  ANF Code Test
//
//  Created by Vamshi on 08/25/22.
//

import Foundation
import UIKit

protocol ANFViewPresenterProtocol {
    var delegate: ANFViewControllerDelgate? { get set }
    var cardList: [ANFViewCardList] { get set }
    func formatResponseData(_ response: ANFViewResponse)
    func handleErrorData(_ error: NetworkError)
}

class ANFViewPresenter: ANFViewPresenterProtocol {
    weak var delegate: ANFViewControllerDelgate?
    var cardList = [ANFViewCardList]()
    func formatResponseData(_ response: ANFViewResponse) {
        for cardDetail in response {
            var contents = [(title: String, target: String)]()
            if let cardContents = cardDetail.content {
                for element in cardContents {
                    let content = (title: element.title, target: element.target)
                    contents.append(content)
                }
            }
            
            let card = ANFViewCardList(cardDetail.backgroundImage, topDescription: cardDetail.topDescription, title: cardDetail.title, promoMessage: cardDetail.promoMessage, bottomDescription: cardDetail.bottomDescription, contents: contents)
            cardList.append(card)
        }
        
        delegate?.didPopulateUI(withData: cardList)
    }
    
    func handleErrorData(_ error: NetworkError) {
        delegate?.handleError(error)
    }

}

