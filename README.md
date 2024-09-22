# Web3 StakingToken

The Staking Contract is a decentralized application that enables users to securely stake their ERC20 tokens, earning rewards over time while participating in the network's governance. Built using Solidity and leveraging the OpenZeppelin library, the contract incorporates several key features to ensure safety, flexibility, and usability.

Key Features:

Staking Mechanism: Users can deposit their tokens into the contract to earn rewards based on the amount staked and the duration of the stake.

Owner Privileges: The Ownable modifier restricts certain functions to the contract owner, enabling them to adjust parameters like the reward rate and manage the contract’s operational status.

Reward Calculation: The contract includes a transparent reward calculation system, allowing users to track their earned rewards based on a defined reward rate. Rewards are accrued in real time, providing clarity and motivation for stakers.

User-Friendly Interaction: The contract emits events for significant actions, such as staking, unstaking, and claiming rewards, making it easier for users and developers to track activities on the blockchain.

For the development of this project, we used the following patterns:

1. Ownable: Using this pattern allowed us to define functions where only the owners can interact with the contract. The functions where this modifier was defined are: setRewardRate, pause, and unpause.

2. ReentrancyGuard: The nonReentrant modifier is applied to the stake, unstake, and claimReward functions to prevent nested calls to these functions, protecting the contract from reentrancy attacks.

3. Pausable: To safeguard staked funds in the event that a vulnerability is identified.

###Team members:

[Efraín González Bermúdez](https://github.com/efraingb)
[Fabiola Bloise Chacón](https://github.com/fabsbloise)
[Adrián Vega](https://github.com/AdrianAVA9)