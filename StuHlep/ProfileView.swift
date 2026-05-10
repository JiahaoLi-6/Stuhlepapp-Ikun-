//
//  ProfileView.swift
//  StuHlep
//
//  Created on 6/5/2026.
//
import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                profileHeader

                VStack(spacing: 0) {
                    statsCard

                    VStack(spacing: 0) {
                        ProfileMenuRow(icon: "doc.text", title: "My Posts")
                        ProfileMenuRow(icon: "bookmark", title: "Saved")
                        ProfileMenuRow(icon: "person.3", title: "My Groups")
                        ProfileMenuRow(icon: "trophy", title: "Achievements")
                        ProfileMenuRow(icon: "gearshape", title: "Settings")
                        ProfileMenuRow(icon: "questionmark.circle", title: "Help & Feedback")
                    }
                    .background(Color.white)
                    .cornerRadius(18)
                    .padding()
                }
                .background(Color(.systemGroupedBackground))

                Spacer()
            }
            .ignoresSafeArea(edges: .top)
        }
    }

    var profileHeader: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [Color.purple.opacity(0.85), Color.purple.opacity(0.45)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 300)

            VStack(spacing: 14) {
                HStack {
                    Image(systemName: "gearshape")
                    Spacer()
                    Image(systemName: "pencil")
                }
                .foregroundColor(.white)
                .font(.title3)
                .padding(.horizontal)
                .padding(.top, 55)

                Text("👩🏻‍🎓")
                    .font(.system(size: 72))
                    .frame(width: 96, height: 96)
                    .background(Color.white.opacity(0.25))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))

                Text("Jessica Lin")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("Computer Science")
                    .foregroundColor(.white.opacity(0.9))

                Text("Building apps. Helping peers. Growing together.")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
            }
        }
    }

    var statsCard: some View {
        HStack {
            ProfileStat(number: "12", title: "Posts")
            Divider()
            ProfileStat(number: "8", title: "Groups")
            Divider()
            ProfileStat(number: "36", title: "Bookmarks")
        }
        .frame(height: 86)
        .background(Color.white)
        .cornerRadius(18)
        .padding(.horizontal)
        .offset(y: -34)
        .padding(.bottom, -24)
    }
}

struct ProfileStat: View {
    let number: String
    let title: String

    var body: some View {
        VStack(spacing: 6) {
            Text(number)
                .font(.title3)
                .fontWeight(.bold)

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProfileMenuRow: View {
    let icon: String
    let title: String

    var body: some View {
        NavigationLink(destination: ProfileDetailView(title: title)) {
            HStack {
                Image(systemName: icon)
                    .frame(width: 26)
                    .foregroundColor(.gray)

                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.primary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
        }
    }
}

struct ProfileDetailView: View {
    @EnvironmentObject var appData: AppData

    let title: String

    var body: some View {
        List {
            if title == "My Posts" {
                if appData.myPosts.isEmpty {
                    Text("No posts yet.")
                } else {
                    ForEach(appData.myPosts) { post in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(post.title)
                                .font(.headline)

                            Text(post.content)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            } else if title == "My Groups" {
                if appData.joinedGroups.isEmpty {
                    Text("You have not joined any groups yet.")
                } else {
                    ForEach(appData.joinedGroups) { group in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(group.title)
                                .font(.headline)

                            Text(group.subtitle)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            } else if title == "Saved" {
                if appData.savedTips.isEmpty {
                    Text("No saved tips yet.")
                } else {
                    ForEach(appData.savedTips) { tip in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(tip.title)
                                .font(.headline)

                            Text(tip.content)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            } else {
                Text("\(title) feature is available in this prototype.")
            }
        }
        .navigationTitle(title)
    }
}
