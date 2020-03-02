//
//  LoginViewModel.swift
//  LoginWithMVVM
//
//  Created by KHAMARI, SUMIT on 3/2/20.
//  Copyright © 2020 KHAMARI, SUMIT. All rights reserved.
//

import Foundation


struct STRING_CONSTANT {
    
    static let ERROR_USERNAME  = "UserNameError"
    static let ERROR_PASSWORD  = "PasswordError"

}


public enum Result<T> {
    case success(T)
    case failure(Error)
    
    func resolve() throws -> T {
        switch self {
        case .success(let T):
            return T
        case .failure(let error):
            throw error
        }
    }
}


protocol LoginVCModel {
    var delegate: LoginActionService { get }
    func login(withUsername username: String?, password: String?)
}

protocol LoginActionService {
    func loginSuccessfull()
    
    func handle(error: Error)
    
    //send error and succes status of login reponse
    func loginResponseStatus(loginreponseStatus : Int)
}


enum LoginFormValidationError: LocalizedError {
    case invalidUsernameLength
    case invalidPasswordLength
    
    var errorDescription: String? {
        var errorString:String? = nil
        switch self {
        case .invalidUsernameLength:
            errorString = STRING_CONSTANT.ERROR_USERNAME
        case .invalidPasswordLength:
            errorString = STRING_CONSTANT.ERROR_PASSWORD
        }
        return errorString
    }
}


class LoginVCModelDelegate : LoginVCModel {
let delegate: LoginActionService

init(delegate: LoginActionService) {
    self.delegate = delegate
}

    func login(withUsername username: String?, password: String?) {
        // hit login service
        let result = validate(userName: username ?? "", password: password ?? "")
        switch result {
        case .failure(let error):
            //handle error
            delegate.handle(error: error)
            return
        case .success(_):
            // hit login api
            
            serviceCallToAuthenticateUser(userName: username ?? "", password: password ?? "") {
            }
            
            //serviceCallToAuthenticateUserUsingMTT(userName: username ?? "", password: password ?? "") {
            //}
            
            break
        }
    }
    
    private func validate(userName username: String, password: String) -> Result<Bool> {
        guard username.count > 0 else {
            //show error response
            return Result.failure(LoginFormValidationError.invalidUsernameLength)
        }
        
        guard password.count > 0 else {
            //show error response
            return Result.failure(LoginFormValidationError.invalidPasswordLength)
        }
        
        return .success(true)
    }
    

    func serviceCallToAuthenticateUser(userName : String, password : String, completion:@escaping () -> Void)   {
        
        
    }
    
}
