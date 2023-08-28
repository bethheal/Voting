// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

contract Voting {
    // Define an Appropriate Data Type to Store Candidates
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Define an Appropriate Data Type to Track If Voter has Already Voted
    mapping(address => bool) public hasVoted;

    // Store Candidates Count and Candidates Data
    uint public candidatesCount;
    mapping(uint => Candidate) public candidates;

    // Adds New Candidate
    function addCandidate(string memory _name) public {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // Removes Already Added Candidate
    function removeCandidate(uint _candidateId) public {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");
        delete candidates[_candidateId];
    }

    // Retrieves All Candidates for Viewing
    function getAllCandidates() public view returns (Candidate[] memory) {
        Candidate[] memory allCandidates = new Candidate[](candidatesCount);
        for (uint i = 1; i <= candidatesCount; i++) {
            allCandidates[i - 1] = candidates[i];
        }
        return allCandidates;
    }

    // Allows Voter to Cast a Vote for a Single Candidate
    function castVote(uint _candidateId) public {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");
        require(!hasVoted[msg.sender], "You have already voted");

        candidates[_candidateId].voteCount++;
        hasVoted[msg.sender] = true;
    }
}
