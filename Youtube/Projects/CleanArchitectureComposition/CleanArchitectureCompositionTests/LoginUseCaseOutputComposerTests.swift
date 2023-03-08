//
//  LoginUseCaseOutputComposerTests.swift
//  CleanArchitectureCompositionTests
//
//  Created by Gopal Gurram on 3/7/23.
//

import XCTest
@testable import CleanArchitectureComposition

final class LoginUseCaseOutputComposerTests: XCTestCase {
    
    func test_composeZeroOutputs_doNotCrash() {
        let sut = LoginUseCaseOutputComposer([])
        
        sut.loginFinished(with: .success(User(name: "Test", age: 25)))
    }
    
    func test_composingMultipleOutputs_delegatesSuccededMessage() {
        let output1 = LoginUseCaseOutputSpy()
        let output2 = LoginUseCaseOutputSpy()
        let sut = LoginUseCaseOutputComposer([output1, output2])
        
        sut.loginFinished(with: .success(User(name: "Test", age: 25)))
        
        XCTAssertEqual(output1.loginSuccessCount, 1)
        XCTAssertEqual(output1.loginFailureCount, 0)
        
        XCTAssertEqual(output2.loginSuccessCount, 1)
        XCTAssertEqual(output2.loginFailureCount, 0)
    }
    
    func test_composingMultipleOutputs_delegatesFailedMessage() {
        let output1 = LoginUseCaseOutputSpy()
        let output2 = LoginUseCaseOutputSpy()
        let sut = LoginUseCaseOutputComposer([output1, output2])
        
        sut.loginFinished(with: .failure(MockError.unableToComplete))
        
        XCTAssertEqual(output1.loginSuccessCount, 0)
        XCTAssertEqual(output1.loginFailureCount, 1)
        
        XCTAssertEqual(output2.loginSuccessCount, 0)
        XCTAssertEqual(output2.loginFailureCount, 1)
    }
    
    // MARK: - Helpers
    
    private enum MockError: String, Error {
        case unableToComplete = "Unable to complete your request. Please check your internet connection"
    }
    
    private class LoginUseCaseOutputSpy: LoginUseCaseOutput {
        var loginSuccessCount = 0
        var loginFailureCount = 0
        
        func loginFinished(with result: Result<User, Error>) {
            switch result {
            case .success(_):
                loginSuccessCount += 1
                
            case .failure(_):
                loginFailureCount += 1
            }
        }
    }
}
