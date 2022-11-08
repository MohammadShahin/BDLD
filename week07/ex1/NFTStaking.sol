// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.7.3/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";


error Staking__UnallowedCollection();
error Staking__UnstakedCollection();
error Withdraw__UnstakedNft();
error Withdraw__SenderIsNotStaker();
error ClaimReward__TransferFailed();

contract Staking is ReentrancyGuard, ERC721Holder {
    IERC20 public s_rewardToken;

    uint256 public constant REWARD_RATE_NFT = 100;
    uint256 public constant REWARD_RATE_COLLECTION = 10000;

    /** @dev Mapping from address to the rewards claimable for user */
    mapping(address => uint256) public s_rewardsNft;

    /** @dev Mapping from address to the rewards claimable for user */
    mapping(address => uint256) public s_rewardsCollection;

    /** @dev Mappings from nft (collection and tokenId) to the owner and the timestamp of staking */
    mapping(address => mapping(uint256 => address)) public s_NftStaker;
    mapping(address => mapping(uint256 => uint256)) public s_NftStakedAt;

    /** @dev Mappings from nft collection (address) to the owner and the timestamp of staking */
    mapping(address => address) public s_CollectionStaker;
    mapping(address => uint256) public s_CollectionStakedAt;

    /** @dev Mappings from address (owners) to the number of nfts and collections staked by them. */
    mapping(address => uint256) public s_numberOfNfts;
    mapping(address => uint256) public s_numberOfCollections;

    /** @dev Mappings from address (owners) to last updated rewards. */
    mapping(address => uint256) s_lastUpdateTime;

    /** @dev Mapping from ECR721 address to whether it can be used in staking */
    mapping(address => bool) public isCollectionAllowed;

    modifier updateReward(address account) {
        // how much reward per token?
        // get last timestamp
        // between 12 - 1pm , user earned X tokens. Needs to verify time staked to distribute correct amount to each
        // participant
        uint256 lastUpdateTime = s_lastUpdateTime[account];

        uint256 stakedNfts = s_numberOfNfts[account]; // # of staked single nfts
        uint256 stakedCollections = s_numberOfCollections[account]; // # of staked collections.

        uint256 previousNftReward = s_rewardsNft[account];
        uint256 previousCollectionReward = s_rewardsCollection[account];

        s_rewardsNft[account] =
            previousNftReward +
            (((block.timestamp - lastUpdateTime) *
                stakedNfts *
                REWARD_RATE_NFT *
                1e18) / 60);

        s_rewardsCollection[account] =
            previousCollectionReward +
            (((block.timestamp - lastUpdateTime) *
                stakedCollections *
                REWARD_RATE_COLLECTION *
                1e18) / 60);

        s_lastUpdateTime[account] = block.timestamp;
        _;
    }

    modifier allowedCollection(address _collectionAddress) {
        if (!isCollectionAllowed[_collectionAddress]) {
            revert Staking__UnallowedCollection();
        }
        _;
    }

    modifier isCollectionStaked(address _collectionAddress) {
        Ownable stakingToken = Ownable(_collectionAddress);
        if (stakingToken.owner() != address(this)) {
            revert Staking__UnstakedCollection();
        }
        _;
    }

    constructor(address[] memory nftWhiteList, address rewardToken) {
        s_rewardToken = IERC20(rewardToken);
        for (uint256 i = 0; i < nftWhiteList.length; i++) {
            isCollectionAllowed[nftWhiteList[i]] = true;
        }
    }

    function stakeNft(address _collectionAddress, uint256 _tokenId)
        external
        allowedCollection(_collectionAddress)
        updateReward(msg.sender)
    {
        IERC721 stakingToken = IERC721(_collectionAddress);
        stakingToken.safeTransferFrom(msg.sender, address(this), _tokenId);

        s_NftStaker[_collectionAddress][_tokenId] = msg.sender;
        s_NftStakedAt[_collectionAddress][_tokenId] = block.timestamp;
        s_numberOfNfts[msg.sender]++;
    }

    function withdrawNft(address _collectionAddress, uint256 _tokenId)
        external
        allowedCollection(_collectionAddress)
        updateReward(msg.sender)
    {
        if (s_NftStaker[_collectionAddress][_tokenId] == address(0)) {
            revert Withdraw__UnstakedNft();
        }
        if (s_NftStaker[_collectionAddress][_tokenId] != msg.sender) {
            revert Withdraw__SenderIsNotStaker();
        }
        IERC721 stakingToken = IERC721(_collectionAddress);
        stakingToken.safeTransferFrom(address(this), msg.sender, _tokenId);

        delete s_NftStaker[_collectionAddress][_tokenId];
        delete s_NftStakedAt[_collectionAddress][_tokenId];
        s_numberOfNfts[msg.sender]--;
    }

    function stakeCollection(address _collectionAddress)
        external
        allowedCollection(_collectionAddress)
        isCollectionStaked(_collectionAddress)
        updateReward(msg.sender)
    {
        s_CollectionStaker[_collectionAddress] = msg.sender;
        s_CollectionStakedAt[_collectionAddress] = block.timestamp;
        s_numberOfCollections[msg.sender]++;
    }

    function withdrawCollection(address _collectionAddress)
        external
        allowedCollection(_collectionAddress)
        isCollectionStaked(_collectionAddress)
        updateReward(msg.sender)
    {
        Ownable stakingToken = Ownable(_collectionAddress);
        stakingToken.transferOwnership(msg.sender);

        delete s_CollectionStaker[_collectionAddress];
        delete s_CollectionStakedAt[_collectionAddress];
        s_numberOfCollections[msg.sender]--;
    }

    function claimReward() external updateReward(msg.sender) {
        uint256 reward = s_rewardsNft[msg.sender] +
            s_rewardsCollection[msg.sender];
        bool success = s_rewardToken.transfer(msg.sender, reward);
        if (!success) {
            revert ClaimReward__TransferFailed();
        }
        s_rewardsNft[msg.sender] = 0;
        s_rewardsCollection[msg.sender] = 0;
    }

    // Getter for UI
    function getReward(address account)
        public
        view
        updateReward(account)
        returns (uint256)
    {
        return s_rewardsNft[account] + s_rewardsCollection[account];
    }
}
