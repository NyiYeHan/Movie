//
//  CategoryCell.swift
//  Movie
//
//  Created by Nyi Ye Han on 12/12/2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    var itemDelegate : ItemDelegate?
    private let cellId = "cellId"
    let largeCell = "largeCellId"
    var category : MovieCategory?{
        didSet{
            if let name = category?.name {
                headerLabel.text = name
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    
    }
    
    let headerLabel : UILabel = {
       let label = UILabel()
        label.text = "Popular"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
        
    }()
    
    let appCollectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    
        return collectionView
    }()
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    func setUpView(){
        
        
        
        addSubview(appCollectionView)
        addSubview(headerLabel)
        
    
        appCollectionView.dataSource = self
        appCollectionView.delegate = self
        appCollectionView.backgroundColor = .black
        
        
        appCollectionView.register(AppCell.self, forCellWithReuseIdentifier: cellId)
        
       
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[headerLabel]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["headerLabel":headerLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":appCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[headerLabel(50)][v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":appCollectionView,"headerLabel":headerLabel]))
    
    }
}

extension CategoryCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    
    // get cellcount in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = category?.movieList?.count {
            return count
        }
        return 0
    }
    
    // intializing cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = appCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppCell
        cell.movie = category?.movieList?[indexPath.item]
        return cell
       
    }
    
    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if(indexPath.item == 2){
//            return CGSize(width: 200, height: 260)
//        }
        return CGSize(width: 150, height: frame.height-50)
       
    }
    
    
    //on click listener
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item")
        itemDelegate?.onItemClick(data: category?.movieList?[indexPath.item])
       
        
    }
    
    // add margin to cell view
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}

protocol ItemDelegate{
    func onItemClick(data : Movie?)
}
