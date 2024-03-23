import UIKit
import SnapKit

class LocationDetailViewController: UIViewController {

    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        // 테이블 뷰 초기화 및 설정
        tableView = UITableView()
        tableView.register(LocationDetailTableViewCell.self, forCellReuseIdentifier: "LocationDetailTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        // 테이블 뷰를 뷰에 추가
        view.addSubview(tableView)
        
        // SnapKit을 사용하여 레이아웃 제약 조건 설정
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension LocationDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // UITableViewDataSource 필수 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 여기에 섹션별 행 수를 반환합니다.
        return 10 // 임시 데이터
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationDetailTableViewCell", for: indexPath) as! LocationDetailTableViewCell
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }

    // UITableViewDelegate 메서드 (선택적)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 여기에 특정 행이 선택되었을 때의 처리 로직을 구현합니다.
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
