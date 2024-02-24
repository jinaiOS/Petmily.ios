//
//  CommentViewController.swift
//  Petmily.ios
//
//  Created by 김지은 on 2/24/24.
//

import UIKit

class CommentViewController: UIViewController {
    
    private let commentView = CommentView()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(commentView)
        
        commentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        configure()
    }

}

private extension CommentViewController {
    func configure() {
        commentView.tvComment.delegate = self
        commentView.tvComment.dataSource = self
    }
}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
}
