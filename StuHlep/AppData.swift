//
//  AppData.swift
//  StuHlep
//
//  Created by 1 on 7/5/2026.
//
import SwiftUI
import Combine

final class AppData: ObservableObject {
    @Published var myPosts: [DiscussionPost] = []
    @Published var joinedGroups: [StudyGroupItem] = []
    @Published var savedTips: [TipItem] = []

    @Published var notifications: [String] = [
        "iOS Assignment 2 is due this Friday.",
        "You have 2 new replies in Discussion.",
        "Mobile Dev Study Squad has a new group message.",
        "Remember to upload GitHub repository link in README."
    ]

    func addPost(title: String, content: String) {
        let post = DiscussionPost(
            category: "Homework Help",
            title: title,
            content: content,
            author: "Me",
            major: "Information Technology",
            replies: 0,
            time: "Just now",
            avatars: ["M"],
            color: .purple
        )

        myPosts.insert(post, at: 0)
    }

    func joinGroup(_ group: StudyGroupItem) {
        if !joinedGroups.contains(where: { $0.title == group.title }) {
            joinedGroups.append(group)
        }
    }

    func saveTip(_ tip: TipItem) {
        if !savedTips.contains(where: { $0.title == tip.title }) {
            savedTips.append(tip)
        }
    }
}
