//
//  CustomCellNibViewController.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/22.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class CustomCellNibViewController: UIViewController {
    
    /*
        Nib 을 사용한 CustomCell
     1. 기본적인 레이아웃은 동일하게 설정함
     2. 공통으로 사용할 nib 파일 생성(SharedCustomCell.xib)
     3. nib에서 공통으로 사용할 cell 코딩(앞서 했던거랑 똑같이 해주면 됨)
     4. nib파일 추가하기
     5. datasource 코딩
     */
    
    let list = WorldTime.generateData()
    

    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // nib 파일 추가(4)
        let cellNib = UINib(nibName: "SharedCustomCell", bundle: nil)
        listTableView.register(cellNib, forCellReuseIdentifier: "SharedCustomCell")
    }

}

extension CustomCellNibViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SharedCustomCell", for: indexPath) as! TimeTableViewCell
        let target = list[indexPath.row]
        
        cell.dateLabel.text = "\(target.date), \(target.hoursFromGMT)HRS"
        cell.locationLabel.text = target.location
        cell.timeLabel.text = target.time
        
        return cell
    }
    
    
}
