// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IToken {
    function mint(address to, uint256 amount) external;
    function balanceOf(address account) external view returns (uint256);
}

contract TokenFaucet {
    IToken public token;
    address public admin;
    
    uint256 public constant FAUCET_AMOUNT = 100 * 10 ** 18; // 100 tokens per claim
    uint256 public constant COOLDOWN_TIME = 24 hours;
    uint256 public constant MAX_CLAIM_AMOUNT = 1000 * 10 ** 18; // Lifetime limit
    
    bool public paused = false;
    mapping(address => uint256) public lastClaimAt;
    mapping(address => uint256) public totalClaimed;
    
    event TokensClaimed(address indexed user, uint256 amount, uint256 timestamp);
    event FaucetPaused(bool paused);
    
    constructor(address _token) {
        token = IToken(_token);
        admin = msg.sender;
    }
    
    function requestTokens() external {
        require(!paused, "Faucet is paused");
        require(canClaim(msg.sender), "Not eligible to claim yet");
        require(totalClaimed[msg.sender] + FAUCET_AMOUNT <= MAX_CLAIM_AMOUNT, "Lifetime limit exceeded");
        
        lastClaimAt[msg.sender] = block.timestamp;
        totalClaimed[msg.sender] += FAUCET_AMOUNT;
        
        token.mint(msg.sender, FAUCET_AMOUNT);
        emit TokensClaimed(msg.sender, FAUCET_AMOUNT, block.timestamp);
    }
    
    function canClaim(address user) public view returns (bool) {
        if (paused) return false;
        if (lastClaimAt[user] == 0) return totalClaimed[user] < MAX_CLAIM_AMOUNT;
        if (block.timestamp < lastClaimAt[user] + COOLDOWN_TIME) return false;
        if (totalClaimed[user] >= MAX_CLAIM_AMOUNT) return false;
        return true;
    }
    
    function remainingAllowance(address user) public view returns (uint256) {
        if (totalClaimed[user] >= MAX_CLAIM_AMOUNT) return 0;
        return MAX_CLAIM_AMOUNT - totalClaimed[user];
    }
    
    function setPaused(bool _paused) external {
        require(msg.sender == admin, "Only admin can pause");
        paused = _paused;
        emit FaucetPaused(_paused);
    }
    
    function isPaused() external view returns (bool) {
        return paused;
    }
}
