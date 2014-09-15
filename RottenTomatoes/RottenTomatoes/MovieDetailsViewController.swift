//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Justin on 9/14/14.
//
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movieDictionary: NSDictionary = NSDictionary()
    var movieTitle : NSString = ""
    var year : NSInteger = 0
    var criticsScore : NSInteger = 0
    var audienceScore : NSInteger = 0
    var mpaaRating : NSString = ""
    var synopsis : NSString = ""
    var posterImageUrl : NSString = ""
    var thumbnailImage : UIImage?
    
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movieTitle
        self.detailsTextView.text = "\(movieTitle) (\(year))\nCritics Score: \(criticsScore), Audience Score: \(audienceScore)\nMPAA Rating: \(mpaaRating)\n\n\(synopsis)"
        
        self.posterImageView.image = thumbnailImage
        
        let url = NSURL(string: posterImageUrl)
        let request = NSURLRequest(URL: url)
        self.posterImageView.setImageWithURLRequest(request, placeholderImage: nil, success: { (request, response, image) -> Void in
            self.posterImageView.image = image
            }) { (request, response, error) -> Void in
                
        }
    }
    
    func setMovieDictionary(dict: NSDictionary) {
        movieDictionary = dict
        movieTitle = movieDictionary["title"] as NSString
        mpaaRating = movieDictionary["mpaa_rating"] as NSString
        var postersDictionary = movieDictionary["posters"] as NSDictionary
        let posterThumbnailImageUrl = postersDictionary["thumbnail"] as NSString
        posterImageUrl = posterThumbnailImageUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        var ratingsDictionary = movieDictionary["ratings"] as NSDictionary
        audienceScore = ratingsDictionary["audience_score"] as NSInteger
        criticsScore = ratingsDictionary["critics_score"] as NSInteger
        year = movieDictionary["year"] as NSInteger
        synopsis = movieDictionary["synopsis"] as NSString
    }
}
