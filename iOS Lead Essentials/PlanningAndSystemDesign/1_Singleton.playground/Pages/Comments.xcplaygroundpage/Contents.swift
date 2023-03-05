//: [Previous](@previous)

/*
 Source: https://academy.essentialdeveloper.com/courses/447455/lectures/8528509
 
 Section: Comments
 
 */

import UIKit


// MARK: - About Closures

/*

struct LoggedInUser {
    let name: String
}

typealias LoginClosure = (LoggedInUser) -> Void

class LoginViewController: UIViewController {
    var login: ((LoginClosure) -> Void)?
    
    func didTapLoginButton() {
        login? { user in
            print("the logged in user is \(user.name)")
        }
    }
}

//testing out dependency injection
let loginVC = LoginViewController()
let user = LoggedInUser(name: "randy")
loginVC.login = { completion in
    completion(user)
}
loginVC.didTapLoginButton()

*/

// MARK: - About Singleton, creating multiple instances or Incorrect implementation of a Singleton

/*

class Singleton {
    static let shared: Singleton = Singleton()
    var testMessage: String?
    
    private init() {
        print("Object created.")
    }
}

extension Singleton {
    
    convenience init(message: String) {
        self.init()
        testMessage = message
    }
}

let singleton = Singleton(message: "Checking...")

let singleton1 = Singleton(message: "Testing...")

print(singleton1.testMessage, singleton.testMessage)

 */

// MARK: - Using Protocols instead of closures

/*
class ApiClient {
    static let instance = ApiClient()
}

extension ApiClient {
    func getFollowers(completion:([Followers]) -> Void) {
        completion([Followers(name: "Followers")])
    }
}

// Followers
struct Followers {
    let name:String
}

typealias FollowersClosure = ([Followers]) -> Void
typealias GetFollowersClosure = (FollowersClosure) -> Void

class FollowersViewModel{
    var getFollowers: GetFollowersClosure?
    func loadFollowers() {
        getFollowers? { followers in
            print(followers)
        }
    }
}

let followers = FollowersViewModel()
followers.getFollowers = ApiClient.instance.getFollowers(completion:)
followers.loadFollowers()

*/

// MARK: - async login action

/*
// API Module

class APIClient {
    func login(user: String, password: String, completion: (LoggedUser) -> Void) -> Void {
        // Simulation of an async URLRequest task
        completion(LoggedUser(name: "Luis"))
    }
}

// Login Module

typealias LoginLoader = (String, String, (LoggedUser) -> Void) -> Void

struct LoggedUser {
    var name: String
}

class LoginViewController {
    var loginLoader: LoginLoader?
    
    init(loginLoader: @escaping LoginLoader) {
        self.loginLoader = loginLoader
    }
    
    func onTapLogin() {
        loginLoader?("Luis", "Password") { loggedUser in
            print(loggedUser.name)
        }
    }
}

// Main Module composition

var apiClient = APIClient()
var loginViewController = LoginViewController(loginLoader: apiClient.login)
loginViewController.onTapLogin()

*/

// MARK: - Replacing Singleton with Protocol

/*
protocol ApiServiceRequest {
    func execute(request: URLRequest, completion: (Data) -> Void)
}

// APIModule
final class ApiClient: ApiServiceRequest {
    static let instance = ApiClient()

    func execute(request: URLRequest, completion: (Data) -> Void) {}
}

protocol ApiService {
    var apiClient: ApiServiceRequest { get set }
}

extension ApiService {
    var apiClient: ApiServiceRequest {
        get {
            return ApiClient.instance
        }
        set {
            apiClient = newValue // have to set value to mock during testing
        }
    }
}

// Login Module
protocol LoginClient {
    func login(completion: (User) -> Void)
}

class LoginApiAdapter: LoginClient, ApiService {
    func login(completion: (User) -> Void) {
        apiClient.execute(request: URLRequest(url: URL(string: "")!)) { data in
            completion(User())
        }
    }
}

struct User{}

//TestCase
class MockAPIServiceRequest: ApiServiceRequest {
    func execute(request: URLRequest, completion: (Data) -> Void) {
        completion(Data())
    }
}

var loginAdapter = LoginApiAdapter()
loginAdapter.apiClient = MockAPIServiceRequest()

*/
 
