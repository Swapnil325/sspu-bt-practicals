# Transparent Charity (Simple)

This mini-project contains a minimal Solidity smart contract for a transparent charity flow:

- Owner (deployer) verifies charity addresses after off-chain checks.
- Donors send ETH to verified charities using `donate(charityAddress)`.
- Verified charities withdraw accumulated funds with `withdraw()`.

Files:
- mini-projects/transparent_charity_simple/TransparentCharitySimple.sol — the smart contract

Quick commands:
- Compile and test with Hardhat or Remix using Solidity 0.8.20.

Notes:
- This is a minimal educational example. For production use, add access controls, on-chain verification, input validation, and security audits.
