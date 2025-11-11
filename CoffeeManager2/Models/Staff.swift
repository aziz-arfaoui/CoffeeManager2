//
//  Staff.swift
//  CoffeeManager2
//
//  Created by Aziz Arfaoui on 11/11/2025.
//


import Foundation
import FirebaseFirestoreSwift

struct Staff: Identifiable, Codable {
    @DocumentID var id: String? = nil
    var name: String
    var role: String
    var email: String
}