// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20, Ownable {
    uint256 public constant MAX_SUPPLY = 1_000_000 * 10 ** 18; // 1 million tokens
    address public minter;

    event MinterUpdated(address indexed newMinter);

    constructor(address _faucet) ERC20("Faucet Token", "FCT") {
        minter = _faucet;
        emit MinterUpdated(_faucet);
    }

    function setMinter(address _newMinter) external onlyOwner {
        require(_newMinter != address(0), "Invalid minter address");
        minter = _newMinter;
        emit MinterUpdated(_newMinter);
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender == minter, "Only minter can mint");
        require(totalSupply() + amount <= MAX_SUPPLY, "Exceeds max supply");
        _mint(to, amount);
    }

    function decimals() public pure override returns (uint8) {
        return 18;
    }
}
