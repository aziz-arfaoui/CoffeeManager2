import Foundation
import FirebaseFirestore

enum ShiftType: String, Codable, CaseIterable, Identifiable {
    case morning = "Morning"
    case afternoon = "Afternoon"
    
    var id: String { self.rawValue }
}

enum ExpenseType: String, Codable, CaseIterable, Identifiable {
    case matierePremiere = "Matiere Premiere"
    case achat = "Achat"
    case reparation = "Reparation"
    
    var id: String { self.rawValue }
}

struct Expense: Identifiable, Codable {
    @DocumentID var id: String? = nil
    var amount: Double
    var type: ExpenseType
    var notes: String?
}

struct Shift: Identifiable, Codable {
    @DocumentID var id: String? = nil
    var date: Date
    var type: ShiftType
    var globalRevenue: Double
    var kitchenRevenue: Double
    var barRevenue: Double
    var expenses: [Expense] = []
    var closed: Bool = false
}
