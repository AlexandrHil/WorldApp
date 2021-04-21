//
//  WAPlaceCellTableViewCell.swift
//  WorldApp
//
//  Created by Alex on 15.03.21.
//

import UIKit
import SnapKit

class WAPlaceCell: UITableViewCell {

    static let reuseIdentifier: String = "WAPlaceCell"

    var favouriteWasTapped: (() -> Void)?

    // убираем звезду favourites
    var showFavIcon: Bool = true {
        didSet {
            self.favouriteImageView.isHidden = !self.showFavIcon
        }
    }

    private var isFavourite: Bool = false {
        didSet {
            self.favouriteImageView.image = isFavourite
                ? UIImage(systemName: "star.fill")
                : UIImage(systemName: "star")
        }
    }

    private lazy var cardContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.backgroundColor = .white

        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale

        return view
    }()

    private lazy var placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chicago.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var imageName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Chicago"
        label.font = UIFont.boldSystemFont(ofSize: 25)

        return label
    }()

    private lazy var imageDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
//        label.text = "The City of Chicago covers an area of 60,000 hectares and sits 176 meters (578 feet) above sea level on the southwestern shore of Lake Michigan. At 190 km wide and 495 km long, its the 5th largest body of fresh water in the world."

        return label
        }()

    // добавляем звездочку
    private lazy var favouriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .yellow
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favouriteTapped)))
        
        return imageView
    }()

    // переопределение инициализатора ячейки
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.initCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }

    // инициализация ячейки
    func initCell() {
        self.contentView.addSubview(self.cardContainerView)
        self.cardContainerView.addSubview(self.placeImageView)
        self.cardContainerView.addSubview(self.imageName)
        self.cardContainerView.addSubview(self.imageDescription)
        self.cardContainerView.addSubview(self.favouriteImageView)
        self.selectionStyle = .gray
    }

    // вызывается, когда ячейка будет выбираться
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.backgroundColor = selected ? .red : .white
    }

    // устанавливаем констрэйнты для ячейки
    override func updateConstraints() {
        self.cardContainerView.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.right.bottom.equalToSuperview().inset(15)
        }

        self.placeImageView.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(250)
        }

        self.imageName.snp.updateConstraints { (make) in
            make.top.equalTo(self.placeImageView.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
        }

        self.imageDescription.snp.updateConstraints { (make) in
            make.top.equalTo(self.imageName.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview().inset(15)
        }

        self.favouriteImageView.snp.updateConstraints { (make) in
            make.top.right.equalToSuperview().inset(15)
            make.size.equalTo(35)
        }

        super.updateConstraints()
    }

    func setCellData(imageName: String, imageDescription: String) {
        self.imageName.text = imageName
        self.imageDescription.text = imageDescription
        self.favouriteImageView.image = UIImage(systemName: "star")

        self.setNeedsUpdateConstraints()
    }

    func setCell(model: WAPlace) {
        self.imageName.text = model.title
        self.imageDescription.text = model.description
        self.isFavourite = model.isFavourite

        self.setNeedsUpdateConstraints()
    }

    @objc private func favouriteTapped() {
        self.isFavourite.toggle()
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

        self.favouriteWasTapped?()
    }
}
