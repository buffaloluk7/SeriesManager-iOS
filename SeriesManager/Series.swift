//
//  Series.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import Foundation

class Series: NSObject {

    var id: Int?
    var name: String?
    var overview: String?
    var firstAired: NSDate?
    var bannerPath: String?
    var fanartPath: String?
    var posterPath: String?
    var seasons: [Season] = []

}