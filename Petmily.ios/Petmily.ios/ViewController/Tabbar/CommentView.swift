//
//  CommentView.swift
//  Petmily.ios
//
//  Created by 김지은 on 2/24/24.
//

import UIKit

class CommentView: UIView {
    /** @brief 댓글 헤더 label */
    lazy var lblHeader: UILabel = {
       let label = UILabel()
        label.text = "댓글"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = ThemeColor.black
        return label
    }()
    /** @brief 헤더 구분선 view */
    lazy var vHeaderLine: UIView = {
       let view = UIView()
        view.backgroundColor = ThemeColor.lightGray
        return view
    }()
    /** @brief 댓글 tableview */
    lazy var tvComment: UITableView = {
       let tableview = UITableView()
        tableview.separatorColor = ThemeColor.clear
        tableview.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        return tableview
    }()
    /** @brief 댓글 textview conatinerview */
    lazy var vTxvComment: UIView = {
       let view = UIView()
        view.borderColor = ThemeColor.darkGray
        view.borderWidth = 1
        view.cornerRadius = 17.5
        [txvComment, btnComment].forEach { view.addSubview($0) }
        return view
    }()
    /** @brief 댓글 textview */
    lazy var txvComment: UITextView = {
       let textview = UITextView()
        return textview
    }()
    /** @brief 댓글 달기 button */
    lazy var btnComment: UIButton = {
       let button = UIButton()
        button.setImage(PetmilyImage.comment, for: .normal)
        return button
    }()

    init() {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        backgroundColor = .white
        
        [lblHeader, vHeaderLine, tvComment, vTxvComment].forEach { addSubview($0) }
        
        lblHeader.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
        }
        
        vHeaderLine.snp.makeConstraints {
            $0.top.equalTo(lblHeader.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        tvComment.snp.makeConstraints {
            $0.top.equalTo(vHeaderLine.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        vTxvComment.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.top.equalTo(tvComment.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(40)
        }
        
        txvComment.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        btnComment.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalTo(45)
            $0.leading.equalTo(txvComment.snp.trailing)
        }
    }
}
