//
//  LocalReviewStoreService.swift
//  StoreKitReviewRequest
//
//  Created by Islam Md. Zahirul on 7/2/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation


class LocalReviewStoreService: ReviewStoreService {

    var storable: Storeable
    
    init(store: Storeable = UserDefaults.standard) {
        self.storable = store
    }
    
    func save(review counter: Int) {
        storable.save(value: counter, forKey: AppKeys.reviewCounterKey)
    }
    
    func getReviewCounter() -> Int? {
        return storable.get(forKey: AppKeys.reviewCounterKey)
    }
}

