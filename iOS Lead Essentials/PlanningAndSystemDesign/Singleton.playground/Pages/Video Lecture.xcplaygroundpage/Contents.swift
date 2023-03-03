//: [Previous](@previous)

/*
 Source: https://academy.essentialdeveloper.com/courses/447455/lectures/8528509
 
 Section: Video Lecture
 
 */

import UIKit

// MARK: - Api Module

class ApiClient {
    static let instance = ApiClient()
    
    func execute(_ : URLRequest, completion: (Data) -> Void) {}
}

// MARK: - Main Module

typealias LoginClosure = (LoggedInUser) -> Void

extension ApiClient {
    func login(completion: LoginClosure) {}
}

typealias FeedItemsClosure = (FeedItem) -> Void

extension ApiClient {
    func loadFeed(completion: FeedItemsClosure) {}
}

// MARK: - Login Module

struct LoggedInUser {
    let name: String
}

class LoginViewController: UIViewController {
    var login: ((LoginClosure) -> Void)?
    
    func didTapLogin() {
        login? { user in
            // show feed screen
            print("Hello \(user)")
        }
    }
}

// MARK: - Feed Module

struct FeedItem {
    let type: String
}

class FeedViewController: UIViewController {
    var loadFeed: ((FeedItemsClosure) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFeedItems()
    }
    
    func loadFeedItems() {
        loadFeed? { feedItem in
            // Show Feed
            
            print("User \(feedItem.type)")
        }
    }
}

let loginVC = LoginViewController()
let user = LoggedInUser(name: "randy")
loginVC.login = { completion in
    completion(user)
}
loginVC.didTapLogin()

let feedVC = FeedViewController()
let feed = FeedItem(type: "Liked a photo")
feedVC.loadFeed = { completion in
    completion(feed)
}
feedVC.loadFeedItems()



//: [Next](@next)
