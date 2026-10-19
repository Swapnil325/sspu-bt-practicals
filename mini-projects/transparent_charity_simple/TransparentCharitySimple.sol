// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title TransparentCharitySimple
/// @notice Minimal charity contract with owner-verified charities, donations, and withdrawals.
contract TransparentCharitySimple {
    address public owner;

    // Verified charities that can receive donations and withdraw funds
    mapping(address => bool) public verifiedCharities;

    // Balance held for each charity until they withdraw
    mapping(address => uint256) public balances;

    event CharityVerified(address indexed charity);
    event DonationReceived(address indexed charity, address indexed donor, uint256 amount);
    event FundsWithdrawn(address indexed charity, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /// @notice Owner verifies a charity address after off-chain checks
    function verifyCharity(address _charity) external onlyOwner {
        require(_charity != address(0), "Invalid address");
        verifiedCharities[_charity] = true;
        emit CharityVerified(_charity);
    }

    /// @notice Donate ETH to a verified charity
    function donate(address _charity) external payable {
        require(verifiedCharities[_charity], "Charity not verified");
        require(msg.value > 0, "Donation must be positive");

        balances[_charity] += msg.value;
        emit DonationReceived(_charity, msg.sender, msg.value);
    }

    /// @notice Verified charity withdraws its accumulated funds
    function withdraw() external {
        require(verifiedCharities[msg.sender], "Only verified charity");

        uint256 amount = balances[msg.sender];
        require(amount > 0, "No funds to withdraw");

        // Effects
        balances[msg.sender] = 0;

        // Interaction
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");

        emit FundsWithdrawn(msg.sender, amount);
    }
}
