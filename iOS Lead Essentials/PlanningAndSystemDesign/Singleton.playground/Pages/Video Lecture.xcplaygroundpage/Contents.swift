//: [Previous](@previous)

/*
 Source: https://academy.essentialdeveloper.com/courses/447455/lectures/8528509
 
 Section: Video Lecture
 
 */

import UIKit

// MARK: -  Singleton

struct LoggedInUser {}

struct FeedItem {}

class ApiClient {
    static let instance = ApiClient()
    
    func login(completion: (LoggedInUser) -> Void) {}
    func loadFeed(completion: (FeedItem) -> Void) {}
}

let client = ApiClient.instance

// MARK: - singleton

let urlSession = URLSession.shared

let urlSessionTwo = URLSession()

// MARK: - Testing Singleton

class LoginViewController: UIViewController {
    var api = ApiClient.instance
    
    func didTapLogin() {
        api.login { user in
            // show feed screen
        }
    }
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
