//
//  LoginPresenter.swift
//  CleanArchitectureComposition
//
//  Created by Gopal Gurram on 3/7/23.
//

import Foundation

final class LoginPresenter: LoginUseCaseOutput {
    func loginFinished(with result: Result<User, Error>) {
        switch result {
        case .success(let success):
            print("success")
            // create welcome view model and pass it to the view controller
        case .failure(let failure):
            // create error view model and pass it to the view controller.
            print("failure")
        }
    }
}
