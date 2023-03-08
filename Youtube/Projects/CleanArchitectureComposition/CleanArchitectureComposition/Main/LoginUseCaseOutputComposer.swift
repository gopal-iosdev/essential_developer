//
//  LoginUseCaseOutputComposer.swift
//  CleanArchitectureComposition
//
//  Created by Gopal Gurram on 3/7/23.
//

import Foundation

final class LoginUseCaseOutputComposer: LoginUseCaseOutput {
    let outputs: [LoginUseCaseOutput]
    
    init(_ outputs: [LoginUseCaseOutput]) {
        self.outputs = outputs
    }
    
    func loginFinished(with result: Result<User, Error>) {
        outputs.forEach({ $0.loginFinished(with: result) })
    }
}
