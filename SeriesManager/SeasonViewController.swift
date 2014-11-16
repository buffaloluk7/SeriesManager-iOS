//
//  SeasonViewController.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import UIKit

class SeasonViewController: UITableViewController {

    var season: Season!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Season \(season.number!)"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.season.episodes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("episodeCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let episode = self.season.episodes[indexPath.row]
        cell.textLabel.text = episode.name
        cell.detailTextLabel?.text = String(episode.number!)

        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showEpisodeSegue":
                // Get selected series.
                let cell = sender as UITableViewCell
                let indexPath = self.tableView.indexPathForSelectedRow()
                let selectedEpisode = self.season.episodes[indexPath!.row]
                
                // Pass series to view controller
                let viewController = segue.destinationViewController as EpisodeViewController
                viewController.episode = selectedEpisode
                
            default:
                break
            }
        }
    }

}
