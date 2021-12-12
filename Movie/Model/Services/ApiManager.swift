//
//  ApiManager.swift
//  Movie
//
//  Created by Nyi Ye Han on 12/12/2021.
//

import Foundation
import Alamofire
class ApiManager{
    
    
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static var shared = ApiManager()
    
    enum EndPoint{
        case getMovieDetail
        case getPopular
        case getUpComing
        case getTopRated
        case getVideo
        
        func url(_ postid:Int? = nil  ) -> URL {
            switch(self){
            case    .getMovieDetail: return URL(string: baseURL +  String( postid ?? 0)  + "?api_key=aeaf2cd9a61dac3783f6ca8367e12654&language=en-US" )!
            case .getPopular:
                return URL(string: baseURL + "popular?api_key=aeaf2cd9a61dac3783f6ca8367e12654&language=en-US&page=1")!
            case .getUpComing:
                return  URL(string: baseURL + "now_playing?api_key=aeaf2cd9a61dac3783f6ca8367e12654&language=en-US&page=1")!
            case .getTopRated:
                return URL(string: baseURL + "upcoming?api_key=aeaf2cd9a61dac3783f6ca8367e12654&language=en-US&page=1")!
            case .getVideo:
                return URL(string: baseURL +  String( postid ?? 0)  + "/videos?api_key=aeaf2cd9a61dac3783f6ca8367e12654&language=en-US" )!
            }
        }
        
        var method: HTTPMethod {
            switch(self){
            case .getMovieDetail: return .get
            case .getPopular : return .get
            case .getUpComing : return .get
            case .getTopRated : return .get
            case .getVideo: return .get
                
            }
        }
    }
    
    
    
    func getVideo(id:Int , onSuccess:( (_ movie: Movie )  ->  (Void) )? = nil , onError: ((_ status:Bool)->(Void))? = nil     ) {
        
        print(id)
        
        AF.request( EndPoint.getVideo.url(id).absoluteURL,method: EndPoint.getMovieDetail.method).responseJSON { (response) in
            if (response.error == nil ){
                let movie = Movie()
                let responseData = response.value as? [String:Any]
                
                print("success api video")
                print(EndPoint.getVideo.url(id).absoluteURL)
                print(responseData)
                
                for videoList in responseData?["results"] as! [[String : Any]] {
                    
                    if let video = videoList["key"] as? String{
                        movie.key = video
                        print("you tube key :::: \(video)")
                        break
                    }
                }
                //
                
                print("success api")
                onSuccess?(movie)
            } else {
                print("fail api")
                onError?(false)
            }
        }
    }
    
    
    func getUpcoming(url :String,onSuccess:( (_ post: MovieCategory )  ->  (Void) )? = nil , onError: ((_ error:AFError)->(Void))? = nil  ) {
        
        
        
        AF.request( EndPoint.getTopRated.url(),method: EndPoint.getMovieDetail.method).responseJSON { (response) in
            if (response.error == nil ){
                let data = response.value as? [String:Any]
                let movieCategory = MovieCategory()
                
                movieCategory.name = "Upcoming"
                
                var movieList = [Movie]()
                for dict in data?["results"] as! [[String : Any]]{
                    let movie = Movie()
                    
                    
                    if let id = dict["id"] as? Int, let title = dict["title"] as? String, let path = dict["poster_path"] as? String {
                        movie.title = title
                        movie.id = id
                        movie.poster_path = path
                        
                        movieList.append(movie)
                    }
                    
                }
                
                movieCategory.movieList = movieList
                
                print("success")
                onSuccess?(movieCategory)
            } else {
                print("fail api")
                onError?(response.error!)
            }
        }
    }
    
    func getTopRated(url :String,onSuccess:( (_ post: MovieCategory )  ->  (Void) )? = nil , onError: ((_ error:AFError)->(Void))? = nil  ) {
        
        
        
        AF.request( EndPoint.getTopRated.url(),method: EndPoint.getMovieDetail.method).responseJSON { (response) in
            if (response.error == nil ){
                let data = response.value as? [String:Any]
                let movieCategory = MovieCategory()
                
                movieCategory.name = "TopRated"
                
                var movieList = [Movie]()
                for dict in data?["results"] as! [[String : Any]]{
                    let movie = Movie()
                    
                    
                    if let id = dict["id"] as? Int, let title = dict["title"] as? String, let path = dict["poster_path"] as? String {
                        movie.title = title
                        movie.id = id
                        movie.poster_path = path
                        
                        movieList.append(movie)
                    }
                    
                }
                
                movieCategory.movieList = movieList
                
                print("success")
                onSuccess?(movieCategory)
            } else {
                print("fail api")
                onError?(response.error!)
            }
        }
    }
    
    
    func getPopular(url :String,onSuccess:( (_ post: MovieCategory )  ->  (Void) )? = nil , onError: ((_ error:AFError)->(Void))? = nil  ) {
        
        
        
        AF.request( EndPoint.getPopular.url(),method: EndPoint.getMovieDetail.method).responseJSON { (response) in
            if (response.error == nil ){
                let data = response.value as? [String:Any]
                let movieCategory = MovieCategory()
                
                movieCategory.name = "Popular"
                
                var movieList = [Movie]()
                for dict in data?["results"] as! [[String : Any]]{
                    let movie = Movie()
                    
                    
                    if let id = dict["id"] as? Int, let title = dict["title"] as? String, let path = dict["poster_path"] as? String {
                        movie.title = title
                        movie.id = id
                        movie.poster_path = path
                        
                        movieList.append(movie)
                    }
                    
                }
                
                movieCategory.movieList = movieList
                
                print("success")
                onSuccess?(movieCategory)
            } else {
                print("fail api")
                onError?(response.error!)
            }
        }
    }
    
    
    func getMovieDetail(id:Int , onSuccess:( (_ movie: Movie )  ->  (Void) )? = nil , onError: ((_ status:Bool)->(Void))? = nil     ) {
        
        AF.request( EndPoint.getMovieDetail.url(id).absoluteURL,method: EndPoint.getMovieDetail.method).responseJSON { (response) in
            if (response.error == nil ){
                let movie = Movie()
                let responseData = response.value as? [String:Any]
                if let release_date = responseData?["release_date"] as? String,
                   let desc = responseData?["overview"] as? String,
                   let status = responseData?["status"] as? String {
                    movie.release_date = release_date
                    movie.status = status
                    movie.overview = desc
                    
                }
                print("success api")
                onSuccess?(movie)
            } else {
                print("fail api")
                onError?(false)
            }
        }
    }
    
    
    
}
