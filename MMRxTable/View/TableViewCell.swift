//
//  TableViewCell.swift
//  MMRxTable
//
//  Created by 蒙朦 on 2018/2/27.
//  Copyright © 2018年 蒙朦. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var user: User? {
        willSet {
            textLabel?.text = user?.name
            textLabel?.numberOfLines = 0
        }
    }

}
