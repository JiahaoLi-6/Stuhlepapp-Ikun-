//
//  TipsResourcesView.swift
//  StuHlep
//
//  Created on 6/5/2026.
//
import SwiftUI

struct TipsResourcesView: View {
    @State private var searchText = ""
    @State private var selectedFilter = "All"

    let filters = ["All", "Tips", "Study Plan", "Resource"]

    let tips = [
        TipItem(
            author: "Emily Wang",
            major: "Computer Science",
            time: "2h ago",
            tag: "Study Plan",
            title: "My 4-Week Plan to Ace iOS Development",
            content: "Here’s my study plan that helped me improve so much in a month!",
            likes: 24,
            comments: 8,
            avatar: "E",
            tagColor: .green
        ),
        TipItem(
            author: "Jason Li",
            major: "Software Engineering",
            time: "5h ago",
            tag: "Tips",
            title: "Debugging Tips in Xcode",
            content: "Some debugging tips that can save you hours!",
            likes: 19,
            comments: 3,
            avatar: "J",
            tagColor: .blue
        ),
        TipItem(
            author: "Sophie Chen",
            major: "Information Technology",
            time: "1d ago",
            tag: "Resource",
            title: "My Favorite iOS Learning Resources",
            content: "A list of books, websites and apps that really helped me.",
            likes: 15,
            comments: 2,
            avatar: "S",
            tagColor: .purple
        )
    ]

    var filteredTips: [TipItem] {
        tips.filter { tip in
            let matchesFilter = selectedFilter == "All" || tip.tag == selectedFilter

            let matchesSearch = searchText.isEmpty ||
            tip.title.localizedCaseInsensitiveContains(searchText) ||
            tip.content.localizedCaseInsensitiveContains(searchText) ||
            tip.author.localizedCaseInsensitiveContains(searchText)

            return matchesFilter && matchesSearch
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 14) {
                header

                SearchBar(placeholder: "Search tips, resources...", text: $searchText)
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
                        ForEach(filteredTips) { tip in
                            TipCardNew(tip: tip)
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

            Text("Tips & Resources")
                .font(.title2)
                .fontWeight(.bold)

            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

struct TipCardNew: View {
    @EnvironmentObject var appData: AppData

    let tip: TipItem

    @State private var saved = false
    @State private var liked = false
    @State private var openComments = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                AvatarCircle(text: tip.avatar, color: tip.tagColor)

                VStack(alignment: .leading) {
                    Text(tip.author)
                        .font(.subheadline)
                        .fontWeight(.medium)

                    Text("\(tip.major) · \(tip.time)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Text(tip.tag)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(tip.tagColor.opacity(0.15))
                    .foregroundColor(tip.tagColor)
                    .cornerRadius(10)
            }

            Text(tip.title)
                .font(.headline)

            Text(tip.content)
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack {
                Button {
                    liked.toggle()
                } label: {
                    HStack {
                        Image(systemName: liked ? "heart.fill" : "heart")
                        Text("\(liked ? tip.likes + 1 : tip.likes)")
                    }
                }

                Button {
                    openComments = true
                } label: {
                    HStack {
                        Image(systemName: "bubble.left")
                        Text("\(tip.comments)")
                    }
                }

                Spacer()

                Button {
                    saved.toggle()
                    appData.saveTip(tip)
                } label: {
                    Image(systemName: saved ? "bookmark.fill" : "bookmark")
                }
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
        .navigationDestination(isPresented: $openComments) {
            TipCommentsView(tip: tip)
        }
    }
}

struct TipCommentsView: View {
    let tip: TipItem

    @State private var comment = ""

    @State private var comments = [
        "This plan is really useful for beginners.",
        "I followed a similar plan and improved my SwiftUI skills.",
        "Can you share more resources about Xcode debugging?"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(tip.title)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)

            Text(tip.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            Divider()

            Text("Comments")
                .font(.headline)
                .padding(.horizontal)

            List(comments, id: \.self) { item in
                HStack(alignment: .top, spacing: 10) {
                    AvatarCircle(text: "S", color: .purple)

                    Text(item)
                }
            }
            .listStyle(.plain)

            HStack {
                TextField("Add a comment...", text: $comment)
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
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
    }
}
