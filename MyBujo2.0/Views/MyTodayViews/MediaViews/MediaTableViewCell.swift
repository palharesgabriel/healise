//
//  MediaTableViewCell.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 26/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    
    var images: [UIImage]
    static let reuseIdentifier = "MediaTableCell"
    var delegate: MediaCollectionViewDelegate?
    
    let mediaCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        collectionView.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: "MediaCell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.images = [UIImage(named: "notes")!, UIImage(named: "pencil")!, UIImage(named: "mic")!, UIImage(named: "videoCamera")!, UIImage(named: "camera")!]
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.images = [UIImage]()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension MediaTableViewCell: ViewCode {
    
    func buildViewHierarchy() {
        self.contentView.addSubview(self.mediaCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.mediaCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.mediaCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.mediaCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.mediaCollectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
    }
    
}

extension MediaTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
    
}

extension MediaTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            delegate?.pushViewController(viewController: NotesViewController(title: "Note"))
        case 1:
            if #available(iOS 13.0, *) {
                delegate?.pushViewController(viewController: DrawingViewController(title: "Drawing"))
            } else {
                // Fallback on earlier versions
            }
        case 2:
            delegate?.pushViewController(viewController: NotesViewController())
        case 3:
            delegate?.pushViewController(viewController: NotesViewController())
        case 4:
            delegate?.pushViewController(viewController: PhotosViewController(title: "Capture"))
        default:
            print("fodeu")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.mediaCollectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as? MediaCollectionViewCell else { return MediaCollectionViewCell() }
        cell.iconImageView.image = images[indexPath.row]
        return cell
    }
    
}
