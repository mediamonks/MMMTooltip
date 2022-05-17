//
// MMMTooltip. Part of MMMTemple suite.
// Copyright (C) 2016-2022 MediaMonks. All rights reserved.
//

import MMMTackKit
import UIKit

public final class MMMTooltip: UIView {
	
	public typealias Delegate = MMMTooltipDelegate
	
	private let containerView = UIView(frame: .zero)
	private let arrowView: ArrowView
	
	/// The view to use as content that is passed upon attaching the tooltip.
	public let contentView: UIView
	/// The button to place below the content, if any.
	public let buttonView: UIControl?
	
	/// The view this tooltip targets, as in, where we align to.
	public private(set) weak var targetView: UIView?
	private weak var targetSuperview: UIView?
	
	public weak var delegate: Delegate?
	
	/// Some user info you can attach to track the tooltip when using the delegate instead of closing the tooltips yourself.
	public var userInfo: [String: Any]?
	
	private let style: Style
	private let animation: Animation
	private let dismissal: Dismissal
	private var dismissalTimer: Timer?
	
	private init(
		style: Style,
		animation: Animation,
		dismissal: Dismissal,
		contentView: UIView,
		buttonView: UIControl?,
		targetView: UIView,
		targetSuperview: UIView
	) {
		
		self.style = style
		self.animation = animation
		self.dismissal = dismissal
		
		self.contentView = contentView
		self.buttonView = buttonView
		self.targetView = targetView
		self.targetSuperview = targetSuperview
		
		self.arrowView = ArrowView(style: style)
		
		super.init(frame: .zero)
		
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = .clear
		
		containerView.translatesAutoresizingMaskIntoConstraints = false
		containerView.backgroundColor = style.backgroundColor
		containerView.layer.masksToBounds = true
		containerView.layer.cornerRadius = style.cornerRadius
		addSubview(containerView)
		
		addSubview(arrowView)
		
		contentView.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(contentView)
		
		if let buttonView = buttonView {
			buttonView.translatesAutoresizingMaskIntoConstraints = false
			containerView.addSubview(buttonView)
		}
		
		targetSuperview.addSubview(self)
		
		do {
			
			Tack.align(
				view: containerView,
				to: self,
				horizontally: .fill,
				vertically: style.location.isTop ? .bottom : .top
			)
			
			if let buttonView = buttonView {
				
				Tack.align(
					view: contentView,
					to: containerView,
					horizontally: .fill,
					vertically: style.location.isTop ? .top : .bottom,
					insets: style.contentInsets
				)
				
				Tack.align(
					view: buttonView,
					to: containerView,
					horizontally: .fill,
					vertically: style.location.isTop ? .bottom : .top,
					insets: style.buttonInsets
				)
				
				let padding = style.contentInsets.bottom + style.buttonInsets.top
				
				Tack.activate(
					.V(contentView-(padding)-buttonView)
				)
			} else {
			
				Tack.align(
					view: contentView,
					to: containerView,
					horizontally: .fill,
					vertically: .fill,
					insets: style.contentInsets
				)
			}
			
			Tack.align(
				view: arrowView,
				to: self,
				vertically: style.location.isTop ? .top : .bottom
			)
			
			NSLayoutConstraint.activate([
				NSLayoutConstraint(
					item: self,
					attribute: .width,
					relatedBy: .lessThanOrEqual,
					toItem: targetSuperview,
					attribute: .width,
					multiplier: style.maxWidthMultiplier,
					constant: 0
				),
				NSLayoutConstraint(
					item: self,
					attribute: .leading,
					relatedBy: .greaterThanOrEqual,
					toItem: targetSuperview,
					attribute: .leading,
					multiplier: 1,
					constant: style.padding
				),
				NSLayoutConstraint(
					item: self,
					attribute: .trailing,
					relatedBy: .lessThanOrEqual,
					toItem: targetSuperview,
					attribute: .trailing,
					multiplier: 1,
					constant: -style.padding
				),
				NSLayoutConstraint(
					item: arrowView,
					attribute: .centerX,
					relatedBy: .equal,
					toItem: targetView,
					attribute: .centerX,
					multiplier: 1,
					constant: 0
				)
			])
			
			Tack.activate {
				switch style.location {
				case .bottomTrailing:
					
					Tack.V(self-(style.offset)-targetView)
					Tack.V(containerView-(0)-arrowView)
					
					NSLayoutConstraint(
						item: arrowView,
						attribute: .centerX,
						relatedBy: .equal,
						toItem: self,
						attribute: .trailing,
						multiplier: 1 - style.preferredPaddingMultiplier,
						priority: .defaultHigh - 1
					)
					
				case .bottomCenter:
					
					Tack.V(self-(style.offset)-targetView)
					Tack.V(containerView-(0)-arrowView)
					
					NSLayoutConstraint(
						item: arrowView,
						attribute: .centerX,
						relatedBy: .equal,
						toItem: self,
						attribute: .centerX,
						multiplier: 1,
						priority: .defaultHigh - 1
					)
					
				case .bottomLeading:
					
					Tack.V(self-(style.offset)-targetView)
					Tack.V(containerView-(0)-arrowView)
					
					NSLayoutConstraint(
						item: arrowView,
						attribute: .centerX,
						relatedBy: .equal,
						toItem: self,
						attribute: .trailing,
						multiplier: style.preferredPaddingMultiplier,
						priority: .defaultHigh - 1
					)
					
				case .topTrailing:
				
					Tack.V(targetView-(style.offset)-self)
					Tack.V(arrowView-(0)-containerView)
					
					NSLayoutConstraint(
						item: arrowView,
						attribute: .centerX,
						relatedBy: .equal,
						toItem: self,
						attribute: .trailing,
						multiplier: 1 - style.preferredPaddingMultiplier,
						priority: .defaultHigh - 1
					)
					
				case .topCenter:
				
					Tack.V(targetView-(style.offset)-self)
					Tack.V(arrowView-(0)-containerView)

					NSLayoutConstraint(
						item: arrowView,
						attribute: .centerX,
						relatedBy: .equal,
						toItem: self,
						attribute: .centerX,
						multiplier: 1,
						priority: .defaultHigh - 1
					)
					
				case .topLeading:
				
					Tack.V(targetView-(style.offset)-self)
					Tack.V(arrowView-(0)-containerView)
					
					NSLayoutConstraint(
						item: arrowView,
						attribute: .centerX,
						relatedBy: .equal,
						toItem: self,
						attribute: .trailing,
						multiplier: style.preferredPaddingMultiplier,
						priority: .defaultHigh - 1
					)
				}
			}
		}
		
		do {
			prepareAnimations()
			prepareDismissal()
		}
	}
	
