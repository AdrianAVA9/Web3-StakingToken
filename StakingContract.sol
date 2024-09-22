// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract StakingContract is Ownable, Pausable, ReentrancyGuard {
    IERC20 public stakingToken;

    struct Stake {
        uint256 amount;
        uint256 timestamp;
    }

    mapping(address => Stake) public stakes;
    uint public rewardRate;// Recompensa por segundo
    uint public totalStaked;

    //Events
    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);
    event RewardClaimed(address indexed user, uint256 reward);

    constructor(IERC20 _stakingToken, uint256 _rewardRate) Ownable (msg.sender) {
        stakingToken = _stakingToken;
        rewardRate = _rewardRate;
    }

    function stake(uint256 _amount) external nonReentrant {
        require(_amount > 0, "Amount must be greater than 0");
        
        // Transfer tokens del usuario al contrato
        stakingToken.transferFrom(msg.sender, address(this), _amount);
        
        // Actualiza el estado del staking
        stakes[msg.sender].amount += _amount;
        stakes[msg.sender].timestamp = block.timestamp;
        totalStaked += _amount;

        emit Staked(msg.sender, _amount);
    }

    function unstake(uint256 _amount) external whenNotPaused nonReentrant {
        require(stakes[msg.sender].amount >= _amount, "Insufficient staked amount");
        
        // Actualiza el total staked
        stakes[msg.sender].amount -= _amount;
        totalStaked -= _amount;

        // Transfiere los tokens de vuelta al usuario
        stakingToken.transfer(msg.sender, _amount);

        emit Unstaked(msg.sender, _amount);
    }

    function calculateReward(address _user) public view returns (uint256) {
        Stake memory userStake = stakes[_user];
        uint256 duration = stakedDuration(_user);
        return userStake.amount * rewardRate * duration;
    }

    function stakedDuration(address _user) public view returns (uint256) {
        Stake memory userStake = stakes[_user];
        return currentTimestamp() - userStake.timestamp;
    }

    function currentTimestamp() public view returns (uint256) {
        return block.timestamp;
    }

    function claimReward() external whenNotPaused nonReentrant {
        uint256 reward = calculateReward(msg.sender);
        require(reward > 0, "No rewards available");

        // Transferir la recompensa en tokens
        stakingToken.transfer(msg.sender, reward);

        // Actualiza el timestamp después de reclamar recompensas
        stakes[msg.sender].timestamp = block.timestamp;

        emit RewardClaimed(msg.sender, reward);
    }

    function setRewardRate(uint256 _newRate) external onlyOwner {
        rewardRate = _newRate;
    }

    function pause() external onlyOwner {
        _pause(); // Pauses the contract
    }

    function unpause() external onlyOwner {
        _unpause(); // Unpauses the contract
    }
}