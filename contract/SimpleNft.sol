// SPDX-License-Identifier: MIT

// Amended by HashLips
/**
    !Disclaimer!
    These contracts have been used to create tutorials,
    and was created for the purpose to teach people
    how to create smart contracts on the blockchain.
    please review this code on your own before using any of
    the following code for production.
    HashLips will not be liable in any way if for the use 
    of the code. That being said, the code has been tested 
    to the best of the developers' knowledge to work as intended.
*/

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is Ownable {
    bool public paused = false;
    address public oldNftAddr;
    address public newNftAddr;

    constructor(address _oldNftAddr, address _newNftAddr) {
        setOldNftAddress(_oldNftAddr);
        setNewNftAddress(_newNftAddr);
    }

    // public
    function swap(uint256 _tokenId) public {
        require(!paused);
        IERC721(oldNftAddr).safeTransferFrom(
            msg.sender,
            address(this),
            _tokenId
        );
        IERC721(newNftAddr).safeTransferFrom(
            address(this),
            msg.sender,
            _tokenId
        );
    }

    function setOldNftAddress(address _oldNftAddr) public onlyOwner {
        oldNftAddr = _oldNftAddr;
    }

    function setNewNftAddress(address _newNftAddr) public onlyOwner {
        newNftAddr = _newNftAddr;
    }

    function pause(bool _state) public onlyOwner {
        paused = _state;
    }

    function withdraw(uint256 _tokenId) public onlyOwner {
        IERC721(newNftAddr).safeTransferFrom(
            address(this),
            msg.sender,
            _tokenId
        );
    }
}
