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
    
    // Base url
    static let baseURL = "http://thetvdb.com"
    
    // Enum members
    case Root
    case SearchSeries(String, String)
    case GetSeries(String, Int, String)
    case GetImage(String)
 
    // MARK: URLStringConvertible
    
    // Computed property that returns an formatted api url.
    var URLString: String {
        let path: String = {
            // Switch the enum member and get the api url.
            switch self {
                case .Root:
                    return "/"
                
                // Url for series-series-request.
                case .SearchSeries(var seriesName, let seriesLanguage):
                    seriesName = seriesName.stringByReplacingOccurrencesOfString(" ", withString: "+").lowercaseString
                    return "/api/GetSeries.php?seriesname=\(seriesName)&language=\(seriesLanguage)"
                
                // Url for get-series-request.
                case .GetSeries(let apiKey, let seriesId, let seriesLanguage):
                    return "/api/\(apiKey)/series/\(seriesId)/all/\(seriesLanguage).xml"
                
                // Url for get-image-request.
                case .GetImage(let imagePath):
                    return "/banners/\(imagePath)"
            }
        }()
        
        // Combine base url with path selected above.
        return TheTVDBApiMethods.baseURL + path
    }
    
}