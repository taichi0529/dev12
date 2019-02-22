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
    var title: String = ""
    var note: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
}
