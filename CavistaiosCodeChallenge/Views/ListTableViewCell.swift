//
//  ListTableViewCell.swift
//  CavistaiosCodeChallenge
//
//  Created by Sourabh Kumbhar on 12/08/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import UIKit
import SDWebImage

class ListTableViewCell: UITableViewCell {
    
    private let backShaddowView = UIView()
    private let imgView         = UIImageView()
    private let titleLabel      = UILabel()
    private let dateLabel       = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set data to cell
    func configurCell(responseData: ResponseDataModel) {
        titleLabel.text = ""
        dateLabel.text = ""
        if let type = responseData.type {
            if type == ConstantHelper.image {
                if let data = responseData.data {
                    self.imgView.sd_setImage(with: URL(string: data), placeholderImage: nil, options: .continueInBackground, context: .none)
                }
                self.imgView.isHidden = false
                setupDyanamicConstraint(type: .image)
            } else if type == ConstantHelper.text {
                if let data = responseData.data {
                    self.titleLabel.text = data
                }
                self.imgView.isHidden = true
                setupDyanamicConstraint(type: .text)
            }
        }
        if let date = responseData.date {
            dateLabel.text = date
        }
    }
    
    private func setupDyanamicConstraint(type: DataType) {
        imgView.snp.makeConstraints { (make) in
            if type == .image {
                make.bottom.equalToSuperview().offset(-20)
            }
            if type == .text {
                make.centerY.equalToSuperview()
            }
        }
    }
    
}

// MARK:- SetupUI

extension ListTableViewCell {
    
    private func setupUI() {
        setupBackShaddowView()
        setupImageView()
        setupTitleLabel()
        setupDateLabel()
    }
    
    private func setupBackShaddowView() {
        self.addSubview(backShaddowView)
        backShaddowView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
        backShaddowView.addShadowToView()
    }
    
    private func setupImageView() {
        backShaddowView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgView.sd_imageIndicator?.startAnimatingIndicator()
        imgView.setRadius(40)
    }
    
    private func setupTitleLabel() {
        backShaddowView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in            
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-20)
            make.left.equalTo(imgView.snp.right).offset(8)
        }
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
    }
    
    private func setupDateLabel() {
        backShaddowView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(16)
            make.right.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-8)
        }
        dateLabel.textColor = .gray
    }
}
