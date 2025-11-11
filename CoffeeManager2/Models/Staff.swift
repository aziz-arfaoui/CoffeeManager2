//
//  Staff.swift
//  CoffeeManager2
//
//  Created by Aziz Arfaoui on 11/11/2025.
//


import Foundation
import FirebaseFirestore


struct Staff: Identifiable, Codable {
    @DocumentID var id: String? = nil
    var name: String
    var role: String
    var email: String
}
