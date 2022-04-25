//
//  MainCell.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

import UIKit
import Combine

final class MainCell: UITableViewCell, Identifiable, Adaptable {
    
    struct Constants {
        static let titleFontSize: CGFloat = 12.0
        static let subTitleFontSize: CGFloat = 20.0
        static let cellImaveViewContainerWidth: CGFloat = 100.0
        static let baseMargin: CGFloat = 12.0
        static let baseStackViewSpacing: CGFloat = 12.0
        static let smallStackViewSpacing: CGFloat = 12.0
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: Constants.titleFontSize)
        $0.numberOfLines = 0
    }
    
    private lazy var firstSubTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: Constants.subTitleFontSize)
    }
    
    private lazy var secoundSubTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: Constants.subTitleFontSize)
    }
    
    @UsesAutoLayout
    private var cellImaveView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = (Constants.cellImaveViewContainerWidth  - Constants.baseMargin * 2) / 2
        $0.clipsToBounds = true
    }
    
    @UsesAutoLayout
    private var cellImaveViewContainer = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        $0.layer.cornerRadius = Constants.cellImaveViewContainerWidth / 2
        $0.clipsToBounds = true
    }
    
    @UsesAutoLayout
    private var mainStackView = UIStackView().then {
        $0.spacing = Constants.baseStackViewSpacing
        $0.axis = .vertical
    }
    
    private lazy var subTitlesStackView = UIStackView().then {
        $0.alignment = .leading
        $0.axis = .vertical
        $0.spacing = Constants.smallStackViewSpacing
    }
    
    private var cancellable: AnyCancellable?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        cellImaveView.image = nil
        cancellable?.cancel()
    }
    
    
    func adapt(model: DisplayableTask) {
        titleLabel.text = model.cellDescription
        firstSubTitleLabel.text = model.firstSubTitle
        secoundSubTitleLabel.text = model.secoundSubTitle
        
        if let url = model.imageUrl {
            cancellable = ImageLoader.shared
                .loadImage(from: url)
                .sink { [unowned self] image in cellImaveView.image = image }
        }
    }
    
    private func addSubviews() {
        [cellImaveViewContainer, mainStackView].forEach {
            contentView.addSubview($0)
        }
        
        cellImaveViewContainer.addSubview(cellImaveView)
        
        [subTitlesStackView, titleLabel].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        [firstSubTitleLabel, secoundSubTitleLabel].forEach {
            subTitlesStackView.addArrangedSubview($0)
        }
    }
    
    private func buildUI() {
        NSLayoutConstraint.activate([
            cellImaveViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.baseMargin),
            cellImaveViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.baseMargin),
            cellImaveViewContainer.widthAnchor.constraint(equalToConstant: Constants.cellImaveViewContainerWidth),
            cellImaveViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.baseMargin),
            
            cellImaveView.leadingAnchor.constraint(equalTo: cellImaveViewContainer.leadingAnchor, constant: Constants.baseMargin),
            cellImaveView.trailingAnchor.constraint(equalTo: cellImaveViewContainer.trailingAnchor, constant: -Constants.baseMargin),
            cellImaveView.topAnchor.constraint(equalTo: cellImaveViewContainer.topAnchor, constant: Constants.baseMargin),
            cellImaveView.heightAnchor.constraint(equalTo: cellImaveView.widthAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: cellImaveViewContainer.trailingAnchor, constant: Constants.baseMargin),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.baseMargin),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.baseMargin),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.baseMargin)
        ])
    }
}
