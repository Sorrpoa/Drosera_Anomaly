// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GasAlertReceiver {
    event GasAnomalyAlert(string message);

    function triggerAlert(string calldata message) external {
        emit GasAnomalyAlert(message);
    }
}
