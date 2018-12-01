//
//  CarouselViewController.swift
//  MyFirstSlideshow
//
//  Created by Luan Bach on 30/11/2018.
//  Copyright © 2018 Yoti. All rights reserved.
//

import UIKit
import SnapKit

struct CarouselConfiguration {
    static let lineSpacing: CGFloat = 10.0
}
class CarouselViewController: UIViewController {
    private let flowLayout = UICollectionViewFlowLayout()

    private lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
    }()

    private let images: [[UIImage]] = [
        [UIImage(named: "flag")!,
         UIImage(named: "cardiff")!,
         UIImage(named: "flag")!,
         UIImage(named: "cardiff")!],
        
        [UIImage(named: "cardiff")!,
        UIImage(named: "flag")!]
    ]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        commonSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }

    private func commonSetup() {
        setupViews()
        setupLayout()
    }

    private func setupViews() {
        view.backgroundColor = .white
        setupCollectionView()

        view.addSubview(collectionView)
    }

    private func setupCollectionView() {
        let collectionViewBackgroundView = UIView(frame: view.bounds)
        collectionViewBackgroundView.backgroundColor = view.backgroundColor
        collectionView.backgroundView = collectionViewBackgroundView

        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.reuseIdentifier)

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout - Handle drawing, configurations
extension CarouselViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let nItems = CGFloat(images.count)
        let itemsPadding = CarouselConfiguration.lineSpacing * (nItems - 1)
        let deviceSize = UIScreen.main.bounds.size
        let width = deviceSize.width
        let height = (deviceSize.height - itemsPadding) / nItems

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CarouselConfiguration.lineSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

// UICollectionViewDataSource - Providing data
extension CarouselViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.reuseIdentifier, for: indexPath) as? CarouselCollectionViewCell,
            let viewModel = CarouselCollectionViewCellViewModel.build(from: images)[optionalAtIndex: indexPath.row]
        else {
            return UICollectionViewCell(frame: .zero)
        }

        cell.setup(with: viewModel)

        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale

        return cell
    }


}
