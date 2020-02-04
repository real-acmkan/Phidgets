import Foundation
import Phidget22_C

/**
The Voltage Output class controls the variable DC voltage output on a Phidget board. This class provides settings for the output voltage as well as various safety controls.
*/
public class VoltageOutputBase : Phidget {

	public init() {
		var h: PhidgetHandle?
		PhidgetVoltageOutput_create(&h)
		super.init(h!)
		initializeEvents()
	}

	internal override init(_ handle: PhidgetHandle) {
		super.init(handle)
	}

	deinit {
		if (retained) {
			Phidget_release(&chandle)
		} else {
			uninitializeEvents()
			PhidgetVoltageOutput_delete(&chandle)
		}
	}

	/**
	Enable the output voltage by setting `Enabled` to true.

	*   Disable the output by seting `Enabled` to false to save power.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- enabled: The enabled value
	*/
	public func setEnabled(_ enabled: Bool) throws {
		let result: PhidgetReturnCode
		result = PhidgetVoltageOutput_setEnabled(chandle, (enabled ? 1 : 0))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	Enable the output voltage by setting `Enabled` to true.

	*   Disable the output by seting `Enabled` to false to save power.

	- returns:
	The enabled value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getEnabled() throws -> Bool {
		let result: PhidgetReturnCode
		var enabled: Int32 = 0
		result = PhidgetVoltageOutput_getEnabled(chandle, &enabled)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return (enabled == 0 ? false : true)
	}

	/**
	Enables the **failsafe** feature for the channel, with a given **failsafe time**.

	The **failsafe** feature is intended for use in applications where it is important for the channel to enter a known _safe state_ if the program controlling it locks up or crashes. If you do not enable the failsafe feature, the channel will carry out whatever instructions it was last given until it is explicitly told to stop.

	Enabling the failsafe feature starts a recurring **failsafe timer** for the channel. Once the failsafe timer is enabled, it must be reset within the specified time or the channel will enter a **failsafe state**. The failsafe timer may be reset either by calling this function again, or using the `ResetFailsafe` function. Resetting the failsafe timer will reload the timer with the specified _failsafe time_, starting when the message to reset the timer is received by the Phidget.

	For example: if the failsafe is enabled with a **failsafe time** of 1000ms, you will have 1000ms to reset the failsafe timer. Every time the failsafe timer is reset, you will have 1000ms from that time to reset the failsafe again.

	If the failsafe timer is not reset before it runs out, the channel will enter a **failsafe state**. For Voltage Output channels, this will set the output voltage to 0V. Once the channel enters the **failsafe state**, it will reject any further input until the channel is reopened.

	To prevent the channel from falsely entering the failsafe state, we recommend resetting the failsafe timer as frequently as is practical for your applicaiton. A good rule of thumb is to not let more than a third of the failsafe time pass before resetting the timer.

	Once the failsafe timer has been set, it cannot be disabled by any means other than closing and reopening the channel.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- failsafeTime: Failsafe timeout in milliseconds
	*/
	public func enableFailsafe(failsafeTime: UInt32) throws {
		let result: PhidgetReturnCode
		result = PhidgetVoltageOutput_enableFailsafe(chandle, failsafeTime)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `failsafeTime` can be set to when calling `EnableFailsafe`.

	- returns:
	The failsafe time

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinFailsafeTime() throws -> UInt32 {
		let result: PhidgetReturnCode
		var minFailsafeTime: UInt32 = 0
		result = PhidgetVoltageOutput_getMinFailsafeTime(chandle, &minFailsafeTime)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minFailsafeTime
	}

	/**
	The maximum value that `failsafeTime` can be set to when calling `EnableFailsafe`.

	- returns:
	The failsafe time

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxFailsafeTime() throws -> UInt32 {
		let result: PhidgetReturnCode
		var maxFailsafeTime: UInt32 = 0
		result = PhidgetVoltageOutput_getMaxFailsafeTime(chandle, &maxFailsafeTime)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxFailsafeTime
	}

	/**
	Resets the failsafe timer, if one has been set. See `EnableFailsafe` for details.

	This function will fail if no failsafe timer has been set for the channel.

	- throws:
	An error or type `PhidgetError`
	*/
	public func resetFailsafe() throws {
		let result: PhidgetReturnCode
		result = PhidgetVoltageOutput_resetFailsafe(chandle)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The voltage value that the channel will output.

	*   The `Voltage` value is bounded by `MinVoltage` and `MaxVoltage`.
	*   The voltage value will not be output until `Enabled` is set to true.

	- returns:
	The voltage value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getVoltage() throws -> Double {
		let result: PhidgetReturnCode
		var voltage: Double = 0
		result = PhidgetVoltageOutput_getVoltage(chandle, &voltage)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return voltage
	}

	/**
	The voltage value that the channel will output.

	*   The `Voltage` value is bounded by `MinVoltage` and `MaxVoltage`.
	*   The voltage value will not be output until `Enabled` is set to true.

	- parameters:
		- voltage: The voltage value
		- completion: Asynchronous completion callback
	*/
	public func setVoltage(_ voltage: Double, completion: @escaping (ErrorCode) -> ()) {
		let callback = AsyncCallback(completion)
		let callbackCtx = Unmanaged.passRetained(callback)
		PhidgetVoltageOutput_setVoltage_async(chandle, voltage, AsyncCallback.nativeAsyncCallback, UnsafeMutableRawPointer(callbackCtx.toOpaque()))
	}

	/**
	The voltage value that the channel will output.

	*   The `Voltage` value is bounded by `MinVoltage` and `MaxVoltage`.
	*   The voltage value will not be output until `Enabled` is set to true.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- voltage: The voltage value
	*/
	public func setVoltage(_ voltage: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetVoltageOutput_setVoltage(chandle, voltage)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `Voltage` can be set to.

	- returns:
	The voltage value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinVoltage() throws -> Double {
		let result: PhidgetReturnCode
		var minVoltage: Double = 0
		result = PhidgetVoltageOutput_getMinVoltage(chandle, &minVoltage)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minVoltage
	}

	/**
	The maximum value that `Voltage` can be set to.

	- returns:
	The voltage value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxVoltage() throws -> Double {
		let result: PhidgetReturnCode
		var maxVoltage: Double = 0
		result = PhidgetVoltageOutput_getMaxVoltage(chandle, &maxVoltage)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxVoltage
	}

	/**
	Choose a `VoltageOutputRange` that best suits your application.

	*   Changing the `VoltageOutputRange` will also affect the `MinVoltage` and `MaxVoltage` values.

	- returns:
	The output range value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getVoltageOutputRange() throws -> VoltageOutputRange {
		let result: PhidgetReturnCode
		var voltageOutputRange: PhidgetVoltageOutput_VoltageOutputRange = VOLTAGE_OUTPUT_RANGE_10V
		result = PhidgetVoltageOutput_getVoltageOutputRange(chandle, &voltageOutputRange)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return VoltageOutputRange(rawValue: voltageOutputRange.rawValue)!
	}

	/**
	Choose a `VoltageOutputRange` that best suits your application.

	*   Changing the `VoltageOutputRange` will also affect the `MinVoltage` and `MaxVoltage` values.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- voltageOutputRange: The output range value
	*/
	public func setVoltageOutputRange(_ voltageOutputRange: VoltageOutputRange) throws {
		let result: PhidgetReturnCode
		result = PhidgetVoltageOutput_setVoltageOutputRange(chandle, PhidgetVoltageOutput_VoltageOutputRange(voltageOutputRange.rawValue))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

}
