//
//  ProductCellViewModels.swift
//  e-commerce
//
//  Created by Mesut Aygün on 30.06.2021.
//

import UIKit

struct ProductCellView {
    let image : UIImage?
    let title : String
}
class ProductCellViewModels : UITableViewCell {
static let identifier = "ProductCellViewModels"
    
    private let productimageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let productlabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(productimageView)
        contentView.addSubview(productlabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize : CGFloat = contentView.frame.size.height
        
        productimageView.frame = CGRect(x: 5, y: 0, width: imageSize, height: imageSize)
        productlabel.frame = CGRect(x: imageSize + 15 , y: 0, width: contentView.frame.size.width - 20 - imageSize, height: imageSize)
    }
    
    public func configure(with viewModels : ProductCellView){
        productlabel.text = viewModels.title
        productimageView.image = viewModels.image
    }
}
