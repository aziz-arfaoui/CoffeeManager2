import SwiftUI

struct StaffListView: View {
    @StateObject var viewModel = StaffViewModel()
    @State private var showingAddSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.staffList) { staff in
                    NavigationLink(staff.name) {
                        StaffDetailView(viewModel: viewModel, staff: staff)
                    }
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
                    Button("Add") { showingAddSheet = true }
                }
            }
            .onAppear { viewModel.fetchStaff() }
            .sheet(isPresented: $showingAddSheet) {
                AddStaffView(viewModel: viewModel)
            }
        }
    }
}
