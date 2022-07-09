//
//  ItemListView.swift
//  CodeChallenge
//
//  Created by emile on 01/07/2022.
//

import SwiftUI

struct ItemListView: View {
    
    @ObservedObject var viewModel = ViewModel(type: .home)
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.items, id: \.name) { item in
                    Text(item.name)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
