//
//  StaffViewModel.swift
//  CoffeeManager2
//
//  Created by Aziz Arfaoui on 11/11/2025.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class StaffViewModel: ObservableObject {
    @Published var staffList: [Staff] = []
    private var db = Firestore.firestore()

    func fetchStaff() {
        db.collection("staff").addSnapshotListener { snapshot, error in
            if let snapshot = snapshot {
                self.staffList = snapshot.documents.compactMap { doc in
                    try? doc.data(as: Staff.self)
                }
            }
        }
    }

    func addStaff(staff: Staff) {
        do {
            _ = try db.collection("staff").addDocument(from: staff)
        } catch {
            print("Error adding staff: \(error)")
        }
    }

    func updateStaff(staff: Staff) {
        guard let id = staff.id else { return }
        do {
            try db.collection("staff").document(id).setData(from: staff)
        } catch {
            print("Error updating staff: \(error)")
        }
    }

    func deleteStaff(staffID: String) {
        db.collection("staff").document(staffID).delete()
    }
}