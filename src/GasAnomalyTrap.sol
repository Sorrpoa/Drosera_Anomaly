// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ITrap {
    
    function collect() external view returns (bytes memory);
    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory);
}

contract GasAnomalyTrap is ITrap {
    uint256 public constant thresholdPercent = 1; 

    function collect() external view override returns (bytes memory) {
        return abi.encode(block.gaslimit, block.gaslimit - gasleft());
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        if (data.length < 2) return (false, "Insufficient data");

        uint256 total = 0;
        for (uint256 i = 1; i < data.length; i++) {
            (, uint256 used) = abi.decode(data[i], (uint256, uint256));
            total += used;
        }

        uint256 prevAvg = total / (data.length - 1);

        (, uint256 latestUsed) = abi.decode(data[0], (uint256, uint256));
        uint256 diff = latestUsed > prevAvg ? latestUsed - prevAvg : prevAvg - latestUsed;
        uint256 percent = (diff * 100) / prevAvg;

        if (percent >= thresholdPercent) {
            return (true, abi.encode("Gas usage anomaly detected!"));
        }

        return (false, "");
    }
}


