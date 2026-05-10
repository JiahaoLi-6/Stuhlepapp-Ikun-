//
//  DiscussionView.swift
//  StuHlep
//
//  Created on 4/5/2026.
//
import SwiftUI

struct DiscussionView: View {
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var AppData: AppData

    @State private var searchText = ""
    @State private var selectedFilter = "All"
    @State private var showCreatePost = false
    @State private var showNotifications = false

    let filters = ["All", "Homework Help", "Experience", "Resource"]

    let posts = [
        DiscussionPost(
            category: "Homework Help",
            title: "Stuck on SwiftUI List and ForEach 😣",
            content: "Anyone knows how to fix the issue with ForEach not updating the UI?",
            author: "Jessica",
            major: "Computer Science",
            replies: 12,
            time: "2h ago",
            avatars: ["J", "M"],
            color: .purple
        ),
        DiscussionPost(
            category: "Experience",
            title: "How I got an HD in Mobile App Development",
            content: "Sharing my experience and tips for getting a high distinction in this subject!",
            author: "Jason",
            major: "Software Engineering",
            replies: 24,
            time: "5h ago",
            avatars: ["A", "K"],
            color: .orange
        ),
        DiscussionPost(
            category: "Resource",
            title: "Great YouTube channels for iOS development",
            content: "Here are some underrated channels that really helped me a lot.",
            author: "Emily",
            major: "Information Technology",
            replies: 15,
            time: "1d ago",
            avatars: ["E", "S"],
            color: .green
        )
    ]

    var allPosts: [DiscussionPost] {
        appData.myPosts + posts
    }

    var filteredPosts: [DiscussionPost] {
        allPosts.filter { post in
            let matchesFilter = selectedFilter == "All" || post.category == selectedFilter

            let matchesSearch = searchText.isEmpty ||
            post.title.localizedCaseInsensitiveContains(searchText) ||
            post.content.localizedCaseInsensitiveContains(searchText) ||
            post.major.localizedCaseInsensitiveContains(searchText)

            return matchesFilter && matchesSearch
        }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 14) {
                    header

                    HStack {
                        SearchBar(placeholder: "Search discussions...", text: $searchText)

                        Button {
                            selectedFilter = "All"
                            searchText = ""
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .foregroundColor(.white)
                                .padding(12)
                                .background(Color.purple)
                                .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(filters, id: \.self) { filter in
                                Button {
                                    selectedFilter = filter
                                } label: {
                                    FilterChip(title: filter, selected: selectedFilter == filter)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(filteredPosts) { post in
                                NavigationLink(destination: DiscussionDetailView(post: post)) {
                                    DiscussionCard(post: post)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                }

                Button {
                    showCreatePost = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 58, height: 58)
                        .background(Color.purple)
                        .clipShape(Circle())
                        .shadow(radius: 8)
                }
                .padding()
            }
            .sheet(isPresented: $showCreatePost) {
                CreatePostView()
                    .environmentObject(appData)
            }
            .sheet(isPresented: $showNotifications) {
                NotificationView()
                    .environmentObject(appData)
            }
        }
    }

    var header: some View {
        HStack {
            CanvasButton()

            Text("Discussion")
                .font(.largeTitle)
                .fontWeight(.bold)

            Spacer()

            Button {
                showNotifications = true
            } label: {
                Image(systemName: "bell")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

struct DiscussionCard: View {
    let post: DiscussionPost

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(post.category)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(post.color.opacity(0.15))
                .foregroundColor(post.color)
                .cornerRadius(10)

            Text(post.title)
                .font(.headline)
                .foregroundColor(.primary)

            Text(post.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)

            HStack {
                HStack(spacing: -8) {
                    ForEach(post.avatars, id: \.self) { avatar in
                        AvatarCircle(text: avatar, color: post.color)
                    }
                }

                Text(post.major)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text("· \(post.replies) replies")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text("· \(post.time)")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
}

struct DiscussionDetailView: View {
    let post: DiscussionPost

    @State private var comment = ""
    @State private var liked = false
    @State private var saved = false

    @State private var comments = [
        "Try checking whether your data conforms to Identifiable.",
        "I solved this by using @State and updating the array properly.",
        "Maybe check your ForEach id parameter."
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            DiscussionCard(post: post)

            HStack {
                Button {
                    liked.toggle()
                } label: {
                    Label(liked ? "Liked" : "Like", systemImage: liked ? "heart.fill" : "heart")
                }

                Spacer()

                Button {
                    saved.toggle()
                } label: {
                    Label(saved ? "Saved" : "Save", systemImage: saved ? "bookmark.fill" : "bookmark")
                }
            }
            .padding(.horizontal)

            Text("Student Answers")
                .font(.headline)
                .padding(.horizontal)

            List(comments, id: \.self) { item in
                HStack(alignment: .top, spacing: 10) {
                    AvatarCircle(text: "S", color: .blue)

                    Text(item)
                        .font(.subheadline)
                }
            }
            .listStyle(.plain)

            HStack {
                TextField("Add your answer...", text: $comment)
                    .textFieldStyle(.roundedBorder)

                Button("Send") {
                    let trimmed = comment.trimmingCharacters(in: .whitespacesAndNewlines)

                    if !trimmed.isEmpty {
                        comments.append("Me: \(trimmed)")
                        comment = ""
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle("Post Detail")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

struct CreatePostView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var content = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Post Information") {
                    TextField("Post title", text: $title)
                    TextField("Post content", text: $content, axis: .vertical)
                        .lineLimit(4)
                }
            }
            .navigationTitle("New Post")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Post") {
                        appData.addPost(title: title, content: content)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty ||
                              content.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

struct NotificationView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            List(appData.notifications, id: \.self) { item in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "bell.fill")
                        .foregroundColor(.purple)

                    Text(item)
                        .font(.subheadline)
                }
                .padding(.vertical, 6)
            }
            .navigationTitle("Important Tasks")
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}
