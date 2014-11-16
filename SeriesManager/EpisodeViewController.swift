//
//  EpisodeViewController.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController, TheTVDBApiDelegate {

    let theTVDBApi: TheTVDBApi = TheTVDBApi()
    var episode: Episode!
    
    @IBOutlet weak var episodeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.theTVDBApi.apiDelegate = self
        self.title = episode.name
        
        // Load the episode image.
        if episode.imagePath != nil {
            self.theTVDBApi.getImageByPath(episode.imagePath!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didReceiveImage(image: UIImage?) {
        self.episodeImage.image = image
    }

}