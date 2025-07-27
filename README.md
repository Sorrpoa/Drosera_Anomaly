# GasAnomalyTrap for Drosera

> A custom Drosera trap that detects abnormal gas usage on the Ethereum Hoodi Testnet.

## 🔍 What it does

This trap monitors gas usage (`gasUsed`) per block and compares it to the average over previous blocks.  
If the gas usage suddenly spikes by more than 50%, the trap responds.

## 🧠 How it works

### `collect()`

Encodes current block number, gas limit, and gas used:

```solidity
uint256 usedGas = block.gaslimit - gasleft();
return abi.encode(block.number, block.gaslimit, usedGas);```


## ✍️ Author

- Operator: `0x81303871d7bB5bBF9981636E797DBeC77bA276e5`
- GitHub: [Sorrpoa](https://github.com/Sorrpoa)
