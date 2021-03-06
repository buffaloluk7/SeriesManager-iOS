//
//  HomeViewController.swift
//  SeriesManager
//
//  Created by Lukas Streiter on 15/11/14.
//  Copyright (c) 2014 Lukas Streiter. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController, UISearchBarDelegate, TheTVDBApiDelegate {

    let theTVDBApi: TheTVDBApi = TheTVDBApi()
    var seriesList: [Series] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.theTVDBApi.apiDelegate = self
    }
    
    // MARK: - Search bar delegte
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.theTVDBApi.getSeriesListByName(searchBar.text)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.seriesList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("seriesCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell.
        let series = self.seriesList[indexPath.row]
        
        if series.firstAired == nil {
            cell.textLabel?.text = series.name
        } else {
            // Get year from NSDate
            let seriesYear = NSCalendar.currentCalendar().component(.CalendarUnitYear, fromDate: series.firstAired!)
            cell.textLabel?.text = "\(series.name!) (\(seriesYear))"
        }
        
        cell.detailTextLabel?.text = series.overview
        
        return cell
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
                case "showSeriesSegue":
                    // Get selected series.
                    let cell = sender as UITableViewCell
                    let indexPath = self.tableView.indexPathForSelectedRow()
                    let selectedSeries = self.seriesList[indexPath!.row]
                    
                    // Pass series to view controller
                    let viewController = segue.destinationViewController as SeriesViewController
                    viewController.series = selectedSeries
        
                default:
                    break
            }
        }
    }
    
    // MARK: - TheTVDBAPI delegates
    
    // Retrieve the series list when call succeeded.
    func didReceiveSeriesList(seriesList: [Series]) {
        Logger.log("Update tableview data.")
        self.seriesList = seriesList
        
        // Reload table view to display retrieved series list.
        self.tableView.reloadData()
    }

}
