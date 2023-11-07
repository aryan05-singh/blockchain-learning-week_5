// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract VotingSystem{
    address public owner;
    string [] public candidates;
    mapping (address => bool) public Voters;
    mapping (uint256 => uint256) public VotesReceived;

event Voted(address indexed voter, uint256 candidateIndex);

modifier OnlyOwner(){
    require(msg.sender == owner,"Only Owner Can Perform Add Or Remove Function");
    _;
}

constructor(string [] memory _candidates) {
    owner == msg.sender;
    candidates = _candidates;
}

 function addCandidate(string memory candidate) public OnlyOwner{
candidates.push(candidate);
 }

 function removeCndidate(uint index) public OnlyOwner{
    require(index<candidates.length,"candidate not have");
    candidates.pop();

 }

function vote(uint256 candidateIndex) public {
    require (candidateIndex < candidates.length,"Invalid Candidate Index");
require(!Voters[msg.sender],"Already voted");
Voters[msg.sender] = true;
VotesReceived[candidateIndex];
emit Voted(msg.sender , candidateIndex);
}

function hasVoted(address Voter) public view returns (bool){
return Voters[Voter];
}

function getTotalVotes(uint256 candidateIndex) public view returns (uint256) {
        require(candidateIndex < candidates.length, "Invalid candidate index");
        return VotesReceived[candidateIndex];
}
 function getCandidatesCount() public view returns (uint256) {
        return candidates.length;
    }
}
