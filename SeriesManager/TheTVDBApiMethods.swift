//
//  TheTVDBApiMethod.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import Foundation

//enum TheTVDBApiMethods: URLStringConvertible {
enum TheTVDBApiMethods {
    
    static let baseURL = "http://thetvdb.com"
    
    case Root
    case SearchSeries(String, String?)
    case GetSeries(String, Int, String?)
 
    // MARK: URLStringConvertible
    
    var URLString: String {
        let path: String = {
            switch self {
                case .Root:
                    return "/"
                
                case .SearchSeries(let seriesName, let seriesLanguage):
                    //seriesName = seriesName.stringByReplacingOccurrencesOfString(" ", withString: "+").lowercaseString
                    let language = seriesLanguage == nil ? "de" : seriesLanguage!
                    return "/api/GetSeries.php?seriesame=/\(seriesName)&language=\(language)"
                
                case .GetSeries(let apiKey, let seriesId, let seriesLanguage):
                    let language = seriesLanguage == nil ? "de" : seriesLanguage!
                    return "/api/\(apiKey)/series/\(seriesId)/all/\(language).xml"
            }
        }()
        
        return TheTVDBApiMethods.baseURL + path
    }
    
}