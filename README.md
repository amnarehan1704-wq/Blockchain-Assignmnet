# Campus Lost & Found dApp

**Course:** MG3012 – Blockchain Technology for Business (BSFT, Fall 2026)
**Assignment 2:** Mini dApp – Solidity Smart Contract + HTML/JS Frontend
**Network:** Sepolia testnet

## Idea
Students often lose items on campus (ID cards, bags, laptops, bottles). This dApp lets anyone
report a lost or found item on the blockchain, so the record is public, timestamped, and cannot
be edited or deleted by anyone.

## Contract
- **Address (Sepolia):** `0x88aC87497C0C10FFC3c43bd64Ab4DF6C8b4ceF85`
- **Etherscan:** https://sepolia.etherscan.io/address/0x88aC87497C0C10FFC3c43bd64Ab4DF6C8b4ceF85

| Function | Type | Description |
|---|---|---|
| `reportItem(title, description, location, isLost)` | write | Report a lost or found item |
| `claimItem(id)` | write | Claim an open item (reporter cannot claim own item) |
| `markReturned(id)` | write | Reporter confirms the item was returned |
| `getItemCount()` | read | Total number of items |
| `getItem(id)` | read | Full details of one item |

Item lifecycle: `Open → Claimed → Returned`

## Project Structure
```
├── SmartContract.sol
├── index.html
├── style.css
├── README.md
└── screenshots/
```

## Setup
1. **Deploy the contract**
   - Open [Remix IDE](https://remix.ethereum.org) and create `SmartContract.sol`, paste the code.
   - Compile with Solidity `0.8.20` or newer.
   - In *Deploy & Run*, choose **Injected Provider – MetaMask** (MetaMask must be on **Sepolia**).
   - Click **Deploy** and confirm in MetaMask. Copy the deployed contract address.
2. **Get test ETH** from any Sepolia faucet if your wallet is empty.
3. **Configure the frontend**
   - Open `index.html` and set `CONTRACT_ADDRESS` to your deployed contract address (already set to the address above).
4. **Run the frontend**
   - Open `index.html` through a local server (MetaMask does not inject into `file://` pages in some browsers):
     - VS Code: install *Live Server* → right-click `index.html` → *Open with Live Server*, or
     - Terminal: `python -m http.server 8000` then visit `http://localhost:8000`.
5. Click **Connect MetaMask**, report an item, and approve the transaction.

## Technologies
Solidity, Remix IDE, MetaMask, ethers.js v6, HTML, CSS, JavaScript.

## Screenshots
See the `screenshots/` folder:
1. `1_deployment.png` – contract deployed in Remix
2. `2_wallet_connected.png` – UI with MetaMask connected
3. `3_transaction.png` – report-item transaction confirmed

## Author
Amna Rehan – 24i-5581
