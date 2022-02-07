//
//  ReviewStoreService.swift
//  StoreKitReviewRequest
//
//  Created by Islam Md. Zahirul on 7/2/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

protocol ReviewStoreService {
    func save(review counter: Int)
    func getReviewCounter() -> Int?
}
