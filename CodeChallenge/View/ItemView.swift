//
//  ItemView.swift
//  CodeChallenge
//
//  Created by emile on 01/07/2022.
//

import SwiftUI
import Kingfisher

struct ItemView: View {
    
    let items: [Item]
    @State var showAll = false
    
    var body: some View {
        ForEach(items, id: \.name) { item in
            HStack {
                Text(item.name)
                    .font(Font.headline.weight(.bold))
                    .foregroundColor(Color.gray)
                Spacer()
            }
            .padding(.top, 10)
            .padding(.bottom, 10)
            
            ForEach(services(item), id: \.name) { item in
                HStack {
                    if let url = item.image?.sm {
                        KFImage(URL(string: url)!)
                            .resizable()
                            .frame(width: 80, height: 60)
                            .cornerRadius(5)
                    }
                    
                    Text(item.name)
                        .font(Font.headline.weight(.bold))
                    Spacer()
                }
            }
            
            if services(item).count > 2 {
                HStack {
                    Button(showAll ? "Show less services":"Show more services") {
                        showAll = !showAll
                    }
                    Spacer()
                }
            }
        }
    }
    
    private func services(_ item: Item) -> [Item.Service] {
        return showAll ? item.services : Array(item.services.prefix(3))
    }
}
