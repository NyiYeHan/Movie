//
//  LargeCell.swift
//  Movie
//
//  Created by Nyi Ye Han on 12/12/2021.
//

import UIKit

class LargeCell: CategoryCell {
    
    
    override func setUpView() {
        super.setUpView()
        appCollectionView.register(LargeAppCell.self, forCellWithReuseIdentifier: "largeCellId")
        
    }
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "largeCellId", for: indexPath) as! LargeAppCell
        cell.movie = category?.movieList?[indexPath.item]
        return cell

    }
    
    
//  override  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = appCollectionView.dequeueReusableCell(withReuseIdentifier: "largeCellId", for: indexPath) as! AppCell
//        cell.movie = category?.movieList?[indexPath.item]
//        return cell
//
//    }
    
   override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: frame.width, height: 200)
       
    }
    
    class LargeAppCell : AppCell{
        override func setupView() {
            imgageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imgageView)

            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":imgageView]))

            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[v0]-14-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":imgageView]))

        }
    }
    
    
   
}
