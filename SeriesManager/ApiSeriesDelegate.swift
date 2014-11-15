//
//  ApiSeriesDelegate.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import Foundation

protocol ApiSeriesDelegate {
    func success(seriesList: [Series])
    func failure(error: NSError)
}