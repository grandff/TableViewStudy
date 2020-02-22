//
//  CustomAccessoryTableViewCell.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/22.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class CustomAccessoryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        let v = UIImageView(image : UIImage(named: "star"))
        accessoryView = v
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
