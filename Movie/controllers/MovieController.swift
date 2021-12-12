//
//  ViewController.swift
//  Movie
//
//  Created by Nyi Ye Han on 12/12/2021.
//

import UIKit

class MovieViewController: UIViewController ,ItemDelegate{
    
    
    func onItemClick(data: Movie?) {
        if let movie = data {
            print(movie.title ?? "")
            performSegue(withIdentifier: "detail", sender: movie)
        }
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detail"){
            let vc = segue.destination as! DetailViewController
            vc.movie = sender as! Movie
        }
            
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let cell = "cellId"
    private let largeCell = "largeCellId"
    var movieCategoryList : [MovieCategory]?
    var timer :Timer?
    var currentIndex = 0
    var movieCategory : MovieCategory?

    override func viewWillAppear(_ animated: Bool) {
        ApiManager.shared.getPopular(url: "") { post in
            self.movieCategoryList?.append(post)
            self.collectionView?.reloadData()
        } onError: { error in
            print(error)
        }
        
        ApiManager.shared.getTopRated(url: "") { post in
            
            self.movieCategoryList?.append(post)
            self.collectionView?.reloadData()
            
        } onError: { error in
            print(error)
        }
        
        ApiManager.shared.getUpcoming(url: "") { post in
            
            self.movieCategoryList?.append(post)
            self.collectionView?.reloadData()
            
        } onError: { error in
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movie"
        movieCategoryList = [MovieCategory]()
        
       


        
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cell)
        collectionView.register(LargeCell.self, forCellWithReuseIdentifier: largeCell)
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        
        collectionView.backgroundColor = .black
        
        
        
        // Do any additional setup after loading the view.
    }


}
extension MovieViewController:UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if let count = movieCategoryList?.count{
                return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.item == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCell, for: indexPath) as! LargeCell
            cell.category = movieCategoryList?[indexPath.item]
            cell.itemDelegate = self
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as! CategoryCell
        cell.category = movieCategoryList?[indexPath.item]
        cell.itemDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: 240)
        }
        return CGSize(width: view.frame.width, height: 280)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("title")
    }
}






