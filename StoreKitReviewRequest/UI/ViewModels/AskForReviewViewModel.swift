//
//  AskForReviewViewModel.swift
//  StoreKitReviewRequest
//
//  Created by Islam Md. Zahirul on 7/2/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

class AskForReviewViewModel {
    var handleShowReviewUI: (() -> Void)?
    
    var askForReviewUsecase: AskForReviewUsecase!
    
    init(askForReviewUsecase: AskForReviewUsecase) {
        self.askForReviewUsecase = askForReviewUsecase
        askForReviewUsecase.delegate = self
    }
    
    func add(delegate: AskForReviewUsecaseOutput) {
        self.askForReviewUsecase.delegate = delegate
    }
    
    func askForShowAppReviewUI() {
        self.askForReviewUsecase.requestForShowAppReview()
    }
    
}

extension AskForReviewViewModel: AskForReviewUsecaseOutput {
    func didShowAskForReview() {
        handleShowReviewUI?()
    }
}
