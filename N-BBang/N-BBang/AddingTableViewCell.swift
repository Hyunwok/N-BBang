//
//  AddingTableViewCell.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/01/27.
//

import UIKit

import SnapKit

final class AddingTableViewCell: UITableViewCell {
    static let cellID = "AddingTableViewCell"
    
    private lazy var placeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "장소"
        lbl.font = .systemFont(ofSize: 13)
        lbl.textColor = .lightText
        return lbl
    }()
    
    lazy var placeTxtField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "장소를 입력해주세요"
        return txtField
    }()
    
    private lazy var participateLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "참가자"
        lbl.font = .systemFont(ofSize: 13)
        lbl.textColor = .lightText
        return lbl
    }()
    
    lazy var participateTxtField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "인원을 입력해주세요"
        return txtField
    }()
    
    lazy var editMoneyBtn: UIButton = {
        let btn = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        let image = UIImage(systemName: "square.and.pencil", withConfiguration: imageConfig)?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    lazy var captionBtn: UIButton = {
        let btn = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        let image = UIImage(systemName: "camera", withConfiguration: imageConfig)?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    lazy var moneyTxtField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "금액을 입력해주세요"
        return txtField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        alaoyut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func alaoyut() {
        self.selectionStyle = .none
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.addArrangedSubviews([view1, view2, view3])
        
        view1.addSubViews([placeLbl, placeTxtField])
        view2.addSubViews([participateLbl, participateTxtField])
        view3.addSubViews([editMoneyBtn, captionBtn, moneyTxtField])
        self.contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        participateLbl.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        participateTxtField.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.leading.equalTo(participateLbl.snp.trailing).offset(10)
            $0.top.bottom.equalToSuperview()
        }
        
        placeTxtField.snp.makeConstraints {
            $0.leading.equalTo(placeLbl.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview()
        }
        
        placeLbl.snp.makeConstraints {
            $0.width.equalTo(34)
            $0.bottom.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        moneyTxtField.snp.makeConstraints {
            $0.bottom.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
        
        editMoneyBtn.snp.makeConstraints {
            $0.bottom.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(editMoneyBtn.snp.height)
        }
        
        captionBtn.snp.makeConstraints {
            $0.bottom.top.equalToSuperview()
            $0.leading.equalTo(editMoneyBtn.snp.trailing)
            $0.width.equalTo(editMoneyBtn.snp.height)
            $0.trailing.equalTo(moneyTxtField.snp.leading).offset(-20)
        }
    }
}
