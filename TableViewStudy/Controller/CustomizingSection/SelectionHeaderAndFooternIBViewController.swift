//
//  SelectionHeaderAndFooternIBViewController.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/23.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class SelectionHeaderAndFooternIBViewController: UIViewController {

    /*
        Nib 파일을 활용한 Section 설정
     1. 기본적인 레이아웃 설정
     --> Delegate와 동일하게 설정해주면 됨
     2. 재사용할 Header 레이아웃을 그릴 nib 파일 생성(CustomHeader.xib)
     --> 배경이 될 view 는 freeform으로 설정해줘서 크기 조절을 해주고 그 안에 view를 넣어 배경색을 설정해줘야함
     3. Nib 파일의 outlet을 받을 UITableViewHeaderFooterView 생성(CustomHeaderView.swift)
     4. 생성한 Nib 파일을 등록
     5. delegate 등록
     */
    
    
    @IBOutlet weak var listTableView: UITableView!
    let list = Region.generateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // nib 파일 등록(4)
        let headerView = UINib(nibName: "CustomHeader", bundle: nil)
        listTableView.register(headerView, forHeaderFooterViewReuseIdentifier: "header")
    }

}


extension SelectionHeaderAndFooternIBViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let target = list[indexPath.section].countries[indexPath.row]
        cell.textLabel?.text = target
        
        return cell
    }
}

extension SelectionHeaderAndFooternIBViewController : UITableViewDelegate{
    // 등록한 nib 아이덴티티를 사용해서 delegate 등록 (5)
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CustomHeaderView
        headerView.titleLabel.text = list[section].title
        headerView.countLabel.text = "\(list[section].countries.count)"
        
        return headerView
        
    }
}
