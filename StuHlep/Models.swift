//
//  Models.swift
//  StuHlep
//
//  Created on 5/5/2026.
//
import SwiftUI

struct DiscussionPost: Identifiable {
    let id = UUID()
    let category: String
    let title: String
    let content: String
    let author: String
    let major: String
    let replies: Int
    let time: String
    let avatars: [String]
    let color: Color
}

struct StudyGroupItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let members: Int
    let status: String
    let icon: String
    let color: Color
}

struct TipItem: Identifiable {
    let id = UUID()
    let author: String
    let major: String
    let time: String
    let tag: String
    let title: String
    let content: String
    let likes: Int
    let comments: Int
    let avatar: String
    let tagColor: Color
}
