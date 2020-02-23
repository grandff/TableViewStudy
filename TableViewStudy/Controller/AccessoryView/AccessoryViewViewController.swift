//
//  AccessoryViewViewController.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/22.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class AccessoryViewViewController: UIViewController {

    /*
        테이블 뷰 악세서리 설정 등등
     1. 스토리보드에서 기본적인 레이아웃 설정
     --> 전부 Basic 으로 설정
     --> 첫번째는 cell, accessory는 checkmark. tint는 빨강색으로 해줌
     --> 두번째는 아이덴티티만 cell2로 지정
     2. 편집 토글 기능 추가
     3. 셀을 선택했을떄와 detail 버튼을 눌렀을때 화면 전환을 각각 줌
     --> 스토리보드에서 뷰를 새로 추가하고, show 와 present modally 두개를 설정. 이때 셀로 설정하면 안되고 컨트롤러 - 컨트롤러로 해야함
     --> 각 세그웨이의 아이덴티티를 pushSegue, modalSegue로 설정
     4. disclosur indicator 처럼 수정할 수 없는 악세서리를 변경하고 싶으면 tableviewcell을 새로 만들어서 커스텀해야함. CustomAccessoryTableViewCell.swift (cell2 에다가 설정)
     */
    
    @IBOutlet weak var listTableView: UITableView!
    
    // 토글 버튼 클릭시 편집모드로 들어감(2)
    @objc func toggleEditMode(){
        listTableView.setEditing(!listTableView.isEditing, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 편집 기능을 추가한 토글 버튼 추가(2)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(toggleEditMode))
    }
}

extension AccessoryViewViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 각 악세서리에 대한 명칭으로 설정해줌
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Disclosure Indicator"
            cell.accessoryType = .disclosureIndicator
        case 1:
            cell.textLabel?.text = "Detail Button"
            cell.accessoryType = .detailButton
        case 2:
            cell.textLabel?.text = "Detail Disclosure Button"
            cell.accessoryType = .detailDisclosureButton
        case 3:
            cell.textLabel?.text = "Checkmark"
            cell.accessoryType = .checkmark
        case 4:
            return tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        default:
            cell.textLabel?.text = "None"
            cell.accessoryType = .none
        }
        return cell
    }
}

// 셀 선택 및 detail 버튼 클릭 시 화면 전환 처리(3)
extension AccessoryViewViewController : UITableViewDelegate{
    // 셀 선택 시 push 로 화면 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pushSegue", sender: nil)
    }
    
    // 디테일 버튼 클릭 시 modal로 화면 이동
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "modalSegue", sender: nil)
    }
}
