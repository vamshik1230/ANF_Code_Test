//
//  ANFViewModelProtocol.swift
//  ANF Code Test
//
//  Created by Vamshi on 08/25/22.
//

import Foundation
import UIKit

protocol ANFViewModelProtocol {
    mutating func fetchProductsList()
    func downloadBackgroundImage(_ url: String, completionHandler: @escaping (UIImage?, NetworkError?) -> Void)
}
