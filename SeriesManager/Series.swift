//
//  Series.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import Foundation

class Series {
    
    init() {}

    var id: Int?
    var name: String?
    var bannerPath: String?
    var overview: String?
    var firstAired: String?
    var seasons: [Season] = []

}