//
//  MonthHeader.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 20/08/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit
import JTAppleCalendar

class MonthHeader: JTACMonthReusableView, ViewCode {
    
    
    // MARK: Properties
    var delegate: CalendarHeaderDelegate?
    var titleLabel = UILabel()
    var weekDaysHeader = WeekDaysView()
    
    lazy var arrowRight: UIButton = {
        let imageView = UIButton()
        var image = UIImage()
        if #available(iOS 13.0, *) {
            let configuration = UIImage.SymbolConfiguration(pointSize: 24)
            image = (UIImage(systemName: "arrowtriangle.right.fill", withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate))!
        } else {
            // Fallback on earlier versions
        }
        imageView.setImage(image, for: .normal)
        imageView.tintColor = UIColor(named: "ActionColor")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        return imageView
    }()
    
   lazy var arrowLeft: UIButton = {
        let imageView = UIButton()
        var image = UIImage()
        if #available(iOS 13.0, *) {
            let configuration = UIImage.SymbolConfiguration(pointSize: 24)
            image = (UIImage(systemName: "arrowtriangle.left.fill", withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate))!
        } else {
            // Fallback on earlier versions
        }
        imageView.setImage(image, for: .normal)
        imageView.tintColor = UIColor(named: "ActionColor")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        return imageView
    }()
    
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(weekDaysHeader)
        addSubview(arrowRight)
        addSubview(arrowLeft)
    }
    
    // MARK: Initialized
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapLeftButton(){
        delegate?.didTapLeftButton()
    }
    
    @objc func didTapRightButton(){
        delegate?.didTapRightButton()
    }
    
    
    // MARK: Functions
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        weekDaysHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weekDaysHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            weekDaysHeader.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            weekDaysHeader.trailingAnchor.constraint(equalTo: trailingAnchor),
            weekDaysHeader.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            arrowRight.centerXAnchor.constraint(equalTo: centerXAnchor, constant: (frame.width/4)),
            arrowRight.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 0),
            
            arrowLeft.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -(frame.width/4)),
            arrowLeft.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 0)
            ])
    }
    
    func setupAdditionalConfigurantion() {
        titleLabel.textColor = UIColor(named:"TitleColor")!
    }
    
    func configureHeader(start: Date) {
        let formatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
        formatter.dateFormat = "MMMM"
        titleLabel.text = formatter.string(from: start)
        titleLabel.font = UIFont(name: "AvenirNext-Medium", size: 24)
    }
}
