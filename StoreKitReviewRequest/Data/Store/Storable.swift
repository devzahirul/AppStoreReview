//
//  Storable.swift
//  StoreKitReviewRequest
//
//  Created by Islam Md. Zahirul on 7/2/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

protocol Storeable {
    func save<T>(value: T, forKey: StoreableKeys)
    func get<T>(forKey: StoreableKeys) -> T?
}



extension UserDefaults: Storeable {
    func save<T>(value: T, forKey: StoreableKeys) {
        setValue(value, forKey: forKey.id)
    }
    
    func get<T>(forKey: StoreableKeys) -> T? {
        return value(forKey: forKey.id) as? T
    }
}

protocol StoreableKeys {
    var id: String { get }
}


