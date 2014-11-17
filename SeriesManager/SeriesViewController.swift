//
//  SeriesViewController.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import UIKit

class SeriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TheTVDBApiDelegate {

    let theTVDBApi: TheTVDBApi = TheTVDBApi()
    var series: Series!
    
    @IBOutlet weak var seriesImage: UIImageView!
    @IBOutlet weak var seriesName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.theTVDBApi.apiDelegate = self
        
        // Set UI controls.
        self.title = series.name
        self.seriesName.text = series.name

        // Load the whole series.
        self.theTVDBApi.getSeriesById(series.id!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        cell.textLabel.text = "Season \(season.number!)"
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
        
        // Download the series image.
        if series.fanartPath != nil {
            self.theTVDBApi.getImageByPath(series.fanartPath!)
        }
        
        // Order seasons by their season number.
        series.seasons.sort { $0.number < $1.number }
        
        self.series = series
        self.tableView.reloadData()
    }
    
    func didReceiveImage(image: UIImage?) {
        Logger.log("Set the series image.")
        self.seriesImage.image = image
    }

}
