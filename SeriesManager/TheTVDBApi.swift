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
    
    var apiDelegate: TheTVDBApiDelegate?
    let apiKey: String
    let apiLanguage: String
    
    init() {
        self.apiKey = "B8489AFD55EF0375"
        self.apiLanguage = "de"
    }
    
    func getSeriesListByName(name: String) {
        Logger.log("Execte search request.")
        
        Alamofire.request(.GET, TheTVDBApiMethods.SearchSeries(name, self.apiLanguage))
            .responseString {(request, response, string, error) in
                Logger.log("Start parsing list of series.")
                // Check for an error.
                if error != nil {
                    self.apiDelegate?.didReceiveAPIError?(error!)
                    return
                }
                
                // Parse the xml.
                let xml = SWXMLHash.parse(string!)
                var seriesList: [Series] = []
                
                for seriesXml in xml["Data"]["Series"] {
                    let series: Series = Series()
                    series.id = seriesXml["seriesid"].element?.text?.toInt()
                    series.name = seriesXml["SeriesName"].element?.text
                    series.overview = seriesXml["Overview"].element?.text;
                    series.imagePath = seriesXml["banner"].element?.text;
                    series.firstAired = seriesXml["FirstAired"].element?.text;
                    seriesList.append(series)
                }
                
                Logger.log("Call the seriesList delegate")
                self.apiDelegate?.didReceiveSeriesList?(seriesList)
            }
    }
    
    func getSeriesById(id: Int) {
        Logger.log("Execte search request.")
        
        Alamofire.request(.GET, TheTVDBApiMethods.GetSeries(self.apiKey, id, self.apiLanguage))
            .responseString {(request, response, string, error) in
                Logger.log("Start parsing series.")
                // Check for an error.
                if error != nil {
                    self.apiDelegate?.didReceiveAPIError?(error!)
                    return
                }
                
                // Parse the xml.
                let xml = SWXMLHash.parse(string!)
                let seriesXml = xml["Data"]["Series"]
                let episodesXml = xml["Data"]["Episode"]
                
                // Create temporary models to parse the ugly hierarchy.
                let series: Series = Series()
                var seasons: [Season] = []
                var episodes: [Episode] = []
                
                // Parse the series information.
                series.id = seriesXml["SeriesID"].element?.text?.toInt()
                series.name = seriesXml["SeriesName"].element?.text
                series.overview = seriesXml["Overview"].element?.text;
                series.imagePath = seriesXml["banner"].element?.text;
                series.firstAired = seriesXml["FirstAired"].element?.text;
                
                // Parse the episodes.
                for episodeXml in episodesXml {
                    let episode = Episode()
                    episode.id = episodeXml["EpisodeNumber"].element?.text?.toInt()
                    episode.name = episodeXml["EpisodeName"].element?.text
                    episode.overview = episodeXml["Overview"].element?.text
                    episode.firstAired = episodeXml["FirstAired"].element?.text
                    episode.imagePath = episodeXml["filename"].element?.text
                    episode.seasonNumber = episodeXml["SeasonNumber"].element?.text?.toInt()
                    
                    // Append the episode to the temporary array of episodes.
                    episodes.append(episode)
                }
                
                
                // TODO
                
                //episodes.filter(<#includeElement: (T) -> Bool##(T) -> Bool#>)
                
                // Add episodes to seasons array.
                for episode in episodes {
                    
                }

                Logger.log("Call the series delegate")
                self.apiDelegate?.didReceiveSeries?(series)
        }
    }
    
    func getImageByPath(path: String) {
        // TODO: Need to change signature to return an image.
    }
    
}