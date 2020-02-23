//
//  HeaderFooterViewController.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/23.
//  Copyright © 2020 kjm. All rights reserved.
//

import UIKit

class HeaderFooterViewController: UIViewController {

    /*
        검색 기능이 포함된 테이블 뷰에 헤더와 푸터를 추가하는 방법
     1. 기본적인 레이아웃 생성 및 테이블 데이터 소스 연결
     --> search bar는 테이블뷰 안에 꼭 넣어줘야함
     --> search bar의 캔슬 버튼 보여주도록 스토리보드에서 설정
     --> table view의 style은 grouped로 설정
     2. 검색 결과를 표현해줄 label 생성(lazy var)
     3. search bar의 delegate를 연결해주고 검색 이벤트 작성
     4. 검색 시 키보드 여백 이벤트 처리를 위한 notification 설정(handle 메서드 생성 후 옵저버 추가하고 그다음 로직 짜면 됨)
     */
    
    @IBOutlet weak var listTableView: UITableView!
    
    // 샘플 데이터
    let list = ["iMac Pro", "iMac 5K", "Macbook Pro", "iPad Pro", "iPad", "iPad mini", "iPhone 8", "iPhone 8 Plus", "iPhone SE", "iPhone X", "Mac mini", "Apple TV", "Apple Watch"]
    var filteredList = ["iMac Pro", "iMac 5K", "Macbook Pro", "iPad Pro", "iPad", "iPad mini", "iPhone 8", "iPhone 8 Plus", "iPhone SE", "iPhone X", "Mac mini", "Apple TV", "Apple Watch"]
    
    // 검색 결과를 보여줄 label(2)
    lazy var resultLabel : UILabel = {[weak self] in
        var frame = self?.view.bounds ?? .zero  // ??
        frame.size.height = 50
        
        let lbl = UILabel(frame: frame)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.white
        lbl.backgroundColor = UIColor.gray
        return lbl
    }()
    
    // observer 전달 시 처리해줄 handle 메서드(4)
    @objc func handle(notification : Notification){
        switch notification.name {
        case UIResponder.keyboardWillShowNotification:
            if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect{
                var inset = listTableView.contentInset
                inset.bottom = frame.height
                listTableView.contentInset = inset
            }
        case UIResponder.keyboardWillHideNotification:
            var inset = listTableView.contentInset
            inset.bottom = 0
            listTableView.contentInset = inset
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 키보드 notification을 위한 observer 추가(4)
        NotificationCenter.default.addObserver(self, selector: #selector(handle(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handle(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

}


extension HeaderFooterViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let target = filteredList[indexPath.row]
        cell.textLabel?.text = target
        
        return cell
    }
}

// 검색창 delegate 설정(3)
extension HeaderFooterViewController : UISearchBarDelegate{
    func filter(with keyword : String){ // 검색 창에 키워드 입력 시 자동으로 배열에서 데이터 값 찾음
        if keyword.count > 0{
            filteredList = list.filter{$0.contains(keyword)}
        }else{
            filteredList = list
        }
        
        listTableView.reloadData()
        resultLabel.text = "\(filteredList.count) result(s) found"
    }
    
    // 검색창의 텍스트 값이 변경됐을 경우 호출
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter(with: searchText)
    }
    
    // searchbar의 텍스트입력이 시작될때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        listTableView.tableFooterView = resultLabel // 푸터뷰에 검색결과를 보여줌
    }
    
    // searchbar의 텍스트 입력이 끝났을때
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = nil
        resultLabel.text = "0 result(s) found"
        listTableView.tableFooterView = nil
    }
    
    // 검색버튼 클릭 시
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filter(with: searchBar.text ?? "")
    }
    
    // 취소버튼 클릭 시
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredList = list
        listTableView.reloadData()
        
        searchBar.resignFirstResponder()
    }
}
