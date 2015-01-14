//
//  EpisodeViewController.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import UIKit
import Haneke

class EpisodeViewController: UIViewController, TheTVDBApiDelegate {

    let theTVDBApi: TheTVDBApi = TheTVDBApi()
    var episode: Episode!
    
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var episodeOverview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the api delegate.
        self.theTVDBApi.apiDelegate = self
        
        // Set overview style.
        episodeOverview.editable = true;
        episodeOverview.font = UIFont(name: "Helvetica", size: 17)
        episodeOverview.editable = false;

        // Set ui properties.
        self.title = episode.name
        self.episodeName.text = episode.name
        self.episodeOverview.text = episode.overview;
        
        // Load and set the episode image.
        if episode.imagePath != nil {
            let imageURL: String = TheTVDBApiMethods.GetImage(episode.imagePath!).URLString
            self.episodeImage.hnk_setImageFromURL(NSURL(string: imageURL)!)
        }
    }

}