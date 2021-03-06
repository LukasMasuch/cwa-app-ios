// Corona-Warn-App
//
// SAP SE and all other contributors
// copyright owners license this file to you under the Apache
// License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import UIKit

@IBDesignable
final class ExposureSubmissionQRScannerFocusView: UIView {
	@IBInspectable var backdropOpacity: CGFloat = 0
	@IBInspectable var cornerRadius: CGFloat = 0
	@IBInspectable var borderWidth: CGFloat = 1

	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()

		backgroundColor = UIColor(white: 1, alpha: 0.5)

		awakeFromNib()
	}

	override func awakeFromNib() {
		super.awakeFromNib()

		layer.cornerRadius = cornerRadius
		layer.borderWidth = borderWidth
		layer.borderColor = tintColor.cgColor
	}
}
