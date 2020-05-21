# Data Binding: Introduction

Below, I explain 4 techniques you can use to implement Data Binding in your MVVM project. All techniques in the post below have their respective views and viewModels in this module of the project. You can also read the whole post on [Medium](https://medium.com/flawless-app-stories/data-binding-in-mvvm-on-ios-714eb15e3913).

## Definitions

Data Binding is simply the process that establishes a connection between the app UI (View Controller) and the data (Not Model, But View Model) it displays. There are different ways of data binding so we’ll look at a couple. Please note, that Data Binding does not apply only to MVVM but to other patterns too.

## Technique 1: Observables
This appears to be the easiest and most commonly used. Libraries like [Bond](https://github.com/DeclarativeHub/Bond) allow you to bind easily but we’re going to create our own Helper class called Observable. It’s initialized with the value we want to observe (or pass around), and we have a function bind that does the binding and gets us our value. listener is our closure called when the value is set.

```
class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
```

Let’s move to our ViewModel. Before we focus on our numbered lines, all we’re trying to do here is get our ViewModel to implement the Protocol we created for it, then fetch data (Employees) from our APIManager class.

```
protocol ObservableViewModelProtocol {
    func fetchEmployees()
    func setError(_ message: String)
    var employees: Observable<[Employee]> { get  set } //1
    var errorMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
}


class ObservableViewModel: ObservableViewModelProtocol {
    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<Bool> = Observable(false)

    var apiManager: APIManager?
    var employees: Observable<[Employee]> = Observable([]) //2
    init(manager: APIManager = APIManager()) {
        self.apiManager = manager
    }

    func setAPIManager(manager: APIManager) {
        self.apiManager = manager
    }

    func fetchEmployees() {
        self.apiManager!.getEmployees { (result: DataResponse<EmployeesResponse, AFError>) in
            switch result.result {
            case .success(let response):
                if response.status == "success" {
                    self.employees = Observable(response.data) //3
                    return
                }
                self.setError(BaseNetworkManager().getErrorMessage(response: result))
            case .failure:
                self.setError(BaseNetworkManager().getErrorMessage(response: result))
            }
        }
    }

    func setError(_ message: String) {
        self.errorMessage = Observable(message)
        self.error = Observable(true)
    }

}
```

//1 is how we declare our Observable on our Employees array in our protocol. //2 is how we implement //1 in our ViewModel. And finally //3 is we set/add data to our Observable. We can now go ahead to bind it to viewDidLoad in our View Controller.

```
 /********* Binding to array in viewDidLoad */
  viewModel.employees.bind { (_) in
    self.showTableView()
  }
 /********************************/
```

Tadaa. Anytime employees are added or set, self.showTableView will get called in our Controller.

## Technique 2: Event Bus / Notification Center

EventBuses are more popular on Android. On iOS, they are well-structured wrappers for the NotificationCenter. You can go for César Ferreira’s [SwiftEventBus](https://github.com/cesarferreira/SwiftEventBus) or [this refactored version](https://gist.github.com/FitzAfful/2af698e9f4ce4f2b2a5fac5d69688080) (which I use).

  1. Create an Event that will be pushed by the EventBus to all subscribers. It usually contains the stuff we want to pass around. So EmployeesEvent contains our employees, error Boolean and errorMessage String.

```
class EmployeesEvent: NSObject {
    var error: Bool
    var errorMessage: String?
    var employees: [Employee]?

    init(error: Bool, errorMessage: String? = nil, employees: [Employee]? = nil) {
        self.error = error
        self.errorMessage = errorMessage
        self.employees = employees
    }
}
```

  2. Publish (Or Post) the Event from the ViewModel using the EventBus.

```
func callEvent() {
    //Post Event (Publish Event)
    EventBus.post("fetchEmployees", sender: EmployeesEvent(error: error, errorMessage: errorMessage, employees: employees))
}

```

  3. Subscribe to Event from View Controller. So setupEventBusSubscriber is called from our viewDidLoad.

```
func setupEventBusSubscriber() {
    _ = EventBus.onMainThread(self, name: "fetchEmployees") { result in
        if let event = result!.object as? EmployeesEvent {
            if event.employees != nil {
                self.showTableView()
            } else if let message = event.errorMessage {
                self.showAlert(title: "Error", message: message)
            }
        }
    }
}
```
Contents of our EventBus’ onMainThread implementation run every time callEvent is called in our ViewModel.

## Technique 3: FRP Technique (ReactiveCocoa / RxSwift):
The Functional / Reactive Programming approach. You can either go with [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) or [RxSwift](https://github.com/ReactiveX/RxSwift). RayWenderlich does a good analysis of both [here](https://www.raywenderlich.com/126522/reactivecocoa-vs-rxswift), you might want to check out. But for the sake of this project, I’ll use RxSwift.

Similar to our Observable technique, our ViewModel looks like this:

```
import Foundation
import Alamofire
import RxSwift
import RxCocoa

class RxSwiftViewModel {

    private let disposeBag = DisposeBag()
    private let _employees = BehaviorRelay<[Employee]>(value: [])
    private let _error = BehaviorRelay<Bool>(value: false)
    private let _errorMessage = BehaviorRelay<String?>(value: nil)

    var employees: Driver<[Employee]> {
       return _employees.asDriver()
    }

    var hasError: Bool {
       return _error.value
    }

    var errorMessage: Driver<String?> {
       return _errorMessage.asDriver()
    }

    var numberOfEmployees: Int {
       return _employees.value.count
    }

    var apiManager: APIManager?

    init(manager: APIManager = APIManager()) {
        self.apiManager = manager
    }

    func setAPIManager(manager: APIManager) {
        self.apiManager = manager
    }

    func fetchEmployees() {
        self.apiManager!.getEmployees { (result: DataResponse<EmployeesResponse, AFError>) in
            switch result.result {
            case .success(let response):
                if response.status == "success" {
                    self._error.accept(false)
                    self._errorMessage.accept(nil)
                    self._employees.accept(response.data)
                    return
                }
                self.setError(BaseNetworkManager().getErrorMessage(response: result))
            case .failure:
                self.setError(BaseNetworkManager().getErrorMessage(response: result))
            }
        }
    }

    func setError(_ message: String) {
        self._error.accept(true)
        self._errorMessage.accept(message)
    }

    func modelForIndex(at index: Int) -> Employee? {
        guard index < _employees.value.count else {
            return nil
        }
        return _employees.value[index]
    }
}
```

The employeesproperty like the error and errorMessage variables are computed variables that return Driver (An Observable that our controls in our Views will bind to) from each of their respective private properties. (Dont forget to import both RxSwift and RxCocoa — You can add their dependencies using Cocoapods, Carthage or Swift Package Manager).

And Controller:

```
import RxSwift
import RxCocoa

class RxSwiftController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var emptyView: UIView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    	let disposeBag = DisposeBag()

    	lazy var viewModel: RxSwiftViewModel = {
        	let viewModel = RxSwiftViewModel()
       		return viewModel
    	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		showLoader()
		setupTableView()
        	setupBindings()
	}

    	func setupBindings() {
        	viewModel.employees.drive(onNext: {[unowned self] (_) in
            		self.showTableView()
        	}).disposed(by: disposeBag)

        	viewModel.errorMessage.drive(onNext: { (_message) in
            		if let message = _message {
                	self.showAlert(title: "Error", message: message)
            	}
        	}).disposed(by: disposeBag)
    	}

    //... other delegate methods go here
}
```

In the Controller, we have our DisposeBag, a RxSwift object that aids in releasing any references they may have to any observables they’re observing. setupBindings method is to observe the employees property from the View Model. Whenever employees is updated, showTableView method is called to reload the list.




## Technique 4: Combine
The Combine framework (added in Swift 5.1) provides a unified publish-and-subscribe API for channeling and processing asynchronous signals.

1. We make a publisher (in our ViewModel): To do that, we import Combine and let our ViewModel inherit from Combine’s ObservableOject. Our employees array which we want to observe will then be wrapped with a @Published property wrapper. This publisher emits the current value whenever the property (employees) changes.

```
import Foundation
import Alamofire
import Combine

class CombineViewModel: ObservableObject {

    var apiManager: APIManager?
    @Published var employees: [Employee] = [] //1
    init(manager: APIManager = APIManager()) {
        self.apiManager = manager
    }

    func setAPIManager(manager: APIManager) {
        self.apiManager = manager
    }

    func fetchEmployees() {
        self.apiManager!.getEmployees { (result: DataResponse<EmployeesResponse, AFError>) in
            switch result.result {
            case .success(let response):
                if response.status == "success" {
                    self.employees = response.data
                }
            case .failure:
                print("Failure")
            }
        }
    }

}
```

2. Then, attach a subscriber to the publisher (in our View Controller): In bindViewModel, we subscribe to $employees using one of Combine’s default subscriber keywords — sink, and it allows us to update our view only when specific published properties change.
```
import UIKit
import Combine

class CombineController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var emptyView: UIView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    	lazy var viewModel: CombineViewModel = {
        	let viewModel = CombineViewModel()
        	return viewModel
    	}()

    	private var cancellables: Set<AnyCancellable> = []

	override func viewDidLoad() {
		super.viewDidLoad()
		showLoader()
		setupTableView()
        	bindViewModel()
	}

    	private func bindViewModel() {
        	viewModel.$employees.sink { [weak self] _ in
            		self?.showTableView()
        	}.store(in: &cancellables)
    	}
    
  	//... Other delegate methods
  
}
```

And We store the subscriber in an instance property so that it is retained (and so that it will be released automatically at the latest when the surrounding instance goes out of existence) or canceled by ourselves.

- [Full Post on Medium](https://medium.com/flawless-app-stories/data-binding-in-mvvm-on-ios-714eb15e3913)
