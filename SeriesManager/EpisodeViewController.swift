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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.theTVDBApi.apiDelegate = self
        self.title = episode.name
        self.episodeName.text = episode.name
        
        // Load the episode image.
        if episode.imagePath != nil {
            let imageURL: String = TheTVDBApiMethods.GetImage(episode.imagePath!).URLString
            self.episodeImage.hnk_setImageFromURL(NSURL(string: imageURL)!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didReceiveImage(image: UIImage?) {
        self.episodeImage.image = image
    }

}