//
//  Network.swift
//  MMRxTable
//
//  Created by 蒙朦 on 2018/2/27.
//  Copyright © 2018年 蒙朦. All rights reserved.
//

import Foundation
import Moya

let MMNetwork = MoyaProvider<MMNetworkTool>()

public enum MMNetworkTool {
    case data(size: Int, index: Int)
}

extension MMNetworkTool: TargetType {
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var baseURL: URL {
        return URL(string: "http://gank.io/api/data/")!
    }
    
    public var path: String {
        switch self {
        case .data(let size, let index):
            return "iOS/\(size)/\(index)"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var sampleData: Data {
        return "Mengmeng".data(using: .utf8)!
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    var validate: Bool {
        return false
    }
}
