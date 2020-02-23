//
//  SelectionHeaderAndFooterDelegateViewController.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/23.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class SelectionHeaderAndFooterDelegateViewController: UIViewController {

    /*
        Delegate를 활용한 Customizing Section
     1. 데이터, 아울렛, 테이블 데이터 소스 등 설정
     --> Region.swift 파일을 사용
     --> table view의 style은 grouped로 설정. basic, cell 기본으로
     2. 헤더와 푸터를 재사용하기 위해 register로 등록해줌. nib을 사용안하므로 클래스를 호출해야함
     3. delegate를 통해 헤더와 푸터 재사용 코드 작성
     4. 헤더의 시각적 효과를 주기위한 코드 작성
     */
    
    @IBOutlet weak var listTableview: UITableView!
    var list = Region.generateData()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 헤더 재사용 등록(2)
        listTableview.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
    }

}

// (1)
extension SelectionHeaderAndFooterDelegateViewController : UITableViewDataSource{
    
    // 섹션을 보여주기 때문에 numberofsections 생성(1)
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

extension SelectionHeaderAndFooterDelegateViewController : UITableViewDelegate{
    // 헤더 재사용 코드(3)
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        headerView?.textLabel?.text = list[section].title
        headerView?.detailTextLabel?.text = "디테일 텍스트"   // detailtext는 grouped일 경우에만 나옴. 만약 안나오는 경우는 estimate에서 height를 auto로 줬는지 확인
        
        return headerView
    }
    
    // 헤더 표시 직전 호출됨. 시각적인 속성을 설정할때는 여기다 구현(4)
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView{
            // 배경이 nil일 경우에만 생성
            if headerView.backgroundView == nil{
                // 배경색은 뷰를 생성해서 따로 해줘야함
                let v = UIView(frame: .zero)
                v.backgroundColor = UIColor.darkGray
                v.isUserInteractionEnabled = false  // header의 터치이벤트가 필요없으면 이 설정을 해주는게 좋음
                headerView.backgroundView = v
            }
            headerView.backgroundView?.backgroundColor = UIColor.darkGray
            headerView.textLabel?.textColor = UIColor.black
            headerView.textLabel?.textAlignment = .center
        }
    }
    
    // 헤더 표시 직전 height를 설정할 수 있음. 값을 주거나 auto로 설정가능(4)
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}
