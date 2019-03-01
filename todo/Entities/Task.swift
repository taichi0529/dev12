//
//  Task.swift
//  todo
//
//  Created by 中村太一 on 2019/01/19.
//  Copyright © 2019 中村太一. All rights reserved.
//

import Foundation

// CodableにすることによりUserDefaultsへエンコード出来るようになっている
class Task:Codable {
    var id: String?
    var title: String = ""
    var note: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    init() {
        
    }
    init(data: [String: Any]) {
        if let title = data["title"] as? String {
            self.title = title
        }
        if let note = data["note"] as? String {
            self.note = note
        }
        if let latitude = data["latitude"] as? Double {
            self.latitude = latitude
        }
        if let longitude = data["longitude"] as? Double {
            self.longitude = longitude
        }
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "title": self.title,
            "note": self.note,
            "latitude": self.latitude,
            "longitude": self.longitude
        ]
    }
}
