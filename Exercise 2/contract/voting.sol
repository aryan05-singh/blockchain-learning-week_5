// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    address public owner;
    string[] public candidates;
    mapping(address => bool) public voters;
    mapping(uint256 => uint256) public votesReceived;

    event Voted(address indexed voter, uint256 candidateIndex);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can perform this action");
        _;
    }

    constructor(string[] memory _candidates) {
        owner = msg.sender;
        candidates = _candidates;
    }

    function vote(uint256 candidateIndex) external {
        require(candidateIndex < candidates.length, "Invalid candidate index");
        require(!voters[msg.sender], "Already voted");
        voters[msg.sender] = true;
        votesReceived[candidateIndex] += 1;
        emit Voted(msg.sender, candidateIndex);
    }

    function getTotalVotes(uint256 candidateIndex) external view returns (uint256) {
        require(candidateIndex < candidates.length, "Invalid candidate index");
        return votesReceived[candidateIndex];
    }

    function hasVoted(address voter) external view returns (bool) {
        return voters[voter];
    }

    function addCandidate(string memory candidate) external onlyOwner {
        candidates.push(candidate);
    }

    function removeCandidate(uint256 index) external onlyOwner {
        require(index < candidates.length, "Invalid candidate index");
        delete candidates[index];
    }
}
