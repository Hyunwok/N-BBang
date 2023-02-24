//
//  EditMoneyTableViewCell.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/28.
//

import UIKit
import RxSwift

class EditMoneyTableViewCell: UITableViewCell {
    static let cellID = "EditMoneyTableViewCell"
    
    var disposeBag = DisposeBag()
    
    private lazy var nameLabel: UILabel = {
       let lbl = UILabel()
//        lbl.
        return lbl
    }()
    
    lazy var priceField: UITextField = {
       let lbl = UITextField()
//        lbl.
        return lbl
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setting(person: Person) {
        nameLabel.text = person.name
        priceField.text = String(person.loan)
    }
    
    private func layout() {
        self.contentView.addSubViews([nameLabel, priceField])
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width / 4)
        }
        
        priceField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(20)
        }
    }
}
