//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by Justin on 9/10/14.
//
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    var moviesArray: NSArray?
    var refresh : UIRefreshControl?
    var spinner : MONActivityIndicatorView?
    
    override func viewDidAppear(animated: Bool) {
        if let indexPath = self.moviesTableView.indexPathForSelectedRow() {
            self.moviesTableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner = MONActivityIndicatorView()
        spinner!.center = self.view.center;
        self.view.addSubview(spinner!)
        
        loadApiData()
        
        refresh = UIRefreshControl()
        refresh!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh!.addTarget(self, action: "loadApiData", forControlEvents:.ValueChanged)
        self.moviesTableView.addSubview(refresh!)
    }
    
    func loadApiData() {
        spinner!.startAnimating()
        
        let YourApiKey = "ag2hjqnumwdh3p8kery2q57p" // Fill with the key you registered at http://developer.rottentomatoes.com
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        request.timeoutInterval = 5.0
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            if error != nil {
                CSNotificationView.showInViewController(self, style: CSNotificationViewStyleError, message: "Unable to load")
                
                self.refresh?.endRefreshing()
                self.spinner?.stopAnimating()
                return
            }
            
            var errorValue: NSError? = nil
            let parsedResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue)
            if parsedResult != nil {
                let dictionary = parsedResult! as NSDictionary
                self.moviesArray = dictionary["movies"] as? NSArray
                self.moviesTableView.reloadData()
            } else {
                CSNotificationView.showInViewController(self, style: CSNotificationViewStyleError, message: "Unable to load")
            }
            
            self.refresh?.endRefreshing()
            self.spinner?.stopAnimating()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesArray != nil {
            return moviesArray!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell")! as MovieTableViewCell
        let moviesDictionary = moviesArray![indexPath.row] as NSDictionary
        cell.movieTitleLabel.text = moviesDictionary["title"] as NSString
        let movieRating = moviesDictionary["mpaa_rating"] as NSString
        let movieDescription = moviesDictionary["synopsis"] as NSString
        let postersDictionary = moviesDictionary["posters"] as NSDictionary
        let movieThumbnail = postersDictionary["thumbnail"] as NSString
        cell.movieDescriptionLabel.text = "\(movieRating) \(movieDescription)"
        
        let url = NSURL(string: movieThumbnail)
        let request = NSURLRequest(URL: url)
        
        cell.thumnailImage.alpha = 0.0
        cell.thumnailImage.setImageWithURLRequest(request, placeholderImage: nil, success: { [weak cell] request, response, image in
            if (cell != nil) {
                cell!.thumnailImage.image = image
                UIView.animateWithDuration(1.0, animations: {
                    cell!.thumnailImage.alpha = 1.0
                })
            }
            
            let visibleCells = tableView.visibleCells() as NSArray
            
            if visibleCells.containsObject(cell!) {
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
            }
            }, failure:nil)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("movieDetailsSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "movieDetailsSegue") {
            let indexPath = self.moviesTableView.indexPathForSelectedRow()
            let selectedIndex = indexPath!.row
            
            let movieDetailsViewController:MovieDetailsViewController = segue.destinationViewController as MovieDetailsViewController
            var movieDictionary = moviesArray![selectedIndex] as NSDictionary
            movieDetailsViewController.setMovieDictionary(movieDictionary)
            let cell = self.moviesTableView.cellForRowAtIndexPath(indexPath!) as MovieTableViewCell
            let thumbnailImageView = cell.thumnailImage
            movieDetailsViewController.thumbnailImage = thumbnailImageView.image
        }
    }
}
