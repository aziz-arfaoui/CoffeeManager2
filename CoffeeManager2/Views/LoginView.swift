//
//  LoginView.swift
//  CoffeeManager2
//
//  Created by Aziz Arfaoui on 11/11/2025.
//


import SwiftUI

struct LoginView: View {
    @StateObject var authVM = AuthViewModel()
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $email)
                .textInputAutocapitalization(.none)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $password)

            Button("Login") {
                authVM.login(email: email, password: password)
            }

            NavigationLink("Register", destination: RegisterView())

            if let error = authVM.errorMessage {
                Text(error).foregroundColor(.red)
            }
        }
        .padding()
    }
}
