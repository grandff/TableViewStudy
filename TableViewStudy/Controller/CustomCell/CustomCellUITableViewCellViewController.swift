//
//  CustomCellUITableViewCellViewController.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/22.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class CustomCellUITableViewCellViewController: UIViewController {

    /*
        uitableviewcell을 사용
     1. 레이아웃 설정은 tag와 동일함
     2. cell의 outlet을 설정해주기 위해 UItableViewCell을 상속받는 cocoa touch 생성(TimeTableViewCell.swift로 만듬)
     3. cell 설정 시 타입캐스팅을 TimeTableViewCell로 해줘야함
     */
    
    let list = WorldTime.generateData()
    
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension CustomCellUITableViewCellViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TimeTableViewCell
        let target = list[indexPath.row]
        cell.dateLabel.text = "\(target.date), \(target.hoursFromGMT)HRS"
        cell.locationLabel.text = target.location
        cell.timeLabel.text = target.time
        
        return cell
    }
    
    
}
