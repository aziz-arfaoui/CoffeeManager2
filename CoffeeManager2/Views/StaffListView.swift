//
//  StaffListView.swift
//  CoffeeManager2
//
//  Created by Aziz Arfaoui on 11/11/2025.
//


import SwiftUI

struct StaffListView: View {
    @StateObject var viewModel = StaffViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.staffList) { staff in
                    NavigationLink(staff.name, destination: StaffDetailView(staff: staff))
                }
                .onDelete { indexSet in
                    indexSet.forEach { i in
                        if let id = viewModel.staffList[i].id {
                            viewModel.deleteStaff(staffID: id)
                        }
                    }
                }
            }
            .navigationTitle("Staff")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        // present a form to add staff
                    }
                }
            }
            .onAppear { viewModel.fetchStaff() }
        }
    }
}