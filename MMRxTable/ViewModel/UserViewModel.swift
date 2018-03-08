//
//  MusicViewModel.swift
//  MMRxTable
//
//  Created by 蒙朦 on 2018/2/27.
//  Copyright © 2018年 蒙朦. All rights reserved.
//

import Foundation
import RxSwift

struct UserViewModel {
    let data = Observable.just([
        User(name: "Meng", age: 21),
        User(name: "White", age: 23),
        User(name: "Nike", age: 34),
        User(name: "Andy", age: 51),
    ])
    
    let type = Observable.just("Students")
}
