//
//  AuthManager.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/6/22.
//

import FirebaseAuth
import Foundation


class AuthManager {
    static let shared = AuthManager()
    private var verificationId: String?
    
    public func startAuth(phoneNumber: String, completion: @escaping(Bool) -> Void) {
        let phoneNumber = String(format: "+%@", phoneNumber)
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationId, error in
                guard let verificationId = verificationId, error == nil else {
                    completion(false)
                    return

                }
                self?.verificationId = verificationId
                completion(true)
            }

    }
    
    
    

}






static let shared = AuthManager()
private let auth = Auth.auth()
private var verificationId: String?

public func startAuth(phoneNumber: String, completion: @escaping(Bool) -> Void) {
    PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationId, error in
        guard let verificationId = verificationId, error == nil else {
            completion(false)
            return

        }
        self?.verificationId = verificationId
        completion(true)
    }

}

public func verifyCode(smsCode: String, completion: @escaping(Bool) -> Void) {
    guard let verificationId = verificationId else {
        completion(false)
        return
    }

    let credential = PhoneAuthProvider.provider().credential(
        withVerificationID: verificationId,
        verificationCode: smsCode)
    auth.signIn(with: credential) { result, error in
        guard result != nil, error == nil else {
            completion(false)
            return
        }
        completion(true)
    }
}







//public func sendCode(phoneNumber: String, completion: @escaping(Bool) -> Void) {
//    PhoneAuthProvider.provider()
//      .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
//          if let error = error {
//              print("DEBUG: \(error.localizedDescription)")
//              completion(false)
//              return
//          }
//          UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
//          completion(true)
//      }
//}
