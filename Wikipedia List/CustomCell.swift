//
//  CustomCell.swift
//  Wikipedia List
//
//  Created by Kapil on 05/02/21.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {

    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()

    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailImageView.image = nil
    }

    private func setupView() {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subtitleLabel)
        addSubview(thumbnailImageView)
        addSubview(labelStackView)

        let guide = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10),
            thumbnailImageView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            labelStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30),
            labelStackView.centerYAnchor.constraint(equalTo: guide.centerYAnchor)
        ])
    }
}
