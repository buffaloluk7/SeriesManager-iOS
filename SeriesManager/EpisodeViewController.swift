//
//  EpisodeViewController.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {

    var episode: Episode!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = episode.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}