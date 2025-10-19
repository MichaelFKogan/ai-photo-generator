//
//  SignInView.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/18/25.
//

import SwiftUI
import AuthenticationServices // For Apple Sign-In
//import GoogleSignIn

struct SignInView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showEmailSheet = false
    @State private var isSignUp = false
    @State private var email = ""
    @State private var password = ""


    var body: some View {
        ZStack {
            // Adaptive system background (dark/light)
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 24) {

                Text("Welcome")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.primary) // Adapts automatically
                    .padding(.bottom, 8)
                
                Spacer()

                VStack(spacing: 16) {
                    SignInButton(
                        title: "Continue with Apple",
                        icon: "applelogo",
                        background: Color.white
                    ) {
                        handleAppleSignIn()
                    }

                    SignInButton(
                        title: "Continue with Google",
                        icon: "globe",
                        background: Color.white
                    ) {
                        authViewModel.isSignedIn = true
                    }

                    SignInButton(
                        title: "Continue with Email",
                        icon: "envelope.fill",
                        background: Color.white
                    ) {
                        showEmailSheet = true
                    }
                    .sheet(isPresented: $showEmailSheet) {
                        VStack(spacing: 16) {
                            // Gray drag indicator
                            Capsule()
                                .frame(width: 40, height: 5)
                                .foregroundColor(Color.gray.opacity(0.5))
                                .padding(.top, 8)
                                .padding(.bottom, 16)
                            
                            Text(isSignUp ? "Create Account" : "Sign In")
                                .font(.headline)
                            
                            TextField("Email", text: $email)
                                .padding()
                                .background(Color.black)  // Change to black
                                .cornerRadius(8)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)

                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color.black)  // Change to black
                                .cornerRadius(8)
                            
                            Button(isSignUp ? "Sign Up" : "Sign In") {
                                Task {
                                    if isSignUp {
                                        await authViewModel.signUpWithEmail(email: email, password: password)
                                    } else {
                                        await authViewModel.signInWithEmail(email: email, password: password)
                                    }
                                    // Dismiss sheet after sign in attempt
                                    if authViewModel.isSignedIn {
                                        showEmailSheet = false
                                    }
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)  // Add this
                            .frame(maxWidth: .infinity)
                            .padding(.top)
                            
                            Button(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up") {
                                isSignUp.toggle()
                            }
                            .font(.footnote)
                            .padding(.top, 4)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }


                }
                .padding(.horizontal)


                VStack(spacing: 4) {
                    Text("By continuing you agree to our")
                        .font(.footnote)
                        .foregroundColor(.secondary)

                    HStack(spacing: 4) {
                        Link("Terms of Service", destination: URL(string: "https://yourapp.com/terms")!)
                            .font(.footnote)
                            .underline()
                        Text("and")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Link("Privacy Policy", destination: URL(string: "https://yourapp.com/privacy")!)
                            .font(.footnote)
                            .underline()
                    }
                }
                .padding(.bottom, 40)
            }
            .padding()
        }
    }
}


struct SignInButton: View {
    let title: String
    let icon: String
    let background: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.trailing, 4)
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .padding(.vertical, 12)
            .foregroundColor(.black)
            .background(background)
            .cornerRadius(12)
        }
    }
}

import AuthenticationServices

extension SignInView {
    func handleAppleSignIn() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email, .fullName]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = AppleSignInCoordinator(authViewModel: authViewModel)
        controller.performRequests()
    }
}

class AppleSignInCoordinator: NSObject, ASAuthorizationControllerDelegate {
    let authViewModel: AuthViewModel
    
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
           let identityToken = appleIDCredential.identityToken,
           let idTokenString = String(data: identityToken, encoding: .utf8) {
            
            Task {
                await authViewModel.signInWithApple(idToken: idTokenString)
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple sign in failed: \(error)")
    }
}
