//
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
//

import Foundation
import ExposureNotification
@testable import ENA

struct RiskHelpers { }

extension RiskHelpers {

	struct ExposureWindow: Decodable {

		// MARK: - Internal

		let ageInDays: Int
		let reportType: Int
		let infectiousness: Int
		let calibrationConfidence: Int
		let scanInstances: [ScanInstance]

		var exposureWindow: ENA.ExposureWindow {
			guard
				let date = Calendar.current.date(byAdding: .day, value: -ageInDays, to: Date()),
				let reportType = ENDiagnosisReportType(rawValue: UInt32(reportType)),
				let infectiousness = ENInfectiousness(rawValue: UInt32(infectiousness)),
				let calibrationConfidence = ENCalibrationConfidence(rawValue: UInt8(calibrationConfidence)) else {
				fatalError("failed to create ExposureWindow from TestData helper")
			}

			return ENA.ExposureWindow(
				date: date,
				reportType: reportType,
				infectiousness: infectiousness,
				calibrationConfidence: calibrationConfidence,
				scanInstances: []
			)
		}
	}

}
