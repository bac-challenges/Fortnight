//
//  ContentView.swift
//  CodeChallenge
//
//  Created by emile on 01/07/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ItemListView(.home)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ItemListView(.events)
                .tabItem {
                    Label("Events", systemImage: "photo.on.rectangle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
