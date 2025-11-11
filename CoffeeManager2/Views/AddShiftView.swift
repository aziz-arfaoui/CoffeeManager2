import SwiftUI

struct AddShiftView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ShiftViewModel
    
    @State private var date = Date()
    @State private var selectedShiftType: ShiftType = .morning
    
    @State private var globalRevenue: Double = 0
    @State private var kitchenRevenue: Double = 0
    @State private var barRevenue: Double = 0
    
    @State private var expenses: [Expense] = []
    @State private var newExpenseAmount: Double = 0
    @State private var newExpenseType: ExpenseType = .matierePremiere
    @State private var newExpenseNotes: String = ""
    
    @State private var showAlert = false
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                
                Picker("Shift Type", selection: $selectedShiftType) {
                    ForEach(ShiftType.allCases) { st in
                        Text(st.rawValue).tag(st)
                    }
                }
                .pickerStyle(.segmented)
                
                TextField("Global Revenue", value: $globalRevenue, formatter: currencyFormatter)
                    .keyboardType(.decimalPad)
                TextField("Kitchen Revenue", value: $kitchenRevenue, formatter: currencyFormatter)
                    .keyboardType(.decimalPad)
                TextField("Bar Revenue", value: $barRevenue, formatter: currencyFormatter)
                    .keyboardType(.decimalPad)
                
                Section("Expenses") {
                    ForEach(expenses) { expense in
                        VStack(alignment: .leading) {
                            Text("\(expense.type.rawValue): \(expense.amount, specifier: "%.2f") TND")
                            if let notes = expense.notes { Text(notes).font(.caption).foregroundColor(.gray) }
                        }
                    }
                    
                    HStack {
                        TextField("Amount", value: $newExpenseAmount, formatter: currencyFormatter)
                            .keyboardType(.decimalPad)
                        Picker("Type", selection: $newExpenseType) {
                            ForEach(ExpenseType.allCases) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        TextField("Notes", text: $newExpenseNotes)
                        Button("+") {
                            let exp = Expense(amount: newExpenseAmount, type: newExpenseType, notes: newExpenseNotes)
                            expenses.append(exp)
                            newExpenseAmount = 0
                            newExpenseNotes = ""
                        }
                    }
                }
                
                Button("Clôturer Shift") {
                    if viewModel.shiftExists(for: date, type: selectedShiftType) {
                        showAlert = true
                        return
                    }
                    
                    let shift = Shift(
                        date: date,
                        type: selectedShiftType,
                        globalRevenue: globalRevenue,
                        kitchenRevenue: kitchenRevenue,
                        barRevenue: barRevenue,
                        expenses: expenses,
                        closed: true
                    )
                    
                    viewModel.addShift(shift)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .alert("Shift already exists for this day and type", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                }
            }
            .navigationTitle("Add Shift")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
