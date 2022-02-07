//
//  AppKeys.swift
//  StoreKitReviewRequest
//
//  Created by Islam Md. Zahirul on 7/2/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

enum AppKeys: String {
    case reviewCounterKey
    case oldVersionKey
}

extension AppKeys: StoreableKeys {
    var id: String {
        return self.rawValue
    }
}
