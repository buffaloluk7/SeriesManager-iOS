//
//  SeriesViewController.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import UIKit
import Haneke

class SeriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TheTVDBApiDelegate {

    let theTVDBApi: TheTVDBApi = TheTVDBApi()
    var series: Series!
    
    @IBOutlet weak var seriesImage: UIImageView!
    @IBOutlet weak var seriesName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var seriesGenre: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.theTVDBApi.apiDelegate = self
        
        // Set UI controls.
        self.title = series.name
        self.seriesName.text = series.name

        // Load the whole series.
        self.theTVDBApi.getSeriesById(series.id!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        // Deselect previously selected row here so that the user sees a glimpse of the previous selection when they return.
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.series.seasons.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("seasonCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let season = self.series.seasons[indexPath.row]
        cell.textLabel?.text = "Season \(season.number!)"
        cell.detailTextLabel?.text = "\(season.episodes.count) Episodes"

        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showSeasonSegue":
                // Get selected series.
                let cell = sender as UITableViewCell
                let indexPath = self.tableView.indexPathForSelectedRow()
                let selectedSeason = self.series.seasons[indexPath!.row]
                
                // Pass series to view controller
                let viewController = segue.destinationViewController as SeasonViewController
                viewController.season = selectedSeason
                
            default:
                break
            }
        }
    }
    
    // MARK: - TheTVDBAPI delegates
    
    func didReceiveSeries(series: Series) {
        Logger.log("Update tableview data.")
        
        // Load and set the series image.
        if series.fanartPath != nil {
            //self.theTVDBApi.getImageByPath(series.fanartPath!)
            let imageURL: String = TheTVDBApiMethods.GetImage(series.fanartPath!).URLString
            self.seriesImage.hnk_setImageFromURL(NSURL(string: imageURL)!)
        }
        
        // Order seasons by their season number.
        series.seasons.sort { $0.number < $1.number }
        self.seriesGenre.text = ", ".join(series.genre)
        
        self.series = series
        self.tableView.reloadData()
    }

}
