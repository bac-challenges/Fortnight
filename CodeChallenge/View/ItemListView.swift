//
//  ItemListView.swift
//  CodeChallenge
//
//  Created by emile on 01/07/2022.
//

import SwiftUI

struct ItemListView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(_ type: ItemType) {
        self.viewModel = ViewModel(type: type)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ItemView(items: viewModel.items)
            }.padding(10)
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(.home)
    }
}
