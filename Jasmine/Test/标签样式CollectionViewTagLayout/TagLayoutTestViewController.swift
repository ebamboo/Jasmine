//
//  TagLayoutTestViewController.swift
//  Jasmine
//
//  Created by ebamboo on 2022/9/24.
//

import UIKit

class TagLayoutTestViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let layout = CollectionViewTagLayout()
            layout.lineSpacing = 10
            layout.interitemSpacing = 30
            layout.itemHeight = 30
            layout.itemWidthReader { collectionView, indexPath in
                return CGFloat(Int.random(in: 44...110))
            }
            collectionView.collectionViewLayout = layout
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 66
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
}
