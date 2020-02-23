//
//  MultiSectionTableViewViewController.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/22.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class MultiSectionTableViewViewController: UIViewController {

    /*
        - 멀티섹션 구현 방법 -
     -> 강의에서는 기본 모델 파일이 구현되어 있음. (PhotosSetting.swift)
     1. 테이블에 보여줄 데이터 생성(여기선 기본 모델 파일인 포토셋팅 파일로 설정함)
     2. 스토리보드에서 멀티섹션 보여줄 테이블 뷰, 셀 등 설정하기
     --> 테이블뷰의 스타일은 Grouped로 설정
     --> 각각의 아이덴티티는 PhotosSetting의 enum에 맞게 설정. 첫번째 셀만 subtitle로 설정을 주고, 나머진 basic
     --> 첫번째 셀은 악세서리에 인디케이터 추가
     --> 테이블뷰의 데이터소스 연결
     3. extension 으로 테이블뷰 데이터소스 설정
     4. 테이블 뷰에서 보여줄 섹션의 수 설정
     5. 테이블 뷰의 각 세션마다 보여질 셀 수 설정
     6. 각 테이블 셀에 보여질 데이터 설정
     --> 스위치는 기본 style에서 추가할 수 없고 커스텀으로 생성해야함(SwitchTableViewCell.swift)
     --> 스위치 액션의 경우 미리 메서드 만들어 놓고 하기
     7. 각 섹션을 구분하기 위해 헤더와 푸터 추가
     */
    
    // 보여줄 데이터 생성(1)
    let list = PhotosSettingSection.generateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // switch 액션. 어느 스위치인지 구분하기 위해 tag 사용
    @objc func switchChanged(_ sender : UISwitch){
        print(sender.isOn, sender.tag)
    }
}

// 테이블 뷰 데이터 소스(3)
extension MultiSectionTableViewViewController : UITableViewDataSource{
    
    // 테이블 뷰에서 표시해야할 섹션의 수 설정(4)
    func numberOfSections(in tableView: UITableView) -> Int {
        print("list count :: \(list.count)")
        return list.count
    }
    
    // 테이블 뷰의 셀에 보여질 데이터 갯수 설정. 한개의 섹션일때는 상관없으나, 여러개의 섹션을 경우에는 section 값을 통해 설정해야함.(5)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].items.count
    }
    
    // 셀에 보여질 데이터 설정(6)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let target = list[indexPath.section].items[indexPath.row]       // 섹션에 저장된 데이터 가져옴
        let cell = tableView.dequeueReusableCell(withIdentifier: target.type.rawValue, for: indexPath)  // PhotosSetting에 설정한 enum 에서 type 값을 rawValue를 통해 그대로 가져옴
        
        // 스위치 문을 이용해 타입별로 값 설정
        switch target.type{
            case .detailTitle :
                // 두레이블의 텍스트 설정 및 이미지 설정
                cell.textLabel?.text = target.title
                cell.detailTextLabel?.text = target.subTitle
                cell.imageView?.image = UIImage(named: target.imageName!)
            case .switch :
                cell.textLabel?.text = target.title
                // UISwitch 를 추가하기 위해 타입캐스팅 해줌
                if let switchView = cell.accessoryView as? UISwitch{
                    switchView.isOn = target.on
                    // 스위치 액션 연결
                    switchView.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
                    // 스위치 구분을 위해 태깅 사용
                    switchView.tag = indexPath.section
                }
            case .checkmark :
                cell.textLabel?.text = target.title
                cell.accessoryType = target.on ? .checkmark : .none
            }
        return cell
    }

    // 섹션의 헤더 추가(7)
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list[section].header
    }
    
    // 섹션의 푸터 추가(7)
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return list[section].footer
    }
}
