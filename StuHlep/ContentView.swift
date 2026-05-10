import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DiscussionView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            StudyGroupsView()
                .tabItem {
                    Label("Study Groups", systemImage: "sparkles")
                }

            TipsResourcesView()
                .tabItem {
                    Label("Tips", systemImage: "bell.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .tint(.purple)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppData())
}
