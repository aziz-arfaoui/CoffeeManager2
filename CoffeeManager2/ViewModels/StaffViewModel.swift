import Foundation
import FirebaseFirestore
import Combine

class StaffViewModel: ObservableObject {
    @Published var staffList: [Staff] = []
    @Published var errorMessage: String?

    private var db = Firestore.firestore()

    // Fetch all staff
    func fetchStaff() {
        db.collection("staff").addSnapshotListener { [weak self] snapshot, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
                return
            }
            if let snapshot = snapshot {
                DispatchQueue.main.async {
                    self?.staffList = snapshot.documents.compactMap { doc in
                        try? doc.data(as: Staff.self)
                    }
                }
            }
        }
    }

    // Add new staff
    func addStaff(staff: Staff) {
        do {
            _ = try db.collection("staff").addDocument(from: staff)
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }

    // Update existing staff
    func updateStaff(staff: Staff) {
        guard let id = staff.id else { return }
        do {
            try db.collection("staff").document(id).setData(from: staff)
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }

    // Delete staff
    func deleteStaff(staffID: String) {
        db.collection("staff").document(staffID).delete()
    }
}
