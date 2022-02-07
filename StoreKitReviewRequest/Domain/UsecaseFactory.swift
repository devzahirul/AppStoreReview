//
//  UsecaseFactory.swift
//  StoreKitReviewRequest
//
//  Created by Islam Md. Zahirul on 7/2/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation


class UsecasesFactory {
    static func makeAskForReviewUsecase() -> AskForReviewUsecase {
        return AskForReviewUsecase(reviewStoreService: ServiceFactory.makeReviewStoreService(), versionService: ServiceFactory.makeVersionService())
    }
}
