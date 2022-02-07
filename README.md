# Requesting App Store Reviews Using Clean Architecture MVVM & Testable


## Overview

Apple App Store Review Request was in clean MVC code. This code in refrectored that MVC to MVVM & clean Architecture 
The context is

* The review prompt must not have been shown for a version of the app bundle that matches the current bundle version. This ensures that the user is not asked to review the same version of your app multiple times.
* The multistep process mentioned above must be successfully completed at least four times. This number is arbitrary and you should choose something that fits well with how many times the user is likely to complete a process in your app.
* Finally, the user must pause on the "Process Completed" scene for a few seconds. This requirement limits the possibility of the prompt interrupting the user if they are about to move to a different task in your application straight away.

## UI Layer 

Now ProcessCompletedViewController is clean 
``` swift
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
```
AskForReviewViewModel code 

``` swift
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
```

## Domain Layer 
AskForReviewUsecase 
``` swift
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

```
ServericesProtocols / Repository

``` swift
protocol VersionService {
    func getCurrentVersion() -> String?
    func getOldVerison() -> String?
    func save(oldversion: String)
}

protocol ReviewStoreService {
    func save(review counter: Int)
    func getReviewCounter() -> Int?
}
```
## Data Layer
```swift
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
```


