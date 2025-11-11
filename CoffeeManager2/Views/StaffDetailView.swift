//
//  StaffDetailView.swift
//  CoffeeManager2
//
//  Created by Aziz Arfaoui on 11/11/2025.
//


import SwiftUI

struct StaffDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: StaffViewModel
    @State var staff: Staff

    var body: some View {
        Form {
            TextField("Name", text: $staff.name)
            TextField("Role", text: $staff.role)
            TextField("Email", text: $staff.email)

            Button("Save Changes") {
                viewModel.updateStaff(staff: staff)
                dismiss()
            }
        }
        .navigationTitle(staff.name)
    }
}
