//
//  CoffeeManager2App.swift
//  CoffeeManager2
//
//  Created by Aziz Arfaoui on 10/11/2025.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct CoffeeManager2App: App {
    
    init() {
            FirebaseApp.configure()
        }
    
    var body: some Scene {
            WindowGroup {
                StaffListView()
            }
        }
}
