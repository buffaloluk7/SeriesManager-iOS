//
//  Logger.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import Foundation

class Logger {
    
    class func log(message: String, fileName: String = __FILE__, functionName: String = __FUNCTION__) {
        let threadType = NSThread.currentThread().isMainThread ? "main" : "back"
        println("[\(threadType)] [File:\(fileName)] [Line: \(__LINE__)] [Func: \(functionName)] - \(message)\n")
    }
    
}