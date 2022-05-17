//
// MMMTooltip. Part of MMMTemple suite.
// Copyright (C) 2016-2022 MediaMonks. All rights reserved.
//

import Foundation

public protocol MMMTooltipDelegate: AnyObject {
	
	func tooltipWillShow(_ tooltip: MMMTooltip, animated: Bool)
	func tooltipDidShow(_ tooltip: MMMTooltip, animated: Bool)
	func tooltipWillHide(_ tooltip: MMMTooltip, animated: Bool)
	func tooltipDidHide(_ tooltip: MMMTooltip, animated: Bool)
}

extension MMMTooltipDelegate {
	
	public func tooltipWillShow(_ tooltip: MMMTooltip, animated: Bool) {}
	public func tooltipDidShow(_ tooltip: MMMTooltip, animated: Bool) {}
	public func tooltipWillHide(_ tooltip: MMMTooltip, animated: Bool) {}
	public func tooltipDidHide(_ tooltip: MMMTooltip, animated: Bool) {}
}
