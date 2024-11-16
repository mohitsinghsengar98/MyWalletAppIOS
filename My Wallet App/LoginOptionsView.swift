//
//  LoginOptionsView.swift
//  My Wallet App
//
//  Created by Mohit Sengar on 28/10/24.
//

import SwiftUI
import LocalAuthentication

struct LoginOptionsView: View {
    @Binding var showModally: Bool
    @Binding var isValidLogins: Bool
    @State private var showAlert :Bool = false
    @State private var selectedAuthenticationMethod: AuthenticationMethod?
    @State private var showMessage:String = ""
    
    var body: some View {
        // Use a ZStack to overlay the LoginScreen or the List based on the showModally state
        ZStack {
            if showModally {
                NavigationView {
                    List {
                        // User Login Option
                        Button("User Login") {
                            showModally = false
                            print("User Login tapped")
                        }
                        
                        // Face ID Option
                        Button("Face ID") {
                            selectedAuthenticationMethod = .faceID
                            authenticate()
                            // Handle Face ID login action
                            print("Face ID Login tapped")
                        }
                        
                        // Fingerprint Option
                        Button("Fingerprint") {
                            selectedAuthenticationMethod = .fingerprint
                            authenticate()
                            // Handle Fingerprint login action
                            print("Fingerprint Login tapped")
                        }
                        
                        // Phone Passcode Option
                        Button("Phone Passcode") {
                            selectedAuthenticationMethod = .passcode
                            authenticate()
                            // Handle Phone Passcode login action
                            print("Phone Passcode Login tapped")
                        }
                    }.alert(isPresented: $showAlert) {
                        Alert(title: Text("Authentication Failed"),
                              message: Text(showMessage),
                              dismissButton: .default(Text("OK")))
                    }
                    .navigationTitle("Login Options")
                }
            } else {
                LoginScreen() // Show LoginScreen when showModally is false
            }
        }
    }

    func authenticate(){
        switch selectedAuthenticationMethod {
        case .faceID:
            authenticateWithFaceID { success in
                        if success {
                            isValidLogins = true
                        } else {
                            showMessage = "Face ID authentication failed. Please try again."
                            showAlert = true
                        }
                    }
            break
        case .fingerprint:
            authenticateWithFingerprint { success in
                        if success {
                            isValidLogins = true
                        } else {
                            showMessage = "Finger Print ID authentication failed. Please try again."
                            showAlert = true
                        }
                    }
            break
        case .passcode:
            authenticateWithPasscode { success in
                        if success {
                            isValidLogins = true
                        } else {
                            showMessage = "Passcode ID authentication failed. Please try again."
                            showAlert = true
                        }
                    }
            break
        default:
            showMessage = "Invalid authentication type selected. Please try again."
            showAlert = true
            break
        }
    }
    
    func authenticateWithFaceID(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var authError: NSError?

        // Check if biometric authentication is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            // Biometric authentication is available
            let reason = "Authenticate with Face ID"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluationError in
                DispatchQueue.main.async {
                    if success {
                        // Authentication was successful
                        completion(true)
                    } else {
                        // Authentication failed
                        completion(false)
                    }
                }
            }
        } else {
            // Biometrics not available
            completion(false)
        }
    }
    
    func authenticateWithPasscode(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var authError: NSError?

        // Check if biometric or passcode authentication is available
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            // This indicates that either biometrics (Face ID/Touch ID) or a passcode is available
            let reason = "Authenticate using your device passcode"

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluationError in
                DispatchQueue.main.async {
                    if success {
                        // Authentication was successful
                        completion(true)
                    } else {
                        // Authentication failed
                        completion(false)
                    }
                }
            }
        } else {
            // Passcode not available
            completion(false)
        }
    }
    
    func authenticateWithFingerprint(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var authError: NSError?

        // Check if biometric authentication is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            // Biometric authentication is available
            let reason = "Authenticate using your fingerprint"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluationError in
                DispatchQueue.main.async {
                    if success {
                        // Authentication was successful
                        completion(true)
                    } else {
                        // Authentication failed
                        completion(false)
                    }
                }
            }
        } else {
            // Biometrics not available
            completion(false)
        }
    }
}

// Define an enum for Authentication Methods
enum AuthenticationMethod {
    case faceID
    case fingerprint
    case passcode
}

#Preview {
    LoginOptionsView(showModally: .constant(true), isValidLogins: .constant(false))
}
