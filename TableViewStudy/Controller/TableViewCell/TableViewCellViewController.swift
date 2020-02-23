//
//  TableViewCellViewController.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/22.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class TableViewCellViewController: UIViewController {
    
    /*
        - 테이블 뷰 셀 선택(segue)에 대한 기초 -
     1. 스토리보드 레이아웃 설정 및 데이터소스, 딜리게이트, outlet 설정
     --> 셀 스타일은 Basic으로 설정
     2. 데이터소스를 상속받아서 테이블에 데이터 보여줌
     3. 새로운 뷰컨트롤러를 만들어서 셀 선택시 이동할 수 있게 설정(스토리보드)
     --> DetailViewController 로 연결해서 선택한 값을 보여줄 수 있도록 라벨 하나 추가
     --> 해당 컨트롤러에는 데이터 받을 변수를 하나 만들고 label에 바로 보여주기만 하면 됨
     4. segue로 데이터를 전달하기 위해 preapre 메서드 사용
     5. 셀 선택 시 호출 및 배경색을 설정하기 위해 delegate 설정
     */
    
    // 샘플 데이터
    let list = ["iPhone", "iPad", "Apple Watch", "iMac Pro", "iMac 5K", "Macbook Pro", "Apple TV"]
    
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 데이터 전달을 위한 prepare 메서드(4)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell{
            if let indexPath = listTableView.indexPath(for: cell){
                if let vc = segue.destination as? DetailViewController{
                    vc.value = list[indexPath.row]
                }
            }
        }
    }
}

extension TableViewCellViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        // 이미지 설정
        cell.imageView?.image = UIImage(named: "star")
        return cell
    }
}

// delegate 설정(5)
extension TableViewCellViewController : UITableViewDelegate{
    // 셀 선택할때마다 호출
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            print("text :: \(cell.textLabel?.text ?? "none")")
        }
    }
    
    // 셀마다 배경색 따로 지정
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 짝수, 홀수 마다 다른 배경색
        if indexPath.row % 2 == 0{
            cell.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        }else{
            cell.backgroundColor = UIColor.white
        }
        
        // cell.multipleSelectionBackgroundView -> 다중선택시 백그라운드뷰
        // cell.selectedBackgroundView -> 선택시마다 변경
    }
}
