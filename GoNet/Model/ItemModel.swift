//
//  ItemModel.swift
//  GoNet
//
//  Created by Carlos Ruiz on 20/07/20.
//  Copyright © 2020 CERR. All rights reserved.
//

import UIKit

struct ItemModel{
    var title: String
    var description: String
    var imageURL: URL?
}

extension ItemModel: Codable {
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let imageString = try container.decodeIfPresent(String.self, forKey: .image),
            let url = URL(string:imageString){
            imageURL = url
        }
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(title, forKey: .title)
        try container.encode(imageURL?.absoluteString ?? "", forKey: .image)
        try container.encode(description, forKey: .description)
    }
}