	deinit {
		dismissalTimer?.invalidate()
	}
	
	@available(*, unavailable)
	internal required init?(coder: NSCoder) {
		fatalError("\(#function) has not been implemented")
	}
	
	/// Attach a tooltip to a given `targetView`.
	/// - Parameters:
	///   - targetView: The view to attach the tooltip to, make sure this view is in the view hierarchy already.
	///   - contentView: The view to use as content for the tooltip.
	///   - buttonView: The button to place below the content, if any.
	///   - style: The style definition for the tooltip.
	///   - animation: What animation we should use upon showing / hiding the tooltip.
	///   - dismissal: If we should dismisis the tooltip for you, e.g. upon button tap.
	///   - delegate: The delegate to attach, if any.
	/// - Returns: A reference to the tooltip, so you can set userInfo, the delegate or dismiss it yourself if neccesssary.
	public static func attachToView(
		_ targetView: UIView,
		contentView: UIView,
		buttonView: UIControl? = nil,
		style: Style,
		animation: Animation = .none,
		dismissal: Dismissal = .none,
		delegate: Delegate? = nil
	) -> MMMTooltip? {
		
		guard let targetSuperview = targetView.superview else {
			assertionFailure("""
			We can only attach a tooltip to a view that is already in the view hierarchy,
			missing a superview for target \(targetView)
			""")
			
			return nil
		}
		
		let tooltip = MMMTooltip(
			style: style,
			animation: animation,
			dismissal: dismissal,
			contentView: contentView,
			buttonView: buttonView,
			targetView: targetView,
			targetSuperview: targetSuperview
		)
		tooltip.delegate = delegate
		
		return tooltip
	}
	
	// MARK: - Public methods
	
	public func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
		
		dismissalTimer?.invalidate()
		dismissalTimer = nil
		
		guard animated else {
			self.delegate?.tooltipWillHide(self, animated: false)
			self.removeFromSuperview()
			completion?()
			self.delegate?.tooltipDidHide(self, animated: false)
			return
		}
		
		self.delegate?.tooltipWillHide(self, animated: true)
		
		let alpha: CGFloat
		let transform: CGAffineTransform
		
