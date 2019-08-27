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
    
    let mediaCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MediaCell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TitleHeader")
        return collectionView
    }()
    
    func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.images = [UIImage(named: "camera")!, UIImage(named: "notes")!, UIImage(named: "mic")!, UIImage(named: "videoCamera")!, UIImage(named: "pencil")!]
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
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
            self.mediaCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.mediaCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.mediaCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
    }
    
}

extension MediaTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 250, height: 50)
    }
    
}

extension MediaTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.mediaCollectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = self.mediaCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TitleHeader", for: indexPath)
        headerView.backgroundColor = .purple
        return headerView
    }
    
}
