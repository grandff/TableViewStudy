//
//  SeparatorViewController.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/22.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class SeparatorViewController: UIViewController {

    /*
        - Separator 커스텀 방법 -
     1. 스토리보드에서 기본적인 레이아웃 설정
     --> Table View의 Separator Inset은 커스텀으로 변경
     --> Left Right를 임의로 설정. 여기선 30으로 설정함
     --> 아이덴티티도 다 설정
     --> 여기까지하면 스토리보드에서 구현할 수 있는것들임. 아래부터는 코드로 구현.
     2. 코드로 설정하기 위해 Table View Outlet 설정(델리게이트, 데이터소스 도 연결)
     3. 생성된 outlet에 separator 코드로 구현(전체 셀 적용)
     4. 개별 셀마다 separator 설정
     */
    
    @IBOutlet weak var listTableView: UITableView!  // (2)
    
    // 확인용 데이터
    let list = ["iMac Pro", "iMac 5K", "Macbook Pro", "iPad Pro", "iPhone X", "Mac mini", "Apple TV", "Apple Watch"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Separator 코드로 구현(3)
        listTableView.separatorStyle = .singleLine
        listTableView.separatorColor = UIColor.blue
        listTableView.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        // 인셋 계산은 ios 11 이후부터 가능
        listTableView.separatorInsetReference = .fromCellEdges
    }
}

// 개별셀마다 세퍼레이터 설정(4)
extension SeparatorViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row % list.count]
        
        // 개별 셀 inset 설정
        if indexPath.row == 1{
            cell.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        }else if indexPath.row == 2{
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        }else{
            cell.separatorInset = listTableView.separatorInset
            // 개별로 설정한 경우 else 블록에다가 꼭 초기화를 해줘야 원하는 셀만 설정이 됨.
        }
        
        return cell
    }
}
