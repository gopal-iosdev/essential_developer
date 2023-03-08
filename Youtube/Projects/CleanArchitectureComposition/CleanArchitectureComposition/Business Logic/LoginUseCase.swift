//
//  LoginUseCase.swift
//  CleanArchitectureComposition
//
//  Created by Gopal Gurram on 3/7/23.
//

import Foundation

protocol LoginUseCaseOutput {
    func loginFinished(with result: Result<User, Error>)
}

final class LoginUseCase {
    let loginUseCase: LoginUseCaseOutput
    
    init(loginUseCase: LoginUseCaseOutput) {
        self.loginUseCase = loginUseCase
    }
    
    func login(name: String, pwd: String) {
        let user = User(name: "Test", age: 27)
        loginUseCase.loginFinished(with: .success(user))
    }
}
