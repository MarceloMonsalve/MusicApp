//
//  LoginView.swift
//  MusicApp
//
//  Created by Marcelo Monsalve on 7/6/22.
//

import SwiftUI
import FirebaseAuth
import Firebase
import CryptoKit
import AuthenticationServices

struct LoginView: View {
    @State var currentNonce:String?
    @EnvironmentObject var authModel: AuthManager
    @State var didAuthenticateUser = false
    @State var newUser = false
    
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
            
            NavigationLink(destination: SignUpView().navigationBarHidden(true),
                           isActive: $newUser,
                           label: { })
            Spacer()
            VStack {
                Spacer()
                Text("Sign In")
                    .foregroundColor(Color.text)
                    .font(.title).bold()
                    .shadow(color: Color.text, radius: 1)
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
                                              print(error?.localizedDescription as Any)
                                              return
                                          }
                                          authModel.tempUser = authResult?.user
                                          let docRef = Firestore.firestore().collection("users")
                                              .document(authResult!.user.uid)
                                          docRef.getDocument { (document, error) in
                                              
                                              if let document = document, document.exists {
                                                  authModel.userSession = authResult?.user
                                                  didAuthenticateUser = true
                                              } else {
                                                  newUser = true
                                              }
                                          }
                                          
                                          print("signed in")
                                          
                                          
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
                .foregroundColor(Color.text)
                .background(Color.background)
                .frame(width: 280, height: 45, alignment: .center)
                .shadow(color: Color.text, radius: 6)
                .padding()
                .padding(.bottom)
                Spacer()
            }
            
            Spacer()
        }
        .background(Color.background)
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
