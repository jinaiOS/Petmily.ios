//
//  SideMenuTableViewCell.swift
//  Petmily.ios
//
//  Created by JINHUN CHOI on 2024/03/20.
//

import UIKit

import SnapKit

class SideMenuTableViewCell: UITableViewCell {
    // MARK: Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ThemeFont.b20
        return label
    }()
    
    private let icon: UIImageView = {
       let view = UIImageView()
        view.image = #imageLiteral(resourceName: "rightArrow.png")
        return view
    }()

    // MARK: LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: setUp
private extension SideMenuTableViewCell {
    func setUp() {
        setConstraints()
    }

    func setConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(icon)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Constants.Spacing.spacing16)
            $0.height.equalTo(30)
        }
        
        icon.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(Constants.Spacing.spacing16)
            $0.trailing.equalToSuperview().inset(Constants.Spacing.spacing16)
            $0.centerY.equalTo(titleLabel)
            $0.width.equalTo(12)
            $0.height.equalTo(20)
        }
    }
}

// MARK: Bind
extension SideMenuTableViewCell {
    func bind(title: String) {
        titleLabel.text = title
    }
}
