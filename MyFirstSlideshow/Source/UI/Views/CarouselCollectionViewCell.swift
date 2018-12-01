//
//  CarouselCollectionViewCell.swift
//  MyFirstSlideshow
//
//  Created by Tho Do on 01/12/2018.
//  Copyright © 2018 Yoti. All rights reserved.
//

import UIKit
import SnapKit

class CarouselCollectionViewCell: UICollectionViewCell {
    public override var reuseIdentifier: String {
        return String(describing: "\(CarouselCollectionViewCell.self)")
    }
    private let containerView = UIView(frame: .zero)
    private let topView = UIView(frame: .zero)
    private let topScrollView = UIScrollView(frame: .zero)
    private let topScrollViewContentView = UIView(frame: .zero)
    private let bottomView = UIView(frame: .zero)
    private let bottomPageControl = UIPageControl(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setupViews()
        setupLayout()
    }

    private func setupViews() {
        topScrollView.isPagingEnabled = true
        topScrollView.delegate = self
        topScrollView.showsHorizontalScrollIndicator = false
        topScrollView.showsVerticalScrollIndicator = false

        contentView.addSubview(containerView)
        containerView.addSubview(topView)
        containerView.addSubview(bottomView)
        topView.addSubview(topScrollView)
        topScrollView.addSubview(topScrollViewContentView)
        bottomView.addSubview(bottomPageControl)

        bottomPageControl.pageIndicatorTintColor = .lightGray
        bottomPageControl.currentPageIndicatorTintColor = .black
    }

    private func setupLayout() {
        containerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }

        topView.snp.remakeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.6)
        }

        bottomView.snp.remakeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        topScrollView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }

        topScrollViewContentView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().priority(ConstraintPriority.low)
        }

        bottomPageControl.snp.remakeConstraints {
            $0.top.leading.greaterThanOrEqualToSuperview()
            $0.trailing.bottom.lessThanOrEqualToSuperview()
            $0.center.equalToSuperview()
        }
    }

    private func layoutCarouselItems(with images: [UIImage]) {
        topScrollViewContentView.subviews.forEach { $0.removeFromSuperview() }
        images
            .map {
                let view = UIImageView(image: $0)
                view.contentMode = .scaleAspectFit
                return view
            }
            .forEach { [scrollViewContentView = topScrollViewContentView] in scrollViewContentView.addSubview( $0) }

        topScrollViewContentView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(images.count).priority(ConstraintPriority.low)
        }

        let subViews = topScrollViewContentView.subviews
        for (index, view) in subViews.enumerated() {
            if index == subViews.startIndex {
                view.snp.remakeConstraints {
                    $0.top.leading.bottom.equalToSuperview()
                    $0.width.equalTo(contentView)
                }
            } else if index == subViews.endIndex - 1 {
                view.snp.remakeConstraints {
                    $0.top.trailing.bottom.equalToSuperview()
                    $0.width.equalTo(contentView)
                }
            } else {
                guard let previousView = subViews[optionalAtIndex: index - 1]else { return }
                view.snp.remakeConstraints {
                    $0.top.bottom.equalToSuperview()
                    $0.leading.equalTo(previousView.snp.trailing)
                    $0.width.equalTo(contentView)
                }
            }
        }
    }

    func setup(with viewModel: CarouselCollectionViewCellViewModel) {
        bottomPageControl.numberOfPages = viewModel.images.count
        bottomPageControl.currentPage = 0
        layoutCarouselItems(with: viewModel.images)
    }
}

// MARK: - UIScrollViewDelegate
extension CarouselCollectionViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        bottomPageControl.currentPage = Int(currentPage)

        let maxHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x

        // vertical
        let maxVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y

        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maxHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maxVerticalOffset

        let targetPercentage: CGFloat = CGFloat(1 / topScrollViewContentView.subviews.count)
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        for index in 0...topScrollViewContentView.subviews.count {
            let currentPercentage = targetPercentage * CGFloat(index)
            if(percentOffset.x > CGFloat(index) && percentOffset.x <= targetPercentage * CGFloat(index)) {
                topScrollViewContentView.subviews[index].transform = CGAffineTransform(scaleX: (currentPercentage-percentOffset.x)/targetPercentage, y: (currentPercentage-percentOffset.x)/targetPercentage)

                topScrollViewContentView.subviews[index+1].transform = CGAffineTransform(scaleX: percentOffset.x/currentPercentage, y: percentOffset.x/currentPercentage)
            }
        }
    }
}


// MARK: Handy extensions, please move them out
class CarouselCollectionViewCellViewModel {
    let images: [UIImage]

    init(images: [UIImage]) {
        self.images = images
    }
}

extension CarouselCollectionViewCellViewModel {
    static func build(from: [[UIImage]]) -> [CarouselCollectionViewCellViewModel] {
        return from.map { CarouselCollectionViewCellViewModel(images: $0) }
    }
}

extension Collection {
    subscript(optionalAtIndex index: Self.Index) -> Element? {
        guard (startIndex..<endIndex) ~= index else { return nil }
        return self[index]
    }
}
