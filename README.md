# ERC-20 Token Faucet DApp

## Project Overview

A complete decentralized application (DApp) for distributing ERC-20 tokens through a faucet mechanism with rate limiting, cooldown periods, and lifetime claim limits. This project demonstrates end-to-end Web3 development including smart contracts, frontend integration, and deployment practices.

## Architecture

### Smart Contracts
- **Token.sol**: ERC-20 compliant token with minting functionality restricted to the faucet
- **TokenFaucet.sol**: Faucet contract managing token distribution with:
  - 24-hour cooldown between claims per address
  - Lifetime claim limit per address
  - Pause/unpause functionality for admin
  - Rate limiting and proper error handling

### Frontend
- React-based user interface with ethers.js for blockchain interactions
- MetaMask/Web3 wallet integration
- Real-time balance and claim status display
- Transaction confirmation feedback

### Deployment
- Deployed to Sepolia testnet
- Contracts verified on Etherscan
- Fully containerized with Docker

## Deployed Contracts

### Sepolia Testnet
- **Token Contract**: [View on Etherscan](https://sepolia.etherscan.io/address/YOUR_TOKEN_ADDRESS)
- **Faucet Contract**: [View on Etherscan](https://sepolia.etherscan.io/address/YOUR_FAUCET_ADDRESS)

## Quick Start

### Prerequisites
- Node.js 16+
- Docker and Docker Compose
- MetaMask or compatible Web3 wallet

### Local Development

```bash
# Clone the repository
git clone https://github.com/harshitha1246/erc20-token-faucet-dapp.git
cd erc20-token-faucet-dapp

# Copy environment variables
cp .env.example .env

# Edit .env with your configuration
# Set VITE_RPC_URL, VITE_TOKEN_ADDRESS, VITE_FAUCET_ADDRESS

# Start with Docker Compose
docker compose up

# Access application at http://localhost:3000
```

### Manual Development

```bash
# Install dependencies
npm install

# Compile smart contracts
npx hardhat compile

# Run tests
npx hardhat test

# Deploy to Sepolia
npx hardhat run scripts/deploy.js --network sepolia

# Start frontend development server
cd frontend
npm run dev
```

## Configuration

### Environment Variables

Create a `.env` file with the following:

```
VITE_RPC_URL=https://sepolia.infura.io/v3/YOUR_INFURA_KEY
VITE_TOKEN_ADDRESS=0xYourDeployedTokenAddress
VITE_FAUCET_ADDRESS=0xYourDeployedFaucetAddress
```

## Key Features

### Smart Contract
- ERC-20 compliant token implementation
- Maximum supply enforcement
- Fixed tokens per claim (100 tokens)
- 24-hour cooldown period per address
- Lifetime claim limit (1000 tokens per user)
- Admin-controlled pause/unpause mechanism
- Proper event emissions for all state changes
- Clear error messages for all failure cases

### User Interface
- Wallet connection status display
- Current balance display
- Claim eligibility indicator
- Cooldown countdown timer
- Remaining lifetime allowance display
- Loading states during transactions
- Error message display
- Transaction confirmation feedback

### Evaluation Interface

The frontend exposes `window.__EVAL__` object with:

```javascript
window.__EVAL__ = {
  connectWallet(): Promise<string>,        // Returns connected address
  requestTokens(): Promise<string>,        // Returns transaction hash
  getBalance(address: string): Promise<string>,
  canClaim(address: string): Promise<boolean>,
  getRemainingAllowance(address: string): Promise<string>,
  getContractAddresses(): Promise<{token: string, faucet: string}>
}
```

## Design Decisions

### Faucet Amount: 100 Tokens
- Provides meaningful testing quantities
- Prevents token flooding while remaining useful

### Cooldown Period: 24 Hours
- Prevents abuse of the faucet
- Aligns with common rate-limiting practices
- Allows reasonable user access frequency

### Maximum Supply: 1,000,000 Tokens
- Ensures sustainable token distribution
- Supports long-term faucet operation
- Prevents unlimited minting

### Lifetime Limit: 1000 Tokens per User
- Prevents single address accumulation
- Encourages distributed token ownership
- Reasonable for testing purposes

## Testing

### Smart Contract Tests

Comprehensive test coverage including:
- Token deployment and initial state verification
- Faucet deployment and configuration
- Successful token claims
- Cooldown period enforcement
- Lifetime limit enforcement
- Pause/unpause functionality
- Admin-only restrictions
- Event emission verification
- Edge cases and error conditions

Run tests with:
```bash
npx hardhat test
```

### Frontend Testing

Manually test:
1. Wallet connection and disconnection
2. Balance display accuracy
3. Claim button functionality during eligible periods
4. Cooldown timer accuracy
5. Error message clarity
6. Loading state feedback
7. Balance updates after successful claims

## Security Considerations

### Implemented Measures

1. **Reentrancy Protection**
   - State updates occur before external calls
   - Follows checks-effects-interactions pattern

2. **Access Control**
   - Only admin can pause/unpause
   - Only faucet can mint tokens
   - Proper require statements for validations

3. **Overflow Protection**
   - Uses Solidity 0.8+ built-in overflow protection
   - Careful arithmetic operations

4. **Rate Limiting**
   - Cooldown period enforcement
   - Lifetime claim limits
   - Pause mechanism for emergencies

5. **Input Validation**
   - Clear require conditions
   - Descriptive error messages

## Known Limitations

1. Single testnet deployment (Sepolia)
2. Frontend requires MetaMask or compatible wallet
3. Faucet operation depends on sufficient token balance
4. Admin pause functionality is manual

## Future Improvements

1. Multi-chain deployment support
2. Admin UI for pause/unpause control
3. Advanced analytics and monitoring
4. Alternative wallet integrations
5. Custom faucet parameters

## Project Structure

```
erc20-token-faucet-dapp/
├── contracts/
│   ├── Token.sol
│   ├── TokenFaucet.sol
│   └── test/
│       └── TokenFaucet.test.js
├── frontend/
│   ├── src/
│   │   ├── App.jsx
│   │   ├── components/
│   │   ├── utils/
│   │   │   ├── wallet.js
│   │   │   ├── contracts.js
│   │   │   └── eval.js
│   │   └── main.jsx
│   ├── public/
│   ├── Dockerfile
│   └── package.json
├── scripts/
│   └── deploy.js
├── docker-compose.yml
├── .env.example
├── hardhat.config.js
└── README.md
```

## Docker Deployment

### Build and Run

```bash
# Build the Docker image
docker compose build

# Start the application
docker compose up -d

# View logs
docker compose logs -f

# Stop the application
docker compose down
```

### Health Check

The application exposes a `/health` endpoint that returns HTTP 200 when ready:

```bash
curl http://localhost:3000/health
```

## Contributing

This is a submission for the Partnr Network Global Placement Program. Pull requests and issues are welcome.

## License

MIT

## Support

For issues or questions, please open an issue in this repository or contact the maintainers.
