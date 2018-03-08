//
//  AudioCell.swift
//  MMRxTable
//
//  Created by 蒙朦 on 2018/3/7.
//  Copyright © 2018年 蒙朦. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import RxBlocking

private let voiceIconMargin: CGFloat = 16//播放小图标距离气泡箭头的值
private let voiceMaxWidth: CGFloat = 200
let avatarLeft: CGFloat = 10
let avatarTop: CGFloat = 0
let avatarWidth: CGFloat = 40

class AudioCell: UITableViewCell {
    
    // IBOutlet
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var voiceBtn: UIButton! {
        didSet {
            voiceBtn.imageView?.animationDuration = 1
            voiceBtn.isSelected = false
        }
    }
    @IBOutlet weak var durationLabel: UILabel!
    
    // Variables
    weak var delegate: AudioCellDelegate?
    var model: AudioModel?
    let disposeBag = DisposeBag()
    
    // Overrides
    override func prepareForReuse() {
        self.avatarImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        guard let model = self.model else {
            return
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellContent(_ model: AudioModel) {
        self.model = model
        self.durationLabel.text = String(format:"%zd\"", Int(model.duration!))
        self.setNeedsLayout()
    }
    
}
