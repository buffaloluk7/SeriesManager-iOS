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
                var seasons: [Int: Season] = [:]
                var episodes: [Episode] = []
                
                // Parse the series information.
                series.id = seriesXml["SeriesID"].element?.text?.toInt()
                series.name = seriesXml["SeriesName"].element?.text
                series.overview = seriesXml["Overview"].element?.text;
                series.imagePath = seriesXml["banner"].element?.text;
                series.firstAired = seriesXml["FirstAired"].element?.text;
                
                // Parse the episodes.
                for episodeXml in episodesXml {
                    if episodeXml["SeasonNumber"].element?.text?.toInt() == 0 {
                        continue
                    }
                    
                    let episode = Episode()
                    episode.id = episodeXml["id"].element?.text?.toInt()
                    episode.seriesId = episodeXml["seriesid"].element?.text?.toInt()
                    episode.number = episodeXml["EpisodeNumber"].element?.text?.toInt()
                    episode.seasonNumber = episodeXml["SeasonNumber"].element?.text?.toInt()
                    episode.name = episodeXml["EpisodeName"].element?.text
                    episode.overview = episodeXml["Overview"].element?.text
                    episode.firstAired = episodeXml["FirstAired"].element?.text
                    episode.imagePath = episodeXml["filename"].element?.text
                    
                    // Append the episode to the temporary array of episodes.
                    episodes.append(episode)
                }
                
                // Assign episodes to seasons.
                for episode in episodes {
                    let seasonNumber = episode.seasonNumber!
                    
                    // Add season to dictionary if it does not exist.
                    if seasons[seasonNumber] == nil {
                        let season = Season()
                        season.number = seasonNumber
                        season.seriesId = episode.seriesId
                        seasons.updateValue(season, forKey: seasonNumber)
                    }
                    
                    // Add the episode to the season.
                    seasons[seasonNumber]?.episodes.append(episode)
                }
                
                // Add seasons to the series.
                series.seasons = [Season](seasons.values)

                Logger.log("Call the series delegate")
                self.apiDelegate?.didReceiveSeries?(series)
        }
    }
    
    func getImageByPath(path: String) {
        // TODO: Need to change signature to return an image.
    }
    
}