# weather_forecast
# iOS PROJECT GUIDE

* *Project name*:  ---
* *Language*:  Swift 5
* *Support*:  iOS 13 and later
* *Dependency management*:  CocoaPods
* *Source Control*:  GIT with BitBucket
* *Flow chart*: https://app.diagrams.net/#LiOS_Architect.drawio

### 1. PROBLEM SOLVED
- ✓ The application is a simple iOS application which is written by Swift.
- ✓ The application is able to retrieve the weather information from OpenWeatherMaps API.
- ✓ The application is able to allow user to input the searching term.
- ✓ The application is able to proceed searching with a condition of the search term length must be from 3 characters or above.
- ✓ The application is able to render the searched results as a list of weather item.
- ✓ The application is able to support caching mechanism so as to prevent the app from generating a bunch of API requests.
- ✓ The application is able to manage caching mechanism & lifecycle.
- ✓ The application is able to handle failures.
- ✓ The application is able to support the disability to scale large text for who can't see the text clearly.
- ✓ The application is able to support the disability to read out the text using VoiceOver controls.

### 2. PROJECT ARCHITECTURE
1. Organization:
    * ** App**: Contains all the code relate to UI/UX and logic from UI/UX 
        * Modules
        * Extension
        * DI
        * Others
        * Helper
    * ** Core**:
        * Usecase set
        * API set
        * DataStore set
        * Redux: State, Action, Reducer
        * Models: all the model for nesting app data 
        * Other utilities

2. *Protocol oriented programming*:
    * https://www.raywenderlich.com/148448/introducing-protocol-oriented-programming
    * https://academy.realm.io/posts/appbuilders-natasha-muraschev-practical-protocol-oriented-programming/
    * https://medium.com/ios-os-x-development/how-protocol-oriented-programming-in-swift-saved-my-day-75737a6af022

3. *Redux (ReSwift) for 1 direction data flow and app data store*:
    * Idea: For managing the unified app state and data flow so that we decide to use Redux to conform this demand, it would be fine for code base expandation among team members  and easy to code-base maintaining later on    
    * Concept:
    * https://medium.com/seyhunakyurek/unidirectional-data-flow-architecture-redux-in-swift-6fa2ed5c3c76
    * https://medium.com/monitisemea/using-redux-with-mvvm-on-ios-18212454d676
    * In our architect: Most of Redux action will be call to be executed from the UseCase, other Object like View, ViewModel, ViewController will interact with UseCase and by the way they're also the subscribers and listen the data change.
    
4. *UseCases*:
    * All the logic executions will be defined into usecase. 
    * Application will use usecase to process the logic such as: API call, do the local caching, process the image, photos....
    * Every UseCase normally contain 2 functions: start() and cancel()
    * Every UseCase normally handle all the logic execution behind the scene of application.
    * Initialize a UseCase should specify params: API provider, AppStateStore, DataStore and some parameter for input.
    * After a UseCase finish the logic, new action will be send to Reducer(Redux) and change some state from AppStateStore then App UI can receive the change and do the UI update.
    * Example: in the project normally we has has a module User so we will create a groups of UseCase relate to User module such as: LoginUseCase, RegisterUseCase, GerPorfileUseCase, UpdateProfileUseCase, CacheProfileDataUseCase, UploadProfileImageUseCase ...
    

5. *RxSwift and RxCocoa for UI processing and data binding*:
    * RxSwift will use in the App State, all app state should be wrapped by Variable or BehaviorSubject.
    * https://www.raywenderlich.com/138547/getting-started-with-rxswift-and-rxcocoa
    * RxSwift and RxCocoa will be the main coding style
    * From logic and UI binding RxSwift combine with MVVM pattern will be the best choice
    * Data change from AppState will be handled from ViewModel, ViewModel will emit change to UI via RxSwift and RxCocoa
    * Only use RxSwift and RxCocoa from the App UI, Redux and PromiseKit will be replace from the App Core.


### 3. 3RD PARTY LIBRARY
   1. ReSwift
   2. RxSwift
   3. PromiseKit
   4. RxCocoa
   5. Alamofire
   6. SnapKit
   7. Swinject
   8. IQKeyboardManager
   9. TSwiftHelper
   10. SVProgressHUD
   11. SwiftLocation
