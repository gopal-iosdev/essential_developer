//: [Previous](@previous)

/*
 Source: https://academy.essentialdeveloper.com/courses/447455/lectures/8528509
 
 Section: Video Lecture
 
 */

import UIKit

// MARK: - Api Module

typealias ApiResponse = (Data) -> Void

final class APIClient {
    static let shared = APIClient()
    func execute(_: URLRequest, completion: ApiResponse) {
        completion(Data())
    }
}

struct LoggedInUser {
    let name: String
}

typealias LoginClosure = (LoggedInUser) -> Void

protocol LoginServiceProtocol {
    func login(completion: LoginClosure)
}

class LoginApiAdapter: LoginServiceProtocol {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func login(completion: LoginClosure) {
        
        print("Called LoginClientAdapter")
        
        apiClient.execute(URLRequest(url: URL(string: "http://sample.com")!)) { (data) in
            
            print("Execute request")
            
            // Step 1: convert data to LoggedInUser
            let convertedUser = LoggedInUser(name: "User 1") // -> Assume that this loggedInUser is converted from data
            
            // Step 2: update to completion
            completion(convertedUser)
        }
    }
}

struct FeedItem {
    let type: String
}

typealias FeedItemsClosure = (FeedItem) -> Void

protocol FeedServiceProtocol {
    func loadFeed(completion: FeedItemsClosure)
}

class FeedApiAdapter: FeedServiceProtocol {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func loadFeed(completion: FeedItemsClosure) {
        
        print("Called LoginClientAdapter")
        
        apiClient.execute(URLRequest(url: URL(string: "http://sample.com")!)) { (data) in
            
            print("Execute request")
            
            // Step 1: convert data to FeedItem
            let convertedFeedIttem = FeedItem(type: "Feed 1") // -> Assume that this feed item is converted from data
            
            // Step 2: update to completion
            completion(convertedFeedIttem)
        }
    }
}

// MARK: - Login Module

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

class LoginViewController: UIViewController {
    
    let loginViewModel: LoginViewModel
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTapLogin() {
        loginViewModel.didTapLoginButton()
    }
}

// MARK: - Feed Module

class FeedViewModel {
    private let feedProtocol: FeedServiceProtocol
    
    init(feedProtocol: FeedServiceProtocol) {
        self.feedProtocol = feedProtocol
    }
    
    func fetchFeedItems() {
        feedProtocol.loadFeed { (feedItem) in
            print("Fetched feed items")
        }
    }
}

class FeedViewController: UIViewController {
    let feedViewModel: FeedViewModel
    
    init(feedViewModel: FeedViewModel) {
        self.feedViewModel = feedViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFeedItems()
    }
    
    func loadFeedItems() {
        feedViewModel.fetchFeedItems()
    }
}

// MARK: - Testing

let loginAdapter = LoginApiAdapter(apiClient: APIClient())
let loginVM = LoginViewModel(loginProtocol: loginAdapter)
let loginVC = LoginViewController(loginViewModel: loginVM)
loginVC.didTapLogin()

let feedAdapter = FeedApiAdapter(apiClient: APIClient())
let feedVM = FeedViewModel(feedProtocol: feedAdapter)
let feedVC = FeedViewController(feedViewModel: feedVM)
feedVC.loadFeedItems()


//: [Next](@next)
