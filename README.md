# 🚨 GasAnomalyTrap for Drosera

> A custom Drosera trap that detects sudden spikes in gas usage on the Ethereum Hoodi Testnet.

---

## 🔍 What it does

This trap monitors gas usage (`gasUsed`) in each block and compares it to the average gas usage of previous blocks.  
If the gas usage in the current block increases by **more than 50%**, the trap **triggers a response**.

It's useful for detecting:

- 🚨 Network anomalies  
- 📈 Spam or gas spikes  
- 🧪 Stress testing & flashbot activity

---

## 🧠 How it works

### 🔹 `collect()`

Encodes the following for each block:

```solidity
uint256 usedGas = block.gaslimit - gasleft();
return abi.encode(block.number, block.gaslimit, usedGas);
```

### 🔹 `shouldRespond(bytes[] calldata data)`

1. Takes N recent blocks (defined by `block_sample_size`)
2. Calculates the average `gasUsed` for previous N-1 blocks
3. Compares with current block's `gasUsed`
4. If the increase ≥ **thresholdPercent** (default 50%), returns `true`

```solidity
if (percent >= thresholdPercent) {
    return (true, abi.encode("Gas usage anomaly detected!"));
}
```

---

## 🛠 Response Mechanism

When triggered, the trap calls a function on your **response contract**:

```solidity
function triggerAlert(string calldata message) external {
    emit GasAnomalyAlert(message);
}
```

The response contract emits an event, which can be tracked or indexed:

```solidity
event GasAnomalyAlert(string message);
```

---

## ⚙️ Example `drosera.toml`

```toml
[traps.gasTrap]
path = "out/GasAnomalyTrap.sol/GasAnomalyTrap.json"
response_contract = "0xfD1e372D83A3f38d4be47b2DBc75FD88a0e12bDa"
response_function = "triggerAlert(string)"
cooldown_period_blocks = 33
block_sample_size = 10
min_number_of_operators = 1
max_number_of_operators = 2
private_trap = true
whitelist = ["0x81303871d7bB5bBF9981636E797DBeC77bA276e5"]
```

---

## ✍️ Author

- 🧾 **Operator Address**: `0x81303871d7bB5bBF9981636E797DBeC77bA276e5`  
- 🧑‍💻 **GitHub**: [Sorrpoa](https://github.com/Sorrpoa)

---
