//
//  AudioIndicatorView.swift
//  MMRxTable
//
//  Created by 蒙朦 on 2018/3/7.
//  Copyright © 2018年 蒙朦. All rights reserved.
//

import UIKit

class AudioIndicatorView: UIView {

    @IBOutlet weak var centerView: UIView! {
        didSet {
            centerView.layer.cornerRadius = 4.0
            centerView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var noteLabel: UILabel! {
        didSet {
            noteLabel.layer.cornerRadius = 2.0
            noteLabel.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var cancelImageView: UIImageView!
    @IBOutlet weak var tooShortImageView: UIImageView!
    @IBOutlet weak var recordingView: UIView!
    @IBOutlet weak var volumeImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension AudioIndicatorView {
    func recording() {
        self.isHidden = false
        self.cancelImageView.isHidden = true
        self.tooShortImageView.isHidden = true
        self.recordingView.isHidden = false
        self.noteLabel.backgroundColor = UIColor.clear
        self.noteLabel.text = "上滑取消发送"
    }
    
    func volumeDidChanged(_ value: CGFloat) {
        var index = Int(round(value))
        index = index > 7 ? 7 : index
        index = index < 0 ? 0 : index
        
        let array = [
            UIImage(named: "RecordingSignal001"),
            UIImage(named: "RecordingSignal002"),
            UIImage(named: "RecordingSignal003"),
            UIImage(named: "RecordingSignal004"),
            UIImage(named: "RecordingSignal005"),
            UIImage(named: "RecordingSignal006"),
            UIImage(named: "RecordingSignal007"),
            UIImage(named: "RecordingSignal008")
        ]
        self.volumeImageView.image = array[index]
    }
    
    func slideToCancelRecord() {
        self.isHidden = false
        self.cancelImageView.isHidden = false
        self.tooShortImageView.isHidden = true
        self.recordingView.isHidden = true
        self.noteLabel.backgroundColor = UIColor.init(ts_hexString: "#9C3638")
        self.noteLabel.text = "松开手指，取消发送"
    }
    
    func messageTooShort() {
        self.isHidden = false
        self.cancelImageView.isHidden = true
        self.tooShortImageView.isHidden = false
        self.recordingView.isHidden = true
        self.noteLabel.backgroundColor = UIColor.clear
        self.noteLabel.text = "说话时间太短"
        let delayTime = DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.endRecord()
        }
    }
    
    func endRecord() {
        self.isHidden = true
    }
    
}