// MARK: - Adapter Pattern

/*

struct LoggedInUser {}
struct FeedItem {}

final class APIClient {
    static let shared = APIClient()
    func execute(_: URLRequest, completion: (Data) -> Void) {
        completion(Data())
    }
}

protocol LoginServiceProtocol {
  func login(completion: (LoggedInUser) -> Void)
}

class LoginClientAdapter : LoginServiceProtocol {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func login(completion: (LoggedInUser) -> Void) {
        
        print("Called LoginClientAdapter")
        
        apiClient.execute(URLRequest(url: URL(string: "http://sample.com")!)) { (data) in
            
            print("Execute request")
            
            // Step 1: convert data to LoggedInUser
            let convertedUser = LoggedInUser() // -> Assume that this loggedInUser is converted from data
            
            // Step 2: update to completion
            completion(convertedUser)
        }
    }
}

class LoginViewModel {
    private let loginProtocol: LoginServiceProtocol
    
    init(loginProtocol: LoginServiceProtocol) {
        self.loginProtocol = loginProtocol
    }
    
    func didTapLoginButton() {
        loginProtocol.login { (user) in
            // show the next step
            print("User is back")
        }
    }
}

let loginVM = LoginViewModel(loginProtocol: LoginClientAdapter(apiClient: APIClient()))
loginVM.didTapLoginButton()

 */

// MARK: - Singleton subclass with dependency injection

/*
struct LoggedInUser {}

class ApiClient {
    static let instance = ApiClient()
    init() {}

    func login(completion: (LoggedInUser) -> Void) {
        print("ApiClient loginCalled")
    }
}

class MockApiClient: ApiClient {
    override func login(completion: (LoggedInUser) -> Void) {
        // override login behavior here for tests
        print("MockApiClient loginCalled")
    }
}

class LoginViewController: UIViewController {
    var api = ApiClient.instance

    func didTapLoginButton() {
        api.login() { user in
            // show next screen
        }
    }
}

let loginController = LoginViewController()
loginController.api = MockApiClient()
loginController.didTapLoginButton()
*/

// MARK: - AnalyticsManager

/*

// Before

class AnalyticsProvider {
    func report(event: AnalyticsEvent, parameters: AnalyticsParameters) {}
}

struct AnalyticsEvent {}

struct AnalyticsParameters {}

class AnalyticsReporter {
    var providers: [AnalyticsProvider]

    init(providers: [AnalyticsProvider]) {
        self.providers = providers
    }

    func report(event: AnalyticsEvent, params: AnalyticsParameters) {
        
        print("Reporting Events")
        
        providers.forEach {
            $0.report(event: event, parameters: params)
        }
    }
}

let analyticsReporter = AnalyticsReporter(providers: [AnalyticsProvider()])
analyticsReporter.report(event: AnalyticsEvent(), params: AnalyticsParameters())

// After

class AnalyticsReporterNew {
    static let instance = AnalyticsReporter(providers: registeredProviders)
        
    static func register(_ provider: AnalyticsProvider) {
        print("Register AnalyticsProvider")
        registeredProviders.append(provider)
    }
    
    private static var registeredProviders = [AnalyticsProvider]()

    private let providers: [AnalyticsProvider]
    
    private init(providers: [AnalyticsProvider]) {
        self.providers = providers
    }
    
    func report(event: AnalyticsEvent, params: AnalyticsParameters) {
        
        print("New Provider Reporting Events: \(providers.count)")
        
        providers.forEach {
            $0.report(event: event, parameters: params)
        }
    }
}

AnalyticsReporterNew.register(AnalyticsProvider())
let analyticsReporterNew = AnalyticsReporterNew.instance

analyticsReporterNew.report(event: AnalyticsEvent(), params: AnalyticsParameters())
*/

// MARK: - lower case singleton v/s Global Mutable Shared State

/*

class LowercaseSingletonExample {
    static let shared = LowercaseSingletonExample()
}

class GlobalMutableStateExample {
    static var shared = GlobalMutableStateExample()
}

 */
 
//: [Next](@next)
