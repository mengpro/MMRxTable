//
//  Music.swift
//  MMRxTable
//
//  Created by 蒙朦 on 2018/2/27.
//  Copyright © 2018年 蒙朦. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

extension User: CustomStringConvertible {
    var description: String {
        return "name: \(name) age: \(age)"
    }
}
