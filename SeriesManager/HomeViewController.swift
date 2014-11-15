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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Search bar delegte
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.theTVDBApi.getSeriesListByName(searchBar.text)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.seriesList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("seriesCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell.
        cell.textLabel.text = self.seriesList[indexPath.row].name
        cell.detailTextLabel?.text = "2004"
        
        return cell
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
    
    func didReceiveSeriesList(seriesList: [Series]) {
        Logger.log("Update tableview data.")
        self.seriesList = seriesList
        self.tableView.reloadData()
    }

}
