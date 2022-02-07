//
//  VersionService.swift
//  StoreKitReviewRequest
//
//  Created by Islam Md. Zahirul on 7/2/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

protocol VersionService {
    func getCurrentVersion() -> String?
    func getOldVerison() -> String?
    func save(oldversion: String)
}
