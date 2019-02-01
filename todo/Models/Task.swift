//
//  Task.swift
//  todo
//
//  Created by 中村太一 on 2019/01/19.
//  Copyright © 2019 中村太一. All rights reserved.
//

import Foundation

class Task:Codable {
    var title: String = ""
    var note: String = ""
    
    enum CodingKeys: String, CodingKey {
        case title
        case note
    }
    
    init () {
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.note = try container.decode(String.self, forKey: .note)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(note, forKey: .note)
    }
}
