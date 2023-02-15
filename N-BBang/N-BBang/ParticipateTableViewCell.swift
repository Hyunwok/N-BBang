//
//  ParticipateTableViewCell.swift
//  N-BBang
//
//  Created by 이현욱 on 2023/02/09.
//

import UIKit

final class ParticipateTableViewCell: UITableViewCell {
    static let cellID = "ParticipateTableViewCell"
    
    private lazy var nameLbl = UILabel()
    private lazy var personImageView = UIImageView()

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
    
    private func layout() {
        self.selectionStyle = .none
        
        self.contentView.addSubViews([personImageView, nameLbl])
        
        personImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(5)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        nameLbl.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(5)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(personImageView.snp.trailing).offset(5)
        }
    }
    
    func bind(with data: Person) {
        self.nameLbl.text = data.name
        if let data = data.image, let image = UIImage(data: data) {
            self.personImageView.image = image
        } else {
            self.personImageView.image = UIImage(systemName: "person.fill")
        }
    }
}
