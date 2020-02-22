//
//  SelfSizingCellViewController.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/22.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class SelfSizingCellViewController: UIViewController {

    /*
        셀프 사이징에 대한 정보들
     1. 스토리보드의 estimate에서 automatic 으로 되어있다면 자동으로 높이가 설정됨
     2. 코드로도 height를 똑같이 구현할 수 있음
     3. 셀마다 따로 height를 정해줄 수 있는데 이건 delegate로 처리해야함
     --> 이때 heightForRowAt과 estimatedHeightForRowAt 두개를 같이 써야함
     */
    
    @IBOutlet weak var listTableView: UITableView!
    
    let list = [("Always laugh when you can. It is cheap medicine.", "Lord Byron"), ("I probably hold the distinction of being one movie star who, by all laws of logic, should never have made it. At each stage of my career, I lacked the experience.", "Audrey Hepburn"), ("Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations.", "Steve Jobs")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 코드로 height automatic 으로 설정(2)
        listTableView.rowHeight = UITableView.automaticDimension
        listTableView.estimatedRowHeight = UITableView.automaticDimension
    }

}

extension SelfSizingCellViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let target = list[indexPath.row]
        cell.textLabel?.text = target.0
        cell.detailTextLabel?.text = target.1
        return cell
    }
    
    
}

// 개별 셀 height 설정(3)
extension SelfSizingCellViewController : UITableViewDelegate{
    // 높이 계산 전 이 메서드를 호출함. 이 메서드의 우선순위가 더 높음
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 100
        }
        
        return UITableView.automaticDimension
    }
    
    // delegate로 height를 설정 한 경우 이 메서드를 호출해서 동일한 값으로 리턴을 해줘야 스크롤 성능이 향상됨
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 100
        }
        
        return UITableView.automaticDimension
    }
}
