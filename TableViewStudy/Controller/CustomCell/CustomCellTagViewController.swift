//
//  CustomCellTagViewController.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/22.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class CustomCellTagViewController: UIViewController {
    
    /*
        Tag를 활용한 Custom Cell 설정
     1. 스토리보드 레이아웃 및 아웃렛 설정
     --> 데이터는 WorldTime.swift 파일 사용
     2. 스토리보드에서 설정할 Custom Cell의 레이아웃 추가
     --> 아이덴티티는 customCell 로 설정
     --> height는 100으로 설정하기
     --> 제약조건 잘 확인하기
     --> 첫번째 라벨은 date Label이고 두번째 라벨은 location Label임. 이 두개를 생성하고 태그는 각각 100, 200 으로 해준다음 스택뷰로 묶고 나서 왼쪽으로 정렬하도록 제약 추가(스택뷰->왼쪽제약->Vertically in container)
     --> 세번째 라벨은 time label이고, 태그는 300. 오른쪽 정렬을 해주면 됨. 오른쪽으로 정렬하고 스택뷰와 거리를 유지하도록 제약 추가.(오른쪽 제약 -> Vertically in container -> 왼쪽 제약)
     --> stack view 와 time label 사이의 제약을 꼭 변경해줘야함. 238 이상으로 잡혀있는걸 Relation을 Greater Than or Equal로 바꿔주고 constant를 10으로 줘야지 안잘리고 잘나옴
     3. 태그를 통해 라벨로 접근
     */

    @IBOutlet weak var listTableView: UITableView!
    let list = WorldTime.generateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension CustomCellTagViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        let target = list[indexPath.row]
        
        // 태그를 통헤 레이블 설정(3)
        // viewWithTag의 경우 UIView로 리턴해주기 때문에 타입캐스팅이 필요함
        if let dateLabel = cell.viewWithTag(100) as? UILabel{
            dateLabel.text = "\(target.date), \(target.hoursFromGMT)HRS"
        }
        
        if let locationLabel = cell.viewWithTag(200) as? UILabel{
            locationLabel.text = target.location
        }
        
        if let timeLabel = cell.viewWithTag(300) as? UILabel{
            timeLabel.text = target.time
        }
        
        return cell
    }
}

extension CustomCellTagViewController : UITableViewDelegate{
    
}
