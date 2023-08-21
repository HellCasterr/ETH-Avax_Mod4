// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SocialPointsSystem {

    address public owner;
    string public contractName = "Social Points System";

    mapping(address => uint256) public socialPoints;
    mapping(address => bool) public hasVipBadge;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function minting(address recipient, uint256 points) public onlyOwner {
        require(recipient != address(0), "Invalid recipient address");
        require(points > 0, "Points to mint must be greater than 0");

        socialPoints[recipient] += points;
    }

    function transfer(address to, uint256 points) public {
        require(to != address(0), "Cannot transfer to the zero address");
        require(points > 0, "Points to transfer must be greater than 0");
        require(socialPoints[msg.sender] >= points, "Insufficient points");

        socialPoints[msg.sender] -= points;
        socialPoints[to] += points;
    }

    function spending_burning(uint256 points) public {
        require(points > 30, "Points to spend must be greater than 0");
        require(socialPoints[msg.sender] >= points, "Insufficient points");

        socialPoints[msg.sender] -= points;
        hasVipBadge[msg.sender] = true; // Unlock VIP Badge feature
    }

    function redeem(uint256 points, uint256 Achievementtier) public {
    require(points > 0, "Points to redeem must be greater than 0");
    require(socialPoints[msg.sender] >= points, "Insufficient points");

    if (Achievementtier == 1) {
        require(points >= 100 , "Insufficient points for Achievement tier 1");
    } else if (Achievementtier == 2) {
        require(points >= 200 , "Insufficient points for Achievement tier 2");
    } else if (Achievementtier == 3) {
        require(points >= 300 , "Insufficient points for Achievement tier 3");
    } else {
        revert("Invalid Reward Level");
    }
        
    socialPoints[msg.sender] -= points;
}

}
