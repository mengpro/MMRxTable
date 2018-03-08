//
//  AudioCellDelegate.swift
//  MMRxTable
//
//  Created by 蒙朦 on 2018/3/7.
//  Copyright © 2018年 蒙朦. All rights reserved.
//

import Foundation

@objc protocol AudioCellDelegate: class {
    /**
     点击了 cell 本身
     */
    @objc optional func cellDidTapped(_ cell: AudioCell)
    
    /**
     点击了声音 cell 的播放 button
     */
    func audioCellDidTapped(_ cell: AudioCell, isPlaying: Bool)
}
