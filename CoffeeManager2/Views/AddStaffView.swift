//
//  AddStaffView.swift
//  CoffeeManager2
//
//  Created by Aziz Arfaoui on 11/11/2025.
//


import SwiftUI

struct AddStaffView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: StaffViewModel
    @State private var name = ""
    @State private var role = ""
    @State private var email = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Role", text: $role)
                TextField("Email", text: $email)
                Button("Save") {
                    let staff = Staff(name: name, role: role, email: email)
                    viewModel.addStaff(staff: staff)
                    dismiss()
                }
            }
            .navigationTitle("Add Staff")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}