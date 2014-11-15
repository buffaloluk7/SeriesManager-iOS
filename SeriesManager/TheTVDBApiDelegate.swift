//
//  ApiSeriesListDelegate.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import Foundation

@objc protocol TheTVDBApiDelegate {
    optional func didReceiveSeriesList(series: [Series])
    optional func didReceiveSeries(series: Series)
    optional func didReceiveImage(image: String)
    optional func didReceiveAPIError(error: NSError)
}