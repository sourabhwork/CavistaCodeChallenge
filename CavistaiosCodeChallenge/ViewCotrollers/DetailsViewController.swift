//
//  DetailsViewController.swift
//  CavistaiosCodeChallenge
//
//  Created by Sourabh Kumbhar on 13/08/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    private let scrollView  = UIScrollView()
    private let contentView = UIView()
    private let imageView   = UIImageView()
    private let titleLabel  = UILabel()
    private let dateLabel   = UILabel()
    var responseDataModel   = ResponseDataModel()

    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }

}

// MARK:- Setup UI

extension DetailsViewController {
    
    private func setupUI() {
        setupScrollView()
        setupContentView()
        setupImageView()
        setupTitleLabel()
        setupDateLabel()
    }
    
    private func setupScrollView() {
        // Add view to superView
        self.view.addSubview(scrollView)
        // Add constraint to view
        scrollView.snp.makeConstraints{ (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        // Add appearance to view
        scrollView.backgroundColor = UIColor.white
        scrollView.alwaysBounceVertical = false
    }
    
    private func setupContentView() {
        // Add view to superView
        self.scrollView.addSubview(contentView)
        // Add constraint to view
        contentView.snp.makeConstraints{ (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            make.width.equalToSuperview()
        }
        // Add appearance to view
        contentView.backgroundColor = UIColor.white
    }
    
    private func setupImageView() {
        // Add view to superView
        self.contentView.addSubview(imageView)
        // Add constraint to view
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(32)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        // Set appearance to view
        imageView.setRadius(100)
        // Add appearance to view
        if let image = responseDataModel.data {
            if let type = responseDataModel.type {
                if type == ConstantHelper.image {
                    self.imageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: ""), options: .continueInBackground, context: .none)
                }
            }
        }
    }
    
    private func setupTitleLabel() {
        // Add view to superView
        self.contentView.addSubview(titleLabel)
        // Add constraint to view
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        // Add appearance to view
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        // Assign data to view
        if let data = responseDataModel.data {
            if let type = responseDataModel.type {
                if type == ConstantHelper.text {
                    titleLabel.text = data
                    titleLabel.snp.makeConstraints { (make) in
                      make.top.equalToSuperview().offset(32)
                    }
                }
            }
        }
    }
    
    private func setupDateLabel() {
        // Add view to superView
        self.contentView.addSubview(dateLabel)
        // Add constraint to view
        dateLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
        contentView.snp.makeConstraints{ (make) in
            make.bottom.equalTo(dateLabel.snp_bottomMargin).offset(24)
        }
        // Add appearance to view
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor.black
        // Assign data to view
        if let date = responseDataModel.date {
            dateLabel.text = date
        }
    }
    
}
