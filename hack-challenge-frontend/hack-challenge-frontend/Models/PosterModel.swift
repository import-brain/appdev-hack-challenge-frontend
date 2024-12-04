//
//  PosterModel.swift
//  hack-challenge-frontend
//
//  Created by Aaron Zhu on 12/3/24.
//

import SwiftUI
import Foundation

struct PosterModel: Identifiable, Codable {
    let id: UUID
    let title: String
    let date: Date
    let location: String
    let description: String
    let tags: [String]
    
    var isUpcoming: Bool {
        date > Date()
    }
}
