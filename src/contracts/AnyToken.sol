// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.4.26 <0.9.0;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/ownership/Ownable.sol';

contract AnyToken is ERC721, Ownable {
    uint256 public mintPrice = 1;
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnabled;
    mapping(address => uint256) public mintedWallets;

    constructor() payable ERC721 ('AnyToken', 'AT') {
        maxSupply = 2;
    }

    function toggleIsMintEnabled() external onlyOwner {
        isMintEnabled = !isMintEnabled;
    }

    function setMaxSupply(uint256 _maxSupply) external onlyOwner {
        maxSupply = _maxSupply;
    }

    function mint() external payable {
        require(isMintEnabled, "Minting is disabled");
        require(mintedWallets[msg.sender] += mintPrice, "Not enough tokens");
        require(msg.value >= mintPrice, "Not enough ETH");
        require(maxSupply > totalSupply, "Sold Out Baby!");

        mintedWallets[msg.sender] ++;
        totalSupply ++;
        uint256 tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);
        }
    }