//
// MMMTooltip. Part of MMMTemple suite.
// Copyright (C) 2016-2022 MediaMonks. All rights reserved.
//

import UIKit

extension MMMTooltip {
	
	public enum Animation: Equatable {
		/// No animation upon attach / dismiss.
		case none
		/// Fade in when attaching, fade out upon dismisssing the tooltip.
		case fade(duration: TimeInterval)
		/// Scale-in when attaching, scale-out upon dismisssing the tooltip.
		case scale(duration: TimeInterval)
		/// Scale and fade-in when attaching, scale and fade-out upon dismisssing the tooltip.
		case fadeAndScale(duration: TimeInterval)
		/// Slide and fade-in when attaching, slide and fade-out upon dismisssing the tooltip.
		case fadeAndSlide(duration: TimeInterval, distance: CGFloat)
		
		internal var duration: TimeInterval {
			switch self {
			case .none: return 0
			case .fade(let duration), .scale(let duration), .fadeAndScale(let duration):
				return duration
			case .fadeAndSlide(let duration, _):
				return duration
			}
		}
	}
}
