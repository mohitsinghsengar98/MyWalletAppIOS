//
//  LoginData.swift
//  My Wallet App
//
//  Created by Mohit Sengar on 28/10/24.
//

import Foundation

class LoginData : ObservableObject{
    @Published var loginId: String = UserDefaults.standard.string(forKey: LoginsDataType.loginId.rawValue) ?? ""{
        didSet{
            UserDefaults.standard.value(forKey: LoginsDataType.loginId.rawValue)
        }
    }
    
    @Published var loginPassword: String = UserDefaults.standard.string(forKey: LoginsDataType.loginPassword.rawValue) ?? ""{
        didSet{
            UserDefaults.standard.value(forKey: LoginsDataType.loginPassword.rawValue)
        }
    }
}

enum LoginsDataType:String,CodingKey{
    case loginPassword = "LoginPassword"
    case loginId = "LoginId"
}
