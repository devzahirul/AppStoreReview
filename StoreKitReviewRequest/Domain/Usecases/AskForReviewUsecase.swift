//
//  AskForReviewUsecase.swift
//  StoreKitReviewRequest
//
//  Created by Islam Md. Zahirul on 7/2/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation


protocol AskForReviewUsecaseOutput: AnyObject {
    func didShowAskForReview()
}



class AskForReviewUsecase {
    weak var delegate: AskForReviewUsecaseOutput?
    
    var reviewStoreService: ReviewStoreService!
    var versionSevice: VersionService!
    
    init(reviewStoreService: ReviewStoreService, versionService: VersionService) {
        self.reviewStoreService = reviewStoreService
        self.versionSevice = versionService
    }
    
    func reset() {
        versionSevice.save(oldversion: "")
        reviewStoreService.save(review: 0)
    }
    
    func requestForShowAppReview() {
        
        if let counter = reviewStoreService.getReviewCounter() {
            print("Current counter \(counter)")
            if counter >= 4 {
                if let version = versionSevice.getCurrentVersion() {
                    
                    if let oldVersion = versionSevice.getOldVerison() {
                        if oldVersion != version {
                            //Show
                           showReviewNow(version: version)
                        }
                        
                    } else {
                        showReviewNow(version: version)
                    }
                    
                }
            } else {
                updateCounter(counter: counter + 1)
            }
        } else {
            updateCounter(counter: 1)
        }
    }
    
    
    private func updateCounter(counter: Int) {
        reviewStoreService.save(review: counter)
    }
    
    private func showReviewNow(version: String) {
        delegate?.didShowAskForReview()
        reviewStoreService.save(review: 0)
        versionSevice.save(oldversion: version)
    }
}




