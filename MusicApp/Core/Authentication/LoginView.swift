//
//  LoginView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/6/22.
//

import SwiftUI
import FirebaseAuth
import CryptoKit
import AuthenticationServices

struct LoginView: View {
    @State var currentNonce:String?
    @State var didAuthenticateUser = false
    
    //Hashing function using CryptoKit
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()

        return hashString
    }
    
    // from https://firebase.google.com/docs/auth/ios/apple
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }

                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    var body: some View {
        HStack {
            NavigationLink(destination: FeedView().navigationBarHidden(true),
                           isActive: $didAuthenticateUser,
                           label: { })
            Spacer()
            VStack {
                Spacer()
                Text("Sign In")
                    .foregroundColor(.white)
                    .font(.title).bold()
                    .shadow(color: .white, radius: 2)
                    .padding()
                SignInWithAppleButton(
                    onRequest: { request in
                        let nonce = randomNonceString()
                        currentNonce = nonce
                        request.requestedScopes = [.fullName, .email]
                        request.nonce = sha256(nonce)
                    },
                    onCompletion: { result in
                        switch result {
                            case .success(let authResults):
                                switch authResults.credential {
                                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                      
                                          guard let nonce = currentNonce else {
                                            fatalError("Invalid state: A login callback was received, but no login request was sent.")
                                          }
                                          guard let appleIDToken = appleIDCredential.identityToken else {
                                              fatalError("Invalid state: A login callback was received, but no login request was sent.")
                                          }
                                          guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                            return
                                          }
                                         
                                          let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                                          Auth.auth().signIn(with: credential) { (authResult, error) in
                                              if (error != nil) {
                                                  // Error. If error.code == .MissingOrInvalidNonce, make sure
                                                  // you're sending the SHA256-hashed nonce as a hex string with
                                                  // your request to Apple.
                                                  print(error?.localizedDescription as Any)
                                                  return
                                              }
                                              print("signed in")
                                              didAuthenticateUser = true
                                              
                                          }
                                  
                                          print("\(String(describing: Auth.auth().currentUser?.uid))")
                                    default:
                                        break
                                              
                                }
                             default:
                                  break
                        }
                    }
                )
                .frame(width: 280, height: 45, alignment: .center)
                .shadow(color: .white, radius: 6)
                .padding()
                .padding(.bottom)
                Spacer()
            }
            
            Spacer()
        }
        .background(.black)
        
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
