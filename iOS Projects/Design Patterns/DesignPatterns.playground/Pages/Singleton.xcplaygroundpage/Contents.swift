//: [Previous](@previous)

/*
 
 // Singleton -> Making sure class has only one instance and it provides a single point of access to it.
 Example - URLSession()
 
 // singleton(i.e. lower case `s`) -> only one instance across the app.
 
 // Example - URLSession.shared
*/


import UIKit

// Singleton
class SingletonClass {
    static let instance = SingletonClass()
    
    private init() {} // class cannot be instantiated from outside.
    
    func printHello() {
        print("Hello from the other side")
    }
    
    var sum = 0
    
    func increaseSum() {
        sum += 1
    }
}

let singletonInstance = SingletonClass.instance
singletonInstance.printHello()

let Singleton = URLSession()
let SingletonTwo = URLSession()
let singleton = URLSession.shared
let singletonTwo = URLSession.shared

print("Singleton: \(Singleton), SingletonTwo: \(SingletonTwo), singleton: \(singleton), singletonTwo: \(singletonTwo)")

// Example:

class SharedInstance {
    
    static let shared = SharedInstance()
    
    var sum = 0
    
    func increaseSum() {
        sum += 1
    }
}

let sharedOne = SharedInstance.shared
sharedOne.increaseSum()

let singetonOne = SingletonClass.instance
singetonOne.increaseSum()

print("sharedOne: \(Unmanaged.passUnretained(sharedOne).toOpaque()), sum: \(sharedOne.sum)")
print("singetonOne: \(Unmanaged.passUnretained(singetonOne).toOpaque()), sum: \(singetonOne.sum)")

let sharedTwo = SharedInstance()
sharedTwo.increaseSum()

let singetonTwo = SingletonClass.instance
singetonTwo.increaseSum()

print("sharedTwo: \(Unmanaged.passUnretained(sharedTwo).toOpaque()), sum: \(sharedTwo.sum)")
print("singetonOne: \(Unmanaged.passUnretained(singetonTwo).toOpaque()), sum: \(singetonTwo.sum)")

// Mutable global state
/*
 class ApiClient {
     static var shared = ApiClient() // Settable
     
     private init() {}
     
     func execute(_ : URLRequest, completion: (Data) -> Void) {}
 }
 
class MockApiClient: ApiClient {
}

print(ApiClient.shared)

ApiClient.instance = MockApiClient()
print(ApiClient.instance)
 */

//: [Next](@next)
