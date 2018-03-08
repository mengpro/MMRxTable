//
//  RecordViewController.swift
//  MMRxTable
//
//  Created by 蒙朦 on 2018/3/7.
//  Copyright © 2018年 蒙朦. All rights reserved.
//

import UIKit
import TimedSilver
import SwiftyJSON
import SnapKit
import RxSwift

class RecordViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    lazy var listTableView: UITableView = {
        let listTableView = UITableView(frame: CGRect.zero, style: .plain)
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.backgroundColor = UIColor.clear
        listTableView.separatorStyle = .none
        return listTableView
    }()
    @IBOutlet weak var recordBtn: UIButton!
    var voiceIndicatorView: AudioIndicatorView!
    var itemDataSource = [AudioModel]()
    var currentVoiceCell: AudioCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTableView.ts_registerCellNib(AudioCell.self)
        
        self.setupSubviews()
        self.setupRecordBtn()
        
        AudioRecordInstance.delegate = self
        AudioPlayInstance.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AudioRecordInstance.checkPermissionAndSetupRecord()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        AudioPlayInstance.stopPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupSubviews() {
        self.view.addSubview(self.listTableView)
        self.listTableView.snp.makeConstraints{ (make) -> Void in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(self.recordBtn.snp.top)
        }
        self.voiceIndicatorView = UIView.ts_viewFromNib(AudioIndicatorView.self)
        self.view.addSubview(self.voiceIndicatorView)
        self.voiceIndicatorView.snp.makeConstraints{ [weak self] (make) -> Void in
            guard let strongSelf = self else { return }
            make.top.equalTo(strongSelf.view.snp.top).offset(100)
            make.left.equalTo(strongSelf.view.snp.left)
            make.bottom.equalTo(strongSelf.view.snp.bottom).offset(-100)
            make.right.equalTo(strongSelf.view.snp.right)
        }
        self.voiceIndicatorView.isHidden = true
    }
    
    func setupRecordBtn() {
        var finishRecording: Bool = true
        let longTap = UILongPressGestureRecognizer()
        recordBtn.addGestureRecognizer(longTap)
        longTap.rx.event.subscribe { [weak self] _ in
            guard let strongSelf = self else { return }
            if longTap.state == .began { //长按开始
                finishRecording = true
                strongSelf.voiceIndicatorView.recording()
                AudioRecordInstance.startRecord()
                strongSelf.recordBtn.replaceRecordButtonUI(isRecording: true)
            } else if longTap.state == .changed { //长按平移
                let point = longTap.location(in: self!.voiceIndicatorView)
                if strongSelf.voiceIndicatorView.point(inside: point, with: nil) {
                    strongSelf.voiceIndicatorView.slideToCancelRecord()
                    finishRecording = false
                } else {
                    strongSelf.voiceIndicatorView.recording()
                    finishRecording = true
                }
            } else if longTap.state == .ended { //长按结束
                if finishRecording {
                    AudioRecordInstance.stopRecord()
                } else {
                    AudioRecordInstance.cancelRrcord()
                }
                strongSelf.voiceIndicatorView.endRecord()
                strongSelf.recordBtn.replaceRecordButtonUI(isRecording: false)
            }
        }.disposed(by: disposeBag)
    }
    
    func sendVoice(_ audioModel: AudioModel) {
        dispatch_async_safely_to_main_queue({ [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.itemDataSource.append(audioModel)
            let insertIndexPath = IndexPath(row: strongSelf.itemDataSource.count - 1, section: 0)
            strongSelf.listTableView.insertRows(at: [insertIndexPath], with: .fade)
        })
    }
}

extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemDataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.itemDataSource[indexPath.row]
        let cell: AudioCell = tableView.ts_dequeueReusableCell(AudioCell.self)
        cell.delegate = self
        cell.setCellContent(model)
        return cell
    }
}

extension UIButton {
    func replaceRecordButtonUI(isRecording: Bool) {
        if isRecording {
            self.ts_setBackgroundColor(UIColor.init(ts_hexString: "#C6C7CB"), forState: .normal)
            self.ts_setBackgroundColor(UIColor.init(ts_hexString: "#F3F4F8"), forState: .highlighted)
        } else {
            self.ts_setBackgroundColor(UIColor.init(ts_hexString: "#F3F4F8"), forState: .normal)
            self.ts_setBackgroundColor(UIColor.init(ts_hexString: "#C6C7CB"), forState: .highlighted)
        }
    }
}

extension RecordViewController: RecordAudioDelegate {
    func audioRecordUpdateMetra(_ metra: Float) {
        self.voiceIndicatorView.updateMetersValue(metra)
    }
    
    func audioRecordTooShort() {
        self.voiceIndicatorView.messageTooShort()
    }
    
    func audioRecordFinish(_ uploadAmrData: Data, recordTime: Float, fileHash: String) {
        self.voiceIndicatorView.endRecord()
        
        let audioModel = AudioModel()
        audioModel.keyHash = fileHash
        audioModel.audioURL = ""
        audioModel.duration = recordTime
        self.sendVoice(audioModel)
    }
    
    func audioRecordFailed() {
        TSAlertView_show("录音失败，请重试")
    }
    
    func audioRecordCanceled() {
        
    }
}

extension RecordViewController: PlayAudioDelegate {
    func audioPlayStart() {
        
    }
    
    func audioPlayFinished() {
        self.currentVoiceCell.resetVoiceAnimation()
    }
    
    func audioPlayFailed() {
        self.currentVoiceCell.resetVoiceAnimation()
    }
    
    func audioPlayInterruption() {
        self.currentVoiceCell.resetVoiceAnimation()
    }
}

extension RecordViewController: AudioCellDelegate {
    func cellDidTapped(_ cell: AudioCell) {
        
    }
    
    func audioCellDidTapped(_ cell: AudioCell, isPlaying: Bool) {
        if self.currentVoiceCell != nil && self.currentVoiceCell != cell {
            self.currentVoiceCell.resetVoiceAnimation()
        }
        
        if isPlaying {
            self.currentVoiceCell = cell
            guard let audioModel = cell.model else {
                AudioPlayInstance.stopPlayer()
                return
            }
            AudioPlayInstance.startPlaying(audioModel)
        } else {
            AudioPlayInstance.stopPlayer()
        }
    }
}
