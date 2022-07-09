//
//  Item.swift
//  CodeChallenge
//
//  Created by emile on 01/07/2022.
//

import Foundation

struct Item: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case services = "service_types"
    }
    
    struct Service: Codable {
        
        enum CodingKeys: String, CodingKey {
            case name
            case image = "image_thumb_url"
        }
        
        struct Image: Codable {
            let sm: String
        }
        
        let name: String
        let image: Service.Image?
    }
    
    let name: String
    let services: [Item.Service]
}
