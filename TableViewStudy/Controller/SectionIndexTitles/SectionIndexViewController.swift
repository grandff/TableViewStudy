//
//  SectionIndexViewController.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/23.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class SectionIndexViewController: UIViewController {

    /*
        Section Index 기능 구현
     1. 기본적인 레이아웃 설정
     --> 데이터는 Region.swift 사용
     --> 데이터소스 연결해주고 섹션 헤더까지 설정해줌
     2. 문자열 배열을 리턴하기 위한 섹션 인덱스 생성
     3. 특정 인덱스만 보여주게 처리해줄수도 있음
     4. 인덱스의 색깔을 수정할수도 있음
     */
    
    @IBOutlet weak var listTabelView: UITableView!
    let list = Region.generateData()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 인덱스 배경색 등 색상 변경 (4). 폰트나 폰트크기는 변경 불가능함
        listTabelView.sectionIndexColor = UIColor.white
        listTabelView.sectionIndexBackgroundColor = UIColor.lightGray
        listTabelView.sectionIndexTrackingBackgroundColor = UIColor.darkGray    // 드래그 하는 동안 변경
    }
}

// 기본적인 데이터소스 설정(1)
extension SectionIndexViewController : UITableViewDataSource{
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list[section].title
    }
    
    // 화면 우측에 표시되는 인덱스(2)
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        // map은 컨테이너가 담고 있던 각각의 값을 매개변수를 통해 받은 함수에 적용한 후 새로운 컨테이너를 생성해 반환해줌
        //return list.map{$0.title}   // (2) - 전체인덱스 표시
        
        return stride(from: 0, to: list.count, by: 2).map {list[$0].title}  // stride는 for문과 비슷하게 값을 증가시키면서 반복시킬 수 있음 (3) - 일부인덱스만 표시
    }
    
    // 인덱스의 일부만 보여주고 싶으면 아래의 메서드를 같이 구현해야함. 실제 섹션으로 이동하기전에 호출되는 메서드임(3)
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index * 2
    }
    
}
