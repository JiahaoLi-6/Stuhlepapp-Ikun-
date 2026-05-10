//
//  StuHlepApp.swift
//  StuHlep
//
//  Created on 5/5/2026.
//

import SwiftUI

@main
struct StuHlepApp: App {
    @StateObject private var appData = AppData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData)
        }
    }
}

