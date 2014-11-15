//
//  TheTVDBApiMethod.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import Foundation
import Alamofire

enum TheTVDBApiMethods: URLStringConvertible {
    
    static let baseURL = "http://thetvdb.com"
    
    case Root
    case SearchSeries(String, String)
    case GetSeries(String, Int, String)
 
    // MARK: URLStringConvertible
    
    var URLString: String {
        let path: String = {
            switch self {
                case .Root:
                    return "/"
                
                case .SearchSeries(var seriesName, let seriesLanguage):
                    seriesName = seriesName.stringByReplacingOccurrencesOfString(" ", withString: "+").lowercaseString
                    return "/api/GetSeries.php?seriesname=\(seriesName)&language=\(seriesLanguage)"
                
                case .GetSeries(let apiKey, let seriesId, let seriesLanguage):
                    return "/api/\(apiKey)/series/\(seriesId)/all/\(seriesLanguage).xml"
            }
        }()
        
        return TheTVDBApiMethods.baseURL + path
    }
    
}