//
//  DetailViewController.swift
//  Movie
//
//  Created by Nyi Ye Han on 12/12/2021.
//

import UIKit
import youtube_ios_player_helper_swift

class DetailViewController: UIViewController {

    @IBOutlet weak var loadinIndicator: UIActivityIndicatorView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var player : YTPlayerView!
    var movie:Movie = Movie()
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        titleLabel.text = movie.title
    }
    

    override func viewWillAppear(_ animated: Bool) {
         showBusy()
         fetchData()
    }
    func fetchData(){
        
        
        ApiManager.shared.getMovieDetail(id: movie.id!) { result in
            
            
            OperationQueue.main.addOperation {
                self.self.hideBusy()
                self.self.dateLabel.text = result.release_date
                self.self.authorLabel.text = result.status
                self.self.descLabel.text = result.overview
            }
           
        } onError: { status in
            self.hideBusy()
            print("error")
        }
        
        ApiManager.shared.getVideo(id: movie.id!) { result in
            
            OperationQueue.main.addOperation {
                self.self.hideBusy()
                self.self.player.load(videoId: result.key ?? "")
            }
            
        } onError: { status in
            self.hideBusy()
            print("error")
        }
        
    }
    
    func showBusy(){
        loadinIndicator.isHidden = false
        loadinIndicator.startAnimating()
    }
    
    func hideBusy(){
        loadinIndicator.isHidden = true
        loadinIndicator.stopAnimating()
    }

}
