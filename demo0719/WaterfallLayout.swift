import UIKit

@objc protocol WaterfallLayoutDataSource : class {
    func waterfallLayout(_ layout : WaterfallLayout, indexPath : IndexPath) -> CGFloat
    @objc optional func numberOfColsInWaterfallLayout(_ layout : WaterfallLayout) -> Int
}

class WaterfallLayout: UICollectionViewFlowLayout {
    
    weak var dataSource : WaterfallLayoutDataSource?
    var attrsArray : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    var dataIndex : [Int] =  Array(repeating: 0, count: 1000)
    fileprivate var totalHeight : CGFloat = 0
    fileprivate lazy var colHeights : [CGFloat] = {
        let cols = self.dataSource?.numberOfColsInWaterfallLayout?(self) ?? 2
        var colHeights = Array(repeating: self.sectionInset.top, count: cols)
        return colHeights
    }()
    fileprivate var maxH : CGFloat = 0
    fileprivate var startIndex = 0
    static var itemW : CGFloat?
}

extension WaterfallLayout {
    override func prepare() {
        super.prepare()
        
        // 获取item的个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        
        // 获取列数
        let cols = dataSource?.numberOfColsInWaterfallLayout?(self) ?? 2
        
        // 计算Item的宽度
        WaterfallLayout.itemW = (collectionView!.bounds.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * CGFloat((cols - 1))) / CGFloat(cols)
        
        // 计算所有的item的属性
        for i in startIndex..<itemCount {
            // 设置每一个Item位置相关的属性
            let indexPath = IndexPath(item: i, section: 0)
            
            // 根据位置创建Attributes属性
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 随机一条数据
            dataIndex[indexPath.row] = Int.random(in: 0..<UserData.userArray.count )
            let userDataIndex = dataIndex[indexPath.row]
            var height : CGFloat = (CGFloat(UserData.userArray[userDataIndex]["image_info"]?["height"] as? Int ?? 300) / CGFloat(UserData.userArray[userDataIndex]["image_info"]?["width"] as? Int ?? 180) * WaterfallLayout.itemW!) 
            
            height = height + ((UserData.userArray[userDataIndex]["desc"]?.size ?? 10) > 12 ? 100: 108)
            // 取出最小列的位置
            var minH = colHeights.min()!
            let index = colHeights.index(of: minH)!
            minH = minH + CGFloat(height) + minimumLineSpacing
            colHeights[index] = minH
            // 设置item的属性
            attrs.frame = CGRect(x: self.sectionInset.left + (self.minimumInteritemSpacing + WaterfallLayout.itemW!) * CGFloat(index), y: minH - CGFloat(height) - self.minimumLineSpacing, width: WaterfallLayout.itemW!, height: CGFloat(height))
            attrsArray.append(attrs)
        }
        
        // 记录最大值
        maxH = colHeights.max()!
        
        // 给startIndex重新复制
        startIndex = itemCount
    }
}

extension WaterfallLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxH + sectionInset.bottom - minimumLineSpacing)
    }
}
