//: [Previous](@previous)

/*
 Source: https://academy.essentialdeveloper.com/courses/447455/lectures/8528509
 
 Section: Video Lecture
 
 */

import UIKit

// MARK: - singleton

let urlSession = URLSession.shared

let urlSessionTwo = URLSession()

// MARK: - Api Module

class ApiClient {
    static let instance = ApiClient()
    
    func execute(_ : URLRequest, completion: (Data) -> Void) {}
}

// MARK: - Login Module

struct LoggedInUser {}

extension ApiClient {
    func login(completion: (LoggedInUser) -> Void) {}
}

class LoginViewController: UIViewController {
    var api = ApiClient.instance
    
    func didTapLogin() {
        api.login { user in
            // show feed screen
        }
    }
}

// MARK: - Feed Module

struct FeedItem {}

extension ApiClient {
    func loadFeed(completion: (FeedItem) -> Void) {}
}

class FeedViewController: UIViewController {
    var api = ApiClient.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.loadFeed { feedItems in
            // Show Feed
        }
    }
}


//: [Next](@next)
