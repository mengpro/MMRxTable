//
//  AudioModel.swift
//  MMRxTable
//
//  Created by 蒙朦 on 2018/3/7.
//  Copyright © 2018年 蒙朦. All rights reserved.
//

import Foundation
import ObjectMapper

typealias MMModelProtocol = ObjectMapper.Mappable
typealias MMMapper = ObjectMapper.Mapper

enum MessageSendSuccessType: Int {
    case success = 0
    case failed
    case sending
}

class AudioModel: NSObject, MMModelProtocol {
    var audioId : String?
    var audioURL : String?
    var bitRate : String?
    var channels : String?
    var createTime : String?
    var duration : Float?
    var fileSize : String?
    var formatName : String?
    var keyHash : String?
    var mimeType : String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        audioId <- map["audio_id"]
        audioURL <- map["audio_url"]
        bitRate <- map["bit_rate"]
        channels <- map["channels"]
        createTime <- map["ctime"]
        duration <- (map["duration"], TransformerStringToFloat)
        fileSize <- map["file_size"]
        formatName <- map["format_name"]
        keyHash <- map["key_hash"]
        mimeType <- map["mime_type"]
    }
}

let TransformerStringToFloat = TransformOf<Float, String>(fromJSON: { (value: String?) -> Float? in
    guard let value = value else {
        return 0
    }
    let intValue: Float? = Float(value)
    return intValue
}, toJSON: { (value: Float?) -> String? in
    if let value = value {
        return String(value)
    }
    return nil
})


