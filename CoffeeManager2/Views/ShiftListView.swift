import SwiftUI

struct ShiftListView: View {
    @StateObject var viewModel = ShiftViewModel()
    @State private var showingAddSheet = false
    
    func formatCurrency(_ value: Double) -> String {
        String(format: "%.2f TND", value)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.shifts) { shift in
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text(shift.date.formatted(date: .long, time: .omitted))
                                .font(.title3)
                                .bold()
                                .padding(.bottom, 5)
                            
                            // Revenue
                            VStack(spacing: 8) {
                                HStack { Text("Global Revenue"); Spacer(); Text(formatCurrency(shift.globalRevenue)).bold() }
                                HStack { Text("Kitchen Revenue"); Spacer(); Text(formatCurrency(shift.kitchenRevenue)).bold() }
                                HStack { Text("Bar Revenue"); Spacer(); Text(formatCurrency(shift.barRevenue)).bold() }
                            }
                            .padding()
                            .background(Color.green.opacity(0.15))
                            .cornerRadius(12)
                            
                            // Expenses
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Expenses").font(.headline)
                                HStack { Text("Matiere Premiere"); Spacer(); Text(formatCurrency(viewModel.totalExpenses(for: .matierePremiere, in: shift))).foregroundColor(.red) }
                                HStack { Text("Achat"); Spacer(); Text(formatCurrency(viewModel.totalExpenses(for: .achat, in: shift))).foregroundColor(.red) }
                                HStack { Text("Reparation"); Spacer(); Text(formatCurrency(viewModel.totalExpenses(for: .reparation, in: shift))).foregroundColor(.red) }
                                
                                if !shift.expenses.isEmpty {
                                    Divider()
                                    ForEach(shift.expenses) { exp in
                                        HStack {
                                            Text(exp.type.rawValue)
                                            Spacer()
                                            Text(formatCurrency(exp.amount))
                                        }
                                        if let notes = exp.notes {
                                            Text(notes).font(.caption).foregroundColor(.gray)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(12)
                            
                        }
                        .padding()
                        .background(shift.closed ? Color.yellow.opacity(0.15) : Color.white)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
                    }
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Shifts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") { showingAddSheet = true }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddShiftView(viewModel: viewModel)
            }
            .onAppear {
                viewModel.fetchShifts()
            }
        }
    }
}
