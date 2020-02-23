//
//  SingleSelectionViewController.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/23.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class SingleSelectionViewController: UIViewController {

    /*
        단일 셀 선택 이벤트 처리 방법
     1. 기본 레이아웃 설정 및 데이터소스 연결
     --> table view의 selection이 single selection인지 확인
     --> table view cell의 selection도 default로 되어있는지 확인
     --> 데이터는 Resion.swift 사용
     2. navigation에 선택 이벤트를 선택할 수 있는 alert창이 뜨도록 버튼 생성 및 alert 이벤트 추가하기
     3. 랜덤 셀 선택과 선택 셀 해제 해주는 메서드 생성
     4. uitableview delegate로 셀 선택을 확인할 수 있는 메서드가 있지만 uitableviewcell을 통해 더 간략하게 처리할 수 있음
     */
    
    @IBOutlet weak var listTableView: UITableView!
    let list = Region.generateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 네비게이션에 버튼 추가(2)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showMenu(_:)))
    }
    
    // acthion sheet 방식으로 선택 이벤트 예제를 볼수 있는 메서드 (2)
    @objc func showMenu(_ sender : UIBarButtonItem){
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 랜덤 셀 선택 액션 추가
        let selectRandomCellAction = UIAlertAction(title: "Select Random Cell", style: .default){
         (action) in
            self.selectRandomCell()
        }
        menu.addAction(selectRandomCellAction)
        
        let deselectAction = UIAlertAction(title: "Deselect", style: .default){
            (action) in
            self.deselect()
        }
        menu.addAction(deselectAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        menu.addAction(cancelAction)
        
        // ???
        if let pc = menu.popoverPresentationController{
            pc.barButtonItem = sender
        }
        
        present(menu, animated: true, completion: nil)
    }
    
    // 랜덤 셀 선택 메서드(3)
    func selectRandomCell(){
        let section = Int(arc4random_uniform(UInt32(list.count)))
        let row = Int(arc4random_uniform(UInt32(list[section].countries.count)))
        let targetIndexPath = IndexPath(row: row, section: section)
        
        // 특정 셀 선택시 사용하는 메서드
        // scroll option을 선택하면 선택한 셀의 위치를 지정할 수 있음
        listTableView.selectRow(at: targetIndexPath, animated: true, scrollPosition: .top)
    }
    
    // 선택한 셀을 해제해주는 코드
    func deselect(){
        if let selected = listTableView.indexPathForSelectedRow{
            listTableView.deselectRow(at: selected, animated: true)
            
            // 1초 후 첫번째 셀로 이동
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                [weak self] in
                let first = IndexPath(row: 0, section: 0)
                self?.listTableView.scrollToRow(at: first, at: .top, animated: true)
            }
        }
    }

}

// 기본 설정(1)
extension SingleSelectionViewController : UITableViewDataSource{
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
    
    // 헤더 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list[section].title
    }
}

// alert 액션 생성(2)
extension SingleSelectionViewController{
    func showAlert(with value : String){
        let alert = UIAlertController(title : nil, message: value, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}


// uitableviewcell을 통해 셀 선택 확인(4)
class SingleSelectionCell : UITableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 글자색 변경
        textLabel?.textColor = UIColor(white: 217.0/255.0, alpha: 1.0)
        textLabel?.highlightedTextColor = UIColor.black // 선택 시 글자색 변경
    }
    
    // 선택상태가 바뀔때마다 호출
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // 강조상태가 바뀔때마다 호출
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
    }
    
}
