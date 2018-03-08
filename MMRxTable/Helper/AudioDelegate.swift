//
//  AudioDelegate.swift
//  MMRxTable
//
//  Created by 蒙朦 on 2018/3/8.
//  Copyright © 2018年 蒙朦. All rights reserved.
//

import Foundation

/**
 *  录音的 delegate 函数
 */
protocol RecordAudioDelegate: class {
    /**
     更新进度 , 0.0 - 9.0, 浮点数
     */
    func audioRecordUpdateMetra(_ metra: Float)
    
    
    /**
     录音太短
     */
    func audioRecordTooShort()
    
    
    /**
     录音失败
     */
    func audioRecordFailed()
    
    /**
     取消录音
     */
    func audioRecordCanceled()
    
    /**
     录音完成
     
     - parameter recordTime:        录音时长
     - parameter uploadAmrData:     上传的 amr Data
     - parameter fileHash:          amr 音频数据的 MD5 值 (NSData)
     */
    func audioRecordFinish(_ uploadAmrData: Data, recordTime: Float, fileHash: String)
}



/**
 *  播放的 delegate 函数
 */
protocol PlayAudioDelegate: class {
    /**
     播放开始
     */
    func audioPlayStart()
    
    /**
     播放完毕
     */
    func audioPlayFinished()
    
    /**
     播放失败
     */
    func audioPlayFailed()
    
    
    /**
     播放被中断
     */
    func audioPlayInterruption()
}
