//
//  DetailViewController.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/22.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var valueLabel: UILabel!
    var value : String?  // 전달받을 데이터
    override func viewDidLoad() {
        super.viewDidLoad()
        valueLabel.text = value
    }
}
