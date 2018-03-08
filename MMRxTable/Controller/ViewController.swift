//
//  ViewController.swift
//  MMRxTable
//
//  Created by 蒙朦 on 2018/2/27.
//  Copyright © 2018年 蒙朦. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableTitle: UILabel!
    
    let userViewModel = UserViewModel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModel.data.bind(to: tableView.rx.items(cellIdentifier: "userCell")) { _, user, cell in
            cell.textLabel?.text = user.name
            cell.detailTextLabel?.text = String(user.age)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(User.self).subscribe(onNext: { user in
            print("你选中的人为：\(user)")
        }).disposed(by: disposeBag)
        
        userViewModel.type.bind(to: tableTitle.rx.text).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

