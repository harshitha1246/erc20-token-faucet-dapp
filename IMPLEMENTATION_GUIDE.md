# ERC-20 Token Faucet DApp - Implementation Guide

## Current Status

This document outlines the completed files and the remaining files that need to be created to complete the ERC-20 Token Faucet DApp project.

## Completed Files

✅ **README.md** - Comprehensive project documentation
✅ **.env.example** - Environment variables template  
✅ **contracts/Token.sol** - ERC-20 token smart contract
✅ **contracts/TokenFaucet.sol** - Faucet smart contract with rate limiting
✅ **hardhat.config.js** - Hardhat development framework configuration
✅ **package.json** - Node.js dependencies and scripts
✅ **docker-compose.yml** - Docker containerization configuration

## Remaining Files to Create

### 1. Smart Contract Tests
**File:** `contracts/test/TokenFaucet.test.js`

Should include tests for:
- Token deployment and minting
- Faucet claim functionality
- Cooldown period enforcement
- Lifetime limit enforcement
- Pause mechanism
- Admin controls
- Event emissions

### 2. Deployment Script
**File:** `scripts/deploy.js`

Should:
- Deploy Token contract
- Deploy TokenFaucet contract
- Set minter permissions
- Log contract addresses
- Verify contracts on Etherscan

### 3. Frontend Application
**Files in `frontend/` directory:**

- `src/App.jsx` - Main React component
- `src/main.jsx` - React entry point
- `src/components/WalletConnect.jsx` - Wallet connection UI
- `src/components/TokenDisplay.jsx` - Balance display
- `src/components/ClaimButton.jsx` - Claim functionality
- `src/utils/wallet.js` - Wallet connection logic
- `src/utils/contracts.js` - Smart contract interactions
- `src/utils/eval.js` - Evaluation interface (window.__EVAL__)
- `src/index.css` - Styling
- `package.json` - Frontend dependencies
- `vite.config.js` - Vite build configuration
- `Dockerfile` - Frontend container image

### 4. Frontend Dockerfile
**File:** `frontend/Dockerfile`

Should:
- Use Node.js base image
- Install dependencies
- Build React app
- Serve with nginx or similar
- Expose port 3000
- Implement /health endpoint

### 5. Project Configuration
**File:** `.gitignore`

Should ignore:
- node_modules/
- .env (but not .env.example)
- dist/
- artifacts/
- cache/
- .hardhat/

## Implementation Steps

### Step 1: Smart Contract Testing
```bash
npm install
npm test
```

### Step 2: Frontend Setup
```bash
cd frontend
npm install
npm run dev
```

### Step 3: Contract Deployment
```bash
# Set environment variables
cp .env.example .env
# Edit .env with your values

# Deploy to Sepolia
npm run deploy
```

### Step 4: Docker Build and Run
```bash
docker compose up
```

## Key Implementation Details

### Smart Contract Constants
- **FAUCET_AMOUNT**: 100 tokens per claim (100 * 10^18)
- **COOLDOWN_TIME**: 86400 seconds (24 hours)
- **MAX_CLAIM_AMOUNT**: 1000 tokens per user (1000 * 10^18)
- **MAX_SUPPLY**: 1,000,000 tokens

### Frontend Evaluation Interface
The frontend must expose `window.__EVAL__` with:

```javascript
window.__EVAL__ = {
  connectWallet: async () => { ... },
  requestTokens: async () => { ... },
  getBalance: async (address) => { ... },
  canClaim: async (address) => { ... },
  getRemainingAllowance: async (address) => { ... },
  getContractAddresses: async () => { ... }
}
```

### Network Configuration
- **Network**: Sepolia Testnet
- **Chain ID**: 11155111
- **RPC Provider**: Infura or similar
- **Block Explorer**: etherscan.io

## Testing Checklist

- [ ] Smart contracts compile without errors
- [ ] All tests pass
- [ ] Contracts deployed to Sepolia
- [ ] Contracts verified on Etherscan
- [ ] Frontend loads at http://localhost:3000
- [ ] Wallet connection works
- [ ] Token balance displays correctly
- [ ] Claim function works
- [ ] Cooldown enforced
- [ ] Lifetime limits enforced
- [ ] Error messages display correctly
- [ ] Docker container builds and runs
- [ ] Health endpoint returns 200
- [ ] All eval interface functions work

## Security Notes

1. Never commit .env files with real private keys
2. Use testnet keys only
3. Verify contracts on Etherscan
4. Test thoroughly before production
5. Implement proper error handling
6. Follow checks-effects-interactions pattern
7. Use OpenZeppelin contracts for ERC-20

## Helpful Resources

- [Hardhat Documentation](https://hardhat.org)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)
- [Ethers.js Documentation](https://docs.ethers.org/)
- [Sepolia Faucets](https://sepoliafaucet.com)
- [Etherscan Verification](https://etherscan.io/apis)

## Next Steps

1. Create remaining files listed above
2. Implement frontend application
3. Write comprehensive tests
4. Deploy to Sepolia testnet
5. Verify contracts on Etherscan
6. Test Docker deployment
7. Create demo video
8. Submit for evaluation
