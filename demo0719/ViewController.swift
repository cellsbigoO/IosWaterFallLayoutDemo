import UIKit
import SnapKit

extension UIColor {
    class func randomColor() -> UIColor {
        return UIColor(_colorLiteralRed: Float(arc4random_uniform(256)) / 255.0, green: Float(arc4random_uniform(256)) / 255.0, blue: Float(arc4random_uniform(256)) / 255.0, alpha: 1.0)
//        return UIColor.white
    }
}

class ViewController: UIViewController {
    var count : Int = 10
    private let kWaterCellID = "kWaterCellID"
    private var itemW : CGFloat = 0
    
    var layout : WaterfallLayout?

    // 思考下为什么这种写法会更好
    lazy var collectionView: UICollectionView = {
        let layout = WaterfallLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        layout.dataSource = self
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.kWaterCellID)
        return collectionView
    }()
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        itemW = WaterfallLayout.itemW
        
//        print(UserData.userArray[0]["desc"] ?? "n" )

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.kWaterCellID, for: indexPath) as? CollectionViewCell
        cell!.removeFromSuperview()

        // 编码规范
<<<<<<< Updated upstream
        cell!.config(layout?.dataIndex[ indexPath.row ] ?? 0)
=======
        if indexPath.row < layout?.dataIndex.count ?? indexPath.row - 1  {
            cell!.config(layout?.dataIndex[indexPath.row] ?? 0)
        }
>>>>>>> Stashed changes
        if indexPath.item == count - 1 {
            count += 10
            collectionView.reloadData()
        }
        return cell!
    }
    func waterfallLayout(_ layout: WaterfallLayout, indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random_uniform(80) + 100)
    }
    
    func numberOfColsInWaterfallLayout(_ layout: WaterfallLayout) -> Int {
        return 2
    }
}


extension ViewController : WaterfallLayoutDataSource {
    // 生命周期最好不要放在 extension里
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置布局
        layout = WaterfallLayout()
        layout?.minimumLineSpacing = 2
        layout?.minimumInteritemSpacing = 2
        layout?.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        layout!.dataSource = self
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout!)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.kWaterCellID)
        view.addSubview(collectionView)


//        view.addSubview(self.collectionView)
//        self.collectionView.snp.remakeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }
}
