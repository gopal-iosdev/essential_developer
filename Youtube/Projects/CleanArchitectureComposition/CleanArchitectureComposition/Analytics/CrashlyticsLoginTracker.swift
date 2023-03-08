//
//  CrashlyticsLoginTracker.swift
//  CleanArchitectureComposition
//
//  Created by Gopal Gurram on 3/7/23.
//

import Foundation

final class CrashlyticsLoginTracker: LoginUseCaseOutput {
    func loginFinished(with result: Result<User, Error>) {
        switch result {
        case .success(let success):
            // send login event to crashlytics.
            print("success")
        case .failure(let failure):
            // send error to crashlytics.
            print("failure")
        }
    }
}
