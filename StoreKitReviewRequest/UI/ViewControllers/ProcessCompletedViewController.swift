/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The process completed view controller scene.
*/

import UIKit
import StoreKit

class ProcessCompletedViewController: UIViewController {

    // MARK: View lifecycle

    var askForReviewViewModel = AskForReviewViewModel(askForReviewUsecase: UsecasesFactory.makeAskForReviewUsecase())
    
    /// - Tag: RequestReview
    override func viewDidLoad() {
        super.viewDidLoad()

        askForReviewViewModel.handleShowReviewUI = {
            let twoSecondsFromNow = DispatchTime.now() + 2.0
            DispatchQueue.main.asyncAfter(deadline: twoSecondsFromNow) { [weak self] in
                if self?.navigationController?.topViewController is ProcessCompletedViewController {
                    SKStoreReviewController.requestReview()
                    
                }
            }
        }//
        
        askForReviewViewModel.askForShowAppReviewUI()
        
        
    }

    // MARK: Action methods

    @IBAction func done() {
        navigationController?.popToRootViewController(animated: true)
    }
}
