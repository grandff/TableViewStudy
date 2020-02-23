//
//  CustomHeaderView.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/23.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class CustomHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var customBackgroundView: UIView!
    // 초기화 메서드
    override func awakeFromNib() {
        super.awakeFromNib()
        
        countLabel.text = "0"
        countLabel.layer.cornerRadius = 30
        countLabel.clipsToBounds = true
    }

}
