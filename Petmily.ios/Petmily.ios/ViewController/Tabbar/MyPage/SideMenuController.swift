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
    private let sideMenus = [SideMenu.savePosts, SideMenu.account, SideMenu.settings]
    
    // MARK: Components
    private let menuTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.register(SideMenuTableViewCell.self, forCellReuseIdentifier: SideMenuTableViewCell.identifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.identifier) as? SideMenuTableViewCell else { return UITableViewCell() }
        cell.bind(title: sideMenus[indexPath.row].rawValue)
        return cell
    }
}

// MARK: Struct
extension SideMenuController {
    enum SideMenu: String {
        case savePosts = "저장된 글"
        case account = "계정"
        case settings = "설정"
    }
}
