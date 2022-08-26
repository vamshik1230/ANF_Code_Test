//
//  ANFViewCardList.swift
//  ANF Code Test
//
//  Created by Vamshi on 08/25/22.
//

import Foundation

struct ANFViewCardList {
    
    var backgroundImage: String?
    var topDescription: String?
    var title: String?
    var promoMessage: String?
    var bottomDescription: String?
    var contents: [(title: String, target: String)]?
    
    init(_ backgroundImageString: String,
         topDescription: String? = nil,
         title: String? = nil,
         promoMessage: String? = nil,
         bottomDescription: String? = nil,
         contents: [(title: String, target: String)]? = nil) {
        self.backgroundImage = backgroundImageString
        self.topDescription = topDescription
        self.title = title
        self.promoMessage = promoMessage
        self.bottomDescription = bottomDescription
        self.contents = contents
    }
    
}
