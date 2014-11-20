//
//  Episode.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import Foundation

class Episode: NSObject {
  
    var id: Int?
    var seriesId: Int?
    var number: Int?
    var seasonNumber: Int?
    var name: String?
    var overview: String?
    var firstAired: NSDate?
    var imagePath: String?
    
}