		switch animation {
		case .none:
			self.removeFromSuperview()
			completion?()
			self.delegate?.tooltipDidHide(self, animated: false)
			
			return
		case .fade:
			
			alpha = 0
			transform = .identity
			
		case .scale(let duration), .fadeAndScale(let duration):
			
			let size = self.systemLayoutSizeFitting(.zero)
			
			transform = {
				switch style.location {
				case .topLeading:
					return CGAffineTransform(
						translationX: -(size.width / 2),
						y: -(size.height / 2)
					).scaledBy(x: 0.001, y: 0.001)
					
				case .topCenter:
					return CGAffineTransform(
						translationX: 0,
						y: -(size.height / 2)
					).scaledBy(x: 0.001, y: 0.001)
					
				case .topTrailing:
					return CGAffineTransform(
						translationX: (size.width / 2),
						y: -(size.height / 2)
					).scaledBy(x: 0.001, y: 0.001)
				
				case .bottomLeading:
					return CGAffineTransform(
						translationX: -(size.width / 2),
						y: size.height / 2
					).scaledBy(x: 0.001, y: 0.001)
					
				case .bottomCenter:
					return CGAffineTransform(
						translationX: 0,
						y: size.height / 2
					).scaledBy(x: 0.001, y: 0.001)
					
				case .bottomTrailing:
					return CGAffineTransform(
						translationX: (size.width / 2),
						y: size.height / 2
					).scaledBy(x: 0.001, y: 0.001)
				}
			}()
			
			alpha = animation == .fadeAndScale(duration: duration) ? 0 : 1
			
		case .fadeAndSlide(_, let distance):
			alpha = 0
			transform = CGAffineTransform(
				translationX: 0,
				y: style.location.isTop ? distance : -distance
			)
		}
		
		UIView.animate(
			withDuration: animation.duration,
			delay: 0,
			usingSpringWithDamping: 0.7,
			initialSpringVelocity: 0.7,
			options: [],
			animations: {
				self.alpha = alpha
				self.transform = transform
			},
			completion: { [weak self] _ in
				guard let self = self else { return }
				self.removeFromSuperview()
				completion?()
				self.delegate?.tooltipDidHide(self, animated: true)
			}
		)
	}
	
	// MARK: -
	
	private func prepareAnimations() {
		
		self.delegate?.tooltipWillShow(self, animated: true)
		
		switch animation {
		case .none:
			self.delegate?.tooltipDidShow(self, animated: true)
			return
		case .fade:
			self.alpha = 0
		case .scale(let duration), .fadeAndScale(let duration):
			
			let size = self.systemLayoutSizeFitting(.zero)
			
			self.transform = {
				switch style.location {
				case .topLeading:
					return CGAffineTransform(
						translationX: -(size.width / 2),
						y: -(size.height / 2)
					).scaledBy(x: 0.001, y: 0.001)
					
				case .topCenter:
					return CGAffineTransform(
						translationX: 0,
						y: -(size.height / 2)
					).scaledBy(x: 0.001, y: 0.001)
					
				case .topTrailing:
					return CGAffineTransform(
						translationX: (size.width / 2),
						y: -(size.height / 2)
					).scaledBy(x: 0.001, y: 0.001)
				
				case .bottomLeading:
					return CGAffineTransform(
						translationX: -(size.width / 2),
						y: size.height / 2
					).scaledBy(x: 0.001, y: 0.001)
					
				case .bottomCenter:
					return CGAffineTransform(
						translationX: 0,
						y: size.height / 2
					).scaledBy(x: 0.001, y: 0.001)
					
				case .bottomTrailing:
					return CGAffineTransform(
						translationX: (size.width / 2),
						y: size.height / 2
					).scaledBy(x: 0.001, y: 0.001)
				}
			}()
			
			self.alpha = animation == .fadeAndScale(duration: duration) ? 0 : 1
			
		case .fadeAndSlide(_, let distance):
			self.alpha = 0
			self.transform = CGAffineTransform(
				translationX: 0,
				y: style.location.isTop ? distance : -distance
			)
		}
		
		UIView.animate(
			withDuration: animation.duration,
			delay: 0,
			usingSpringWithDamping: 0.7,
			initialSpringVelocity: 0.7,
			options: [],
			animations: {
				self.alpha = 1
				self.transform = .identity
			},
			completion: { [weak self] _ in
				guard let self = self else { return }
				self.delegate?.tooltipDidShow(self, animated: true)
			}
		)
	}
	
	private func prepareDismissal() {
		
		switch dismissal {
		case .none:
			break
		case .timer(let interval):
			
			dismissalTimer = Timer.scheduledTimer(
				timeInterval: interval,
				target: self,
				selector: #selector(dismissalCalled),
				userInfo: nil,
				repeats: false
			)
			
		case .buttonEvent(let event):
			
			guard let buttonView = buttonView else {
				assertionFailure("Dismissal \(dismissal) given but no button supplied")
				return
			}
			
			buttonView.addTarget(self, action: #selector(dismissalCalled), for: event)
		}
	}
	
	@objc private func dismissalCalled() {
		dismiss(animated: true, completion: nil)
	}
}
