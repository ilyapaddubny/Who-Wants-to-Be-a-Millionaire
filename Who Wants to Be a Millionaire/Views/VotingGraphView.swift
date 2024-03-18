//
//  VotingGraphView.swift
//  Who Wants to Be a Millionaire
//
//  Created by VASILY IKONNIKOV on 02.03.2024.
//

import UIKit

protocol VotingGraphViewDelegate: AnyObject {
	func votingGraphViewNeedsVotePercentages(_ votingGraphView: VotingGraphView) -> [Int]
}

class VotingGraphView: UIView {
	weak var delegate: VotingGraphViewDelegate?

	private var votePercentages: [Int] = [0, 0, 0, 0]
	private let columnLabels = ["A", "B", "C", "D"]
	private let bottomPadding: CGFloat = 40
	private let columnLabelFontSize: CGFloat = 25
	private let percentageFontSize: CGFloat = 14
	private let labelBottomMargin: CGFloat = 5
	private let percentageLabelBottomMargin: CGFloat = 5

	override func draw(_ rect: CGRect) {
		super.draw(rect)

		updateVotePercentages()
		
		let columnWidth = rect.width / CGFloat(votePercentages.count * 2 + 1)
		let spacing = columnWidth

		for (index, percentage) in votePercentages.enumerated() {
			drawColumn(index: index, percentage: percentage, rect: rect, columnWidth: columnWidth, spacing: spacing)
		}
	}

	private func drawColumn(index: Int, percentage: Int, rect: CGRect, columnWidth: CGFloat, spacing: CGFloat) {
		let xPosition = CGFloat(index) * (columnWidth + spacing) + spacing
		let columnHeight = (rect.height - bottomPadding) * CGFloat(percentage) / 100
		let columnRect = CGRect(x: xPosition, y: rect.height - columnHeight - bottomPadding, width: columnWidth, height: columnHeight)

		let path = UIBezierPath(roundedRect: columnRect, cornerRadius: 5)
		UIColor.green.setFill() //random().setFill()
		path.fill()

		drawPercentageText(percentage: percentage, rect: rect, columnRect: columnRect, xPosition: xPosition, columnWidth: columnWidth)
		drawColumnLabel(index: index, xPosition: xPosition, rect: rect, columnWidth: columnWidth)
	}

	private func drawPercentageText(percentage: Int, rect: CGRect, columnRect: CGRect, xPosition: CGFloat, columnWidth: CGFloat) {
		let text = "\(percentage)%"
		let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: percentageFontSize), .foregroundColor: UIColor.white]
		let textSize = text.size(withAttributes: attributes)
		let textYPosition = max(rect.height - columnRect.height - bottomPadding - textSize.height - percentageLabelBottomMargin, 0)
		let textRect = CGRect(x: xPosition + (columnWidth - textSize.width) / 2, y: textYPosition, width: textSize.width, height: textSize.height)
		text.draw(in: textRect, withAttributes: attributes)
	}

	private func drawColumnLabel(index: Int, xPosition: CGFloat, rect: CGRect, columnWidth: CGFloat) {
		let label = columnLabels[index]
		let labelAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: columnLabelFontSize), .foregroundColor: UIColor.white]
		let labelSize = label.size(withAttributes: labelAttributes)
		let labelRect = CGRect(x: xPosition + (columnWidth - labelSize.width) / 2, y: rect.height - labelSize.height - labelBottomMargin, width: labelSize.width, height: labelSize.height)
		label.draw(in: labelRect, withAttributes: labelAttributes)
	}

	private func updateVotePercentages() {
		if let percentages = delegate?.votingGraphViewNeedsVotePercentages(self) {
			self.votePercentages = percentages
		}
	}
}

extension UIColor {
	static func random() -> UIColor {
		return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
	}
}
