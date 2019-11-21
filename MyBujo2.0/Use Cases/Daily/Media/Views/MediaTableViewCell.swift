//
//  MediaTableViewCell.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 26/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    
    
    // MARK: Properties
    let iconNames = [(sf: "text.justifyleft", normal: "notes"), (sf: "pencil.and.outline", normal: "pencil"), (sf: "mic", normal: "mic"), (sf: "camera", normal: "camera"), (sf: "video", normal: "videoCamera")]
    let iconName = ["Note","Sketch","Audio","Photo"]
    static let reuseIdentifier = "MediaTableCell"
    weak var delegate: MediaCollectionViewDelegate?
    
    let mediaCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: "MediaCell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupView()
    }
    
    let mediasLabel = ["Note","Drawing", "Captures", "Videos"]
    lazy var mediasLabels: [UILabel] = {
        var labels = [UILabel]()
        self.mediasLabel.forEach { name in
            labels.append(UILabel(dayName: name))
        }
        return labels
    }()
    
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}


    // MARK: Extensions
extension MediaTableViewCell: ViewCode {
    
    func buildViewHierarchy() {
        self.contentView.addSubview(self.mediaCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.mediaCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.mediaCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.mediaCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.mediaCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
    }
    
}

extension MediaTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.height - 16, height: frame.height - 16)
    }
    
}

extension MediaTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
			delegate?.pushMediaController(viewController: NotesViewController())
        case 1:
            if #available(iOS 13.0, *) {
                delegate?.pushMediaController(viewController: DrawingViewController())
            } else {
                // Fallback on earlier versions
            }
        case 2:
            if #available(iOS 13.0, *) {
                delegate?.pushMediaController(viewController: AudioViewController())
            } else {
                // Fallback on earlier versions
            }
        case 3:
			delegate?.pushMediaController(viewController: CapturesViewController())
//        case 4:
//            delegate?.pushViewController(viewController: VideoRecordViewController(title: mediasLabels[3].text!))
        default:
            print("Error")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.mediaCollectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as? MediaCollectionViewCell else { return MediaCollectionViewCell() }
        
        if let dayData = CoreDataManager.getDayData(day:CalendarManager.shared.selectedDay.date!) {
            print(dayData)
            switch indexPath.row {
            case 0:
                   if dayData.hasNotesInDay {
                    cell.shadowView.layer.borderWidth = 2
                    cell.shadowView.layer.borderColor = UIColor(named: "SelectionColor")?.cgColor
                   }
            case 1:
                if dayData.hasDrawsInDay {
                   cell.shadowView.layer.borderWidth = 2
                   cell.shadowView.layer.borderColor = UIColor(named: "SelectionColor")?.cgColor
                    }
            case 2:
                   if dayData.hasAudiosInDay {
                   cell.shadowView.layer.borderWidth = 2
                   cell.shadowView.layer.borderColor = UIColor(named: "SelectionColor")?.cgColor
                    }
            case 3:
                   if dayData.hasPhotosInDay {
                   cell.shadowView.layer.borderWidth = 2
                   cell.shadowView.layer.borderColor = UIColor(named: "SelectionColor")?.cgColor
                    }
            default:
                   print("erro ao retornar Media gravada no dia")
               }
        }
        
        
       
        if #available(iOS 13.0, *) {
            cell.setupCell(imageName: iconNames[indexPath.row].sf,mediaName: iconName[indexPath.row],validateMedia: false)
        } else {
            cell.setupCell(imageName: iconNames[indexPath.row].normal,mediaName: iconName[indexPath.row],validateMedia: false)
        }
        return cell
    }
    
    
    
}
