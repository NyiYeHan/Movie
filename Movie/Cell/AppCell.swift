//
//  AppCell.swift
//  Movie
//
//  Created by Nyi Ye Han on 12/12/2021.
//

import UIKit
import Kingfisher


class AppCell: UICollectionViewCell {
    
    var movie : Movie?{
        didSet{
            if let name = movie?.title {
                label.text = name
            }
            if let url = movie?.poster_path {
                let pathUrl = "https://image.tmdb.org/t/p/w500\(url)"
                let newUrl = URL(string: pathUrl)
                
                self.imgageView.kf.setImage(with: newUrl)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //create new image
    let imgageView : UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "cover")
        iv.contentMode = .scaleAspectFill
//        iv.layer.cornerRadius = 75
//        iv.layer.masksToBounds = true
        return iv
    }()
    
    // create new label
    
    let label : UILabel = {
       let label = UILabel()
        label.text = "Elite Elite Elite Elite Elite Elite "
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 2
        return label
        
        
    }()
    
   
    
    
    func setupView()  {
        addSubview(imgageView)
        addSubview(label)
        imgageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        label.frame = CGRect(x: 10, y: frame.width+30, width: frame.width, height: 62)
        
        
    }
}


