//
//  ContentView.swift
//  hack-challenge-frontend
//
//  Created by Aaron Zhu on 12/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            // First "page" user sees is the account creation view
            CreateAccountView()
        }
    }
}

#Preview {
    ContentView()
}
