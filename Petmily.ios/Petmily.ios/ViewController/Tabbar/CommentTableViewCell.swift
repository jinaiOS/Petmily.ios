//
//  CommentTableViewCell.swift
//  Petmily.ios
//
//  Created by 김지은 on 2/24/24.
//

import UIKit

final class CommentTableViewCell: UITableViewCell {
    static let identifier = "CommentTableViewCell"
    
    /** @brief 사용자 명, 베스트 stackview */
    lazy var stvProfile: UIStackView = {
       let stackview = UIStackView()
        stackview.spacing = 11
        [vBest, lblHeader].forEach { stackview.addArrangedSubview($0) }
        return stackview
    }()
    /** @brief 베스트 view */
    lazy var vBest: UIView = {
       let view = UIView()
        view.backgroundColor = .primary
        view.addSubview(lblBest)
        return view
    }()
    /** @brief 베스트 view */
    lazy var lblBest: UILabel = {
       let label = UILabel()
        label.text = "BEST"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    /** @brief 댓글 헤더 label */
    lazy var lblHeader: UILabel = {
       let label = UILabel()
        label.text = "댓글"
        label.font = .systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.4823529412, green: 0.4823529412, blue: 0.4823529412, alpha: 1)
        return label
    }()
    /** @brief 댓글 label */
    lazy var lblContent: UILabel = {
       let label = UILabel()
        label.text = "댓글"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    /** @brief 댓글 label */
    lazy var lblTime: UILabel = {
       let label = UILabel()
        label.text = "1분 전"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.4823529412, green: 0.4823529412, blue: 0.4823529412, alpha: 1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CommentTableViewCell {
    func setUI() {
        
    }
    
    func setLayout() {
        [stvProfile, lblContent, lblTime].forEach { addSubview($0) }
        
        stvProfile.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        vBest.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.width.equalTo(50)
        }
        
        lblBest.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(2)
            $0.leading.trailing.equalToSuperview().inset(9)
        }
        
        lblContent.snp.makeConstraints {
            $0.top.equalTo(stvProfile.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        lblTime.snp.makeConstraints {
            $0.top.equalTo(lblContent.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}
