//
//  TheTVDBApi.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import Foundation

class TheTVDBApi {
    
    var apiSeriesListDelegate: ApiSeriesListDelegate?
    var apiSeriesDelegate: ApiSeriesDelegate?

    let apiKey: String
    
    init() {
        self.apiKey = "B8489AFD55EF0375"
    }
    
    func getSeriesListByName(name: String) -> [Series] {
        return [
            Series(), Series(), Series()
        ]
    }
    
    func getSeriesById(id: Int) -> Series {
        return Series()
    }
    
    func getImageByPath(path: String) {
        // TODO: Need to change signature to return an image.
    }
    
}