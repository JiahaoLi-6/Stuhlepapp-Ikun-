//
//  StudyGroupsView.swift
//  StuHlep
//
//  Created on 6/5/2026.
//

import SwiftUI

struct StudyGroupsView: View {
    @State private var searchText = ""
    @State private var selectedTab = "My Groups"

    let tabs = ["My Groups", "Discover"]

    let groups = [
        StudyGroupItem(
            title: "iOS Assignment Team",
            subtitle: "Working on Assignment 2 - Build a To-Do App",
            members: 4,
            status: "Active",
            icon: "chevron.left.forwardslash.chevron.right",
            color: .red
        ),
        StudyGroupItem(
            title: "Mobile Dev Study Squad",
            subtitle: "Let’s help each other and grow together!",
            members: 6,
            status: "Active",
            icon: "graduationcap.fill",
            color: .blue
        ),
        StudyGroupItem(
            title: "Algorithm & Data Structure",
            subtitle: "Weekly problem solving and discussion",
            members: 5,
            status: "Inactive",
            icon: "flask.fill",
            color: .green
        )
    ]

    let discoverGroups = [
        StudyGroupItem(
            title: "SwiftUI Beginners",
            subtitle: "Open group for students learning SwiftUI basics.",
            members: 2,
            status: "Join",
            icon: "swift",
            color: .orange
        ),
        StudyGroupItem(
            title: "UTS Canvas Help",
            subtitle: "Discuss Canvas tasks, deadlines and assignment problems.",
            members: 8,
            status: "Join",
            icon: "link",
            color: .purple
        ),
        StudyGroupItem(
            title: "Exam Preparation Group",
            subtitle: "Share revision notes and weekly study goals.",
            members: 3,
            status: "Join",
            icon: "book.fill",
            color: .teal
        )
    ]

    var displayedGroups: [StudyGroupItem] {
        let source = selectedTab == "My Groups" ? groups : discoverGroups

        if searchText.isEmpty {
            return source
        }

        return source.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.subtitle.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 14) {
                header

                SearchBar(placeholder: "Search study groups...", text: $searchText)
                    .padding(.horizontal)

                HStack {
                    ForEach(tabs, id: \.self) { tab in
                        Button {
                            selectedTab = tab
                        } label: {
                            VStack(spacing: 8) {
                                Text(tab)
                                    .fontWeight(.semibold)
                                    .foregroundColor(selectedTab == tab ? .purple : .secondary)

                                Rectangle()
                                    .fill(selectedTab == tab ? Color.purple : Color.clear)
                                    .frame(height: 3)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal)

                ScrollView {
                    VStack(spacing: 18) {
                        ForEach(displayedGroups) { group in
                            StudyGroupCardNew(group: group)
                        }
                    }
                    .padding()
                }
            }
        }
    }

    var header: some View {
        HStack {
            CanvasButton()

            Text("Study Groups")
                .font(.title2)
                .fontWeight(.bold)

            Spacer()

            Button {
                print("Create group tapped")
            } label: {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundColor(.purple)
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

struct StudyGroupCardNew: View {
    @EnvironmentObject var appData: AppData

    let group: StudyGroupItem

    @State private var joined = false
    @State private var openChat = false

    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image(systemName: group.icon)
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 64, height: 64)
                    .background(group.color)
                    .cornerRadius(14)

                VStack(alignment: .leading, spacing: 8) {
                    Text(group.title)
                        .font(.headline)

                    Text(group.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)

                    HStack {
                        HStack(spacing: -8) {
                            AvatarCircle(text: "A", color: .blue)
                            AvatarCircle(text: "J", color: .purple)
                            AvatarCircle(text: "K", color: .orange)
                        }

                        Text("\(group.members) members")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Spacer()

                        Button(joined ? "Chat" : "Join") {
                            if joined {
                                openChat = true
                            } else {
                                joined = true
                                appData.joinGroup(group)
                                openChat = true
                            }
                        }
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(joined ? Color.green.opacity(0.15) : Color.purple.opacity(0.12))
                        .foregroundColor(joined ? .green : .purple)
                        .cornerRadius(10)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
        .navigationDestination(isPresented: $openChat) {
            GroupChatView(groupName: group.title)
        }
    }
}

struct GroupChatView: View {
    let groupName: String

    @State private var message = ""

    @State private var messages = [
        "Jessica: Hi everyone, has anyone started the SwiftUI assignment?",
        "Jason: I finished the home page. The hardest part is NavigationStack.",
        "Emily: I can share my notes about MVVM later.",
        "Kevin: Can we meet tonight to discuss the prototype?"
    ]

    var body: some View {
        VStack {
            List(messages, id: \.self) { item in
                Text(item)
                    .padding(.vertical, 6)
            }
            .listStyle(.plain)

            HStack {
                TextField("Type a message...", text: $message)
                    .textFieldStyle(.roundedBorder)

                Button("Send") {
                    let trimmed = message.trimmingCharacters(in: .whitespacesAndNewlines)

                    if !trimmed.isEmpty {
                        messages.append("Me: \(trimmed)")
                        message = ""
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle(groupName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
