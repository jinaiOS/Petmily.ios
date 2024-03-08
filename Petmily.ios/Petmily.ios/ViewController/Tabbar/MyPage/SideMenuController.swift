//
//  SideMenuController.swift
//  Petmily.ios
//
//  Created by JINHUN CHOI on 2024/03/02.
//

import UIKit

import SideMenu
import SnapKit

class SideMenuController: BaseViewController {
    // MARK: Properties
    private let sideMenus = [SideMenu(name: "저장된 글", icon: "rightArrow"), SideMenu(name: "계정", icon: "rightArrow"), SideMenu(name: "설정", icon: "rightArrow")]
    
    // MARK: Components
    private let menuTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}

// MARK: SetUp
extension SideMenuController {
    func setUp() {
        view.backgroundColor = .white
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        view.addSubview(menuTableView)
        
        menuTableView.snp.makeConstraints {
            $0.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(240)
        }
    }
}

extension SideMenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sideMenus[indexPath.row]
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(named: item.icon)
        content.text = item.name
        content.imageProperties.tintColor = .black
        content.imageProperties.maximumSize = CGSize(width: 20, height: 20)
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 24)
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: Struct
extension SideMenuController {
    struct SideMenu {
        var name: String
        var icon: String
    }
}
