//
//  CurrentAppVersionService.swift
//  StoreKitReviewRequest
//
//  Created by Islam Md. Zahirul on 7/2/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

class CurrentAppVersionService: VersionService {
    
    var bundle: Bundle
    var storable: Storeable!
    
    init(bundle: Bundle = Bundle.main, storable: Storeable = UserDefaults.standard) {
        self.bundle = bundle
        self.storable = storable
    }
    
    func getCurrentVersion() -> String? {
        guard let key = kCFBundleVersionKey as String? else {
            fatalError("Version key missing in info.plish")
        }
        return bundle.object(forInfoDictionaryKey: key) as? String
    }
    
    func getOldVerison() -> String? {
        let t: String? = storable.get(forKey: AppKeys.oldVersionKey)
        return t
    }
    
    func save(oldversion: String) {
        storable.save(value: oldversion, forKey: AppKeys.oldVersionKey)
    }
}
