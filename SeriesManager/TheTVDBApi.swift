//
//  TheTVDBApi.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

class TheTVDBApi {
    
    var apiSeriesListDelegate: ApiSeriesListDelegate?
    var apiSeriesDelegate: ApiSeriesDelegate?

    let apiKey: String
    
    init() {
        self.apiKey = "B8489AFD55EF0375"
    }
    
    func getSeriesListByName(name: String) {
        Alamofire.request(.GET, TheTVDBApiMethods.SearchSeries("Dexter", "en"))
            .responseString {(request, response, string, error) in
                // Check for an error.
                if error != nil {
                    self.apiSeriesListDelegate?.failure(error!)
                    return
                }
                
                // Parse the xml.
                let xml = SWXMLHash.parse(string!)
                var seriesList: [Series] = []
                
                for xmlSeries in xml["Data"]["Series"] {
                    let series: Series = Series()
                    series.id = xmlSeries["seriesid"].element?.text?.toInt()
                    series.name = xmlSeries["SeriesName"].element?.text?
                    seriesList.append(series)
                }
                
                self.apiSeriesListDelegate?.success(seriesList)
            }
    }
    
    func getSeriesById(id: Int) {
        // use delegate to return data.
    }
    
    func getImageByPath(path: String) {
        // TODO: Need to change signature to return an image.
    }
    
}