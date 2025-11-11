import Foundation
import FirebaseFirestore
import Combine

class ShiftViewModel: ObservableObject {
    @Published var shifts: [Shift] = []
    @Published var errorMessage: String?
    
    private var db = Firestore.firestore()
    
    func fetchShifts() {
        db.collection("shifts").order(by: "date", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    DispatchQueue.main.async { self?.errorMessage = error.localizedDescription }
                    return
                }
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self?.shifts = snapshot.documents.compactMap { try? $0.data(as: Shift.self) }
                    }
                }
            }
    }
    
    func addShift(_ shift: Shift) {
        do {
            _ = try db.collection("shifts").addDocument(from: shift)
        } catch {
            DispatchQueue.main.async { self.errorMessage = error.localizedDescription }
        }
    }
    
    func updateShift(_ shift: Shift) {
        guard let id = shift.id else { return }
        do {
            try db.collection("shifts").document(id).setData(from: shift)
        } catch {
            DispatchQueue.main.async { self.errorMessage = error.localizedDescription }
        }
    }
    
    func deleteShift(_ id: String) {
        db.collection("shifts").document(id).delete()
    }
    
    func totalExpenses(for type: ExpenseType, in shift: Shift) -> Double {
        shift.expenses.filter { $0.type == type }.reduce(0) { $0 + $1.amount }
    }
    
    func shiftExists(for date: Date, type: ShiftType) -> Bool {
        shifts.contains { Calendar.current.isDate($0.date, inSameDayAs: date) && $0.type == type }
    }
}
