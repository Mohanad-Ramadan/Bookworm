//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Mohanad Ramdan on 18/08/2023.
//

import SwiftUI
import CoreData

@main
struct BookwormApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
