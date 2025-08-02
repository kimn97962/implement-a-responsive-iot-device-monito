pragma solidity ^0.8.0;

contract IoTDeviceMonitor {
    struct Device {
        string deviceId;
        string deviceName;
        uint256 temperature;
        uint256 humidity;
        bool isConnected;
    }

    mapping (string => Device) public devices;

    event DeviceAdded(string deviceId, string deviceName);
    event DeviceUpdated(string deviceId, uint256 temperature, uint256 humidity);
    event DeviceDisconnected(string deviceId);

    function addDevice(string memory _deviceId, string memory _deviceName) public {
        devices[_deviceId] = Device(_deviceId, _deviceName, 0, 0, true);
        emit DeviceAdded(_deviceId, _deviceName);
    }

    function updateDevice(string memory _deviceId, uint256 _temperature, uint256 _humidity) public {
        require(devices[_deviceId].isConnected == true, "Device is not connected");
        devices[_deviceId].temperature = _temperature;
        devices[_deviceId].humidity = _humidity;
        emit DeviceUpdated(_deviceId, _temperature, _humidity);
    }

    function disconnectDevice(string memory _deviceId) public {
        require(devices[_deviceId].isConnected == true, "Device is not connected");
        devices[_deviceId].isConnected = false;
        emit DeviceDisconnected(_deviceId);
    }
}