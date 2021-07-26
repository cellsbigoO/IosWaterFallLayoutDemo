//
//  CollectionViewCell.swift
//  demo0719
//
//  Created by bytedance on 2021/7/25.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    static let kWaterCellID = "kWaterCellID"
    
    var titleLabel : UILabel?
    var goodImageView : UIImageView?
    var avatarImageView : UIImageView?
    var nicknameLabel : UILabel?
    var likeButton : UIButton?
    var likeCountLabel : UILabel?
    var itemW : CGFloat?
    var likeButtonTouchCount = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        itemW = 186
        // good 图片
        goodImageView = UIImageView()
        self.addSubview(goodImageView!)
        
        // title 标签
        titleLabel = UILabel()
        self.addSubview(titleLabel!)
        
        // avatar 图片
        avatarImageView = UIImageView()
        self.addSubview(avatarImageView!)
        
        // nickname 标签
        nicknameLabel = UILabel()
        self.addSubview(nicknameLabel!)
        
        // like 按钮
        likeButton = UIButton()
        likeButton?.setImage(UIImage(named: "like")!, for: .normal)
        likeButton?.backgroundColor = UIColor.white
        likeButton?.addTarget(self, action: #selector(tapped), for: .touchDown)
        self.addSubview(likeButton!)
        // like 标签
        likeCountLabel = UILabel()
        self.addSubview(likeCountLabel!)
    }
    
    @objc func tapped(sender: UIButton) {
        likeButtonTouchCount += 1
        if likeButtonTouchCount % 2 == 0 {
            likeButton?.setImage(UIImage(named: "liked"), for: .normal)
        }
        else {
            likeButton?.setImage(UIImage(named: "like"), for: .normal)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func config(_ dataIndex : Int){
        self.backgroundColor = UIColor.white
        // good 商品图片
//        print("\(dataIndex) \(self.frame.minY )")
        goodImageView?.frame = CGRect(x: 0, y: 0, width: itemW!-5, height: (CGFloat(UserData.userArray[dataIndex]["image_info"]?["height"] as! Int) / CGFloat(UserData.userArray[dataIndex]["image_info"]?["width"] as! Int) * itemW!) )
        goodImageView?.image = UserData.goodImageData[dataIndex]
//        goodImageView?.snp.makeConstraints {  //这里用 SnapKit 会有bug
//            make -> Void in
//            make.top.equalTo(self)
//            make.left.equalTo(self)
//            make.right.equalTo(self)
//            make.width.equalTo(itemW!)
//            make.height.equalTo(dataIndex*50+200)
//        }
        goodImageView?.contentMode = .scaleAspectFill
        goodImageView?.clipsToBounds = true
        goodImageView?.layer.cornerRadius = 7
//        goodImageView?.layer.masksToBounds = true

////    title 标签
        titleLabel?.textColor = UIColor.black
        titleLabel?.text = UserData.userArray[dataIndex]["desc"]  as! String
        titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        titleLabel?.numberOfLines = 0
        titleLabel?.snp.makeConstraints{
            make in
            make.top.equalTo(goodImageView!.snp.bottom).offset(6)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self)
            make.width.equalTo(itemW!)
            make.height.equalTo((UserData.userArray[dataIndex]["desc"]?.size ?? 10) > 12 ? 31 : 41)
        }

//        // avatar 用户头像
        avatarImageView?.image = UserData.avatarImageData[dataIndex]
        avatarImageView?.snp.makeConstraints{
            make  in
            make.top.equalTo(titleLabel!.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.width.height.equalTo(30)
        }
        avatarImageView?.layer.cornerRadius = 15
        avatarImageView?.layer.masksToBounds = true

        // name 用户昵称
        nicknameLabel?.text = (UserData.userArray[dataIndex]["user"]?["nickname"] as? String ) ?? "not found"
        nicknameLabel?.font = UIFont.systemFont(ofSize: 10.0)
        nicknameLabel?.font.withSize(4)
        nicknameLabel?.snp.makeConstraints{
            make in
            make.top.equalTo(titleLabel!.snp.bottom).offset(20)
            make.left.equalTo(avatarImageView!.snp.right).offset(7)
            make.width.equalTo(60)
        }

        // like 点赞按钮
        likeButton?.snp.makeConstraints {
            make  in
            make.top.equalTo(titleLabel!.snp.bottom).offset(15)
            make.left.equalTo(nicknameLabel!.snp.right).offset(22)
            make.width.height.equalTo(21)
        }
        
        // likeCount 点赞数
        likeCountLabel?.text =  String(UserData.userArray[dataIndex]["image_info"]?["height"] as! Int)
        likeCountLabel?.snp.makeConstraints{
            make -> Void in
            make.top.equalTo(titleLabel!.snp.bottom).offset(20)
            make.left.equalTo(likeButton!.snp.right).offset(4)
            make.width.equalTo(40)
            make.height.equalTo(10)
        }
        likeCountLabel?.font = UIFont.systemFont(ofSize: 10.0)
    }
}
//extension UIImageView {
//    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() {
//                self.image = image
//            }
//            }.resume()
//    }
//    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloadedFrom(url: url, contentMode: mode)
//    }
//}
