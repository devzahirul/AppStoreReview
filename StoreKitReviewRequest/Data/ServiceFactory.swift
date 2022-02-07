//
//  ServiceFactory.swift
//  StoreKitReviewRequest
//
//  Created by Islam Md. Zahirul on 7/2/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

class DataFactory {
    static func makeStore() -> Storeable {
        return UserDefaults.standard
    }
}

class ServiceFactory {
    
    static func makeReviewStoreService() -> ReviewStoreService {
        return LocalReviewStoreService(store: DataFactory.makeStore())
    }
    
    static func makeVersionService() -> VersionService {
        return CurrentAppVersionService(bundle: Bundle.main)
    }
}
