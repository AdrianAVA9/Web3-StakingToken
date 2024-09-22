# Web3 StakingToken

For the development of this project, we used the following patterns:

1. Ownable: Using this pattern allowed us to define functions where only the owners can interact with the contract. The functions where this modifier was defined are: setRewardRate, pause, and unpause.

2. ReentrancyGuard: The nonReentrant modifier is applied to the stake, unstake, and claimReward functions to prevent nested calls to these functions, protecting the contract from reentrancy attacks.

3. Pausable: To safeguard staked funds in the event that a vulnerability is identified.