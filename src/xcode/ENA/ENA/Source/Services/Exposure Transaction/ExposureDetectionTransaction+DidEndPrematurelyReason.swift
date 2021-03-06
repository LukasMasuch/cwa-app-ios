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

import Foundation
import ExposureNotification

extension ExposureDetection {
	enum DidEndPrematurelyReason: Error {
		/// Delegate was unable to provide an exposure manager to the transaction.
		case noExposureManager
		/// The actual exposure summary detection was started but did either produce an error
		/// or no summary.
		case noSummary(Error?)
		/// It was not possible to determine the remote days and/or hours that can be loaded.
		case noDaysAndHours
		/// Unable to get exposure configuration
		case noExposureConfiguration
		/// Unable to write diagnosis keys
		case unableToWriteDiagnosisKeys
		/// Unable to get supported countries
		case noSupportedCountries
		/// Unable to save key packages due to missing disk space
		case noDiskSpace
		/// User has the wrong device time, no risk calculation possible
		case wrongDeviceTime
	}
}

extension ExposureDetection.DidEndPrematurelyReason: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .noExposureManager:
			return AppStrings.ExposureDetectionError.errorAlertMessage + " Code: NoExposureManager"
		case .unableToWriteDiagnosisKeys:
			return AppStrings.ExposureDetectionError.errorAlertMessage + " Code: DignosisKeys"
		case .noSummary(let error):
			if let enError = error as? ENError {
				switch enError.code {
				case .unsupported:
					return AppStrings.Common.enError5Description
				case .internal:
					return AppStrings.Common.enError11Description
				case .rateLimited:
					return AppStrings.Common.enError13Description
				default:
					return AppStrings.ExposureDetectionError.errorAlertMessage + " EN Code: \(enError.code.rawValue)"
				}

			} else if let exposureDetectionError = error as? ExposureDetectionError {
				switch exposureDetectionError {
				case .isAlreadyRunning:
					return AppStrings.ExposureDetectionError.errorAlertMessage + " Code: ExposureDetectionIsAlreadyRunning"
				}
			} else {
				return AppStrings.ExposureDetectionError.errorAlertMessage + " Code: NoSummary"
			}
		case .noDaysAndHours:
			return AppStrings.ExposureDetectionError.errorAlertMessage + " Code: NoDaysAndHours"
		case .noExposureConfiguration:
			return AppStrings.ExposureDetectionError.errorAlertMessage + " Code: NoExposureConfiguration"
		case .noSupportedCountries:
			return AppStrings.ExposureDetectionError.errorAlertMessage + " Code: NoSupportedCountries"
		case .noDiskSpace:
			return AppStrings.ExposureDetectionError.errorAlertFullDistSpaceMessage
		case .wrongDeviceTime:
			return AppStrings.ExposureDetectionError.errorAlertWrongDeviceTime
		}
		
	}
}
