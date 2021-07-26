//
//  WaterfallViewController.swift
//  qixiaofu
//
//  Created by ly on 2018/1/24.
//  Copyright © 2018年 qixiaofu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class WaterfallViewController: UIViewController {
   
   fileprivate var collectionView : UICollectionView!
   
   override func viewDidLoad() {
       super.viewDidLoad()
       
       
       self.setUpCollectionView()
       
   }
   
   func setUpCollectionView() {
       let layout = WaterfallLayout()
       layout.delegate = self
       layout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
       layout.minimumInteritemSpacing = 10
       layout.minimumLineSpacing = 5
       self.collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
       self.collectionView.delegate = self
       self.collectionView.dataSource = self
       self.view.addSubview(self.collectionView)
       self.collectionView.backgroundColor = UIColor.blue
       self.collectionView.register(UINib.init(nibName: "WaterfallCell", bundle: Bundle.main), forCellWithReuseIdentifier: "WaterfallCell")
       self.collectionView.register(WaterfallReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WaterfallReusableView")
   }
   
   override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
       
   }
   
}

extension WaterfallViewController : UICollectionViewDelegate, UICollectionViewDataSource{
   // MARK: UICollectionViewDataSource
   func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 3
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 10
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaterfallCell", for: indexPath)
       
       cell.backgroundColor = UIColor.red
       
       // Configure the cell
       
       return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       let reusedView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WaterfallReusableView", for: indexPath)
       reusedView.backgroundColor = UIColor.green
       
       return reusedView
   }
}

extension WaterfallViewController : WaterfallLayoutDelegate{
   func itemHeightForIndexPath(indexpath: IndexPath) -> CGFloat? {
       return CGFloat(arc4random() % UInt32(100)) + 10.0
   }
}


class WaterfallReusableView: UICollectionReusableView {
   
}
