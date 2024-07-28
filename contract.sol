// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Insurance{
    address[] public policyholders;
    mapping(address=>uint256) public policies;
    mapping(address=>uint256) public claims;
    address payable owner;
    uint256 public totalPremium;
 
    function purchasePolicy(uint256 premium) public payable{
        require(msg.value == premium,"incorrect premium amount");
        require(premium>0,"premium amount must be greater than 0");
        policyholders.push(msg.sender);
        policies[msg.sender]=premium;
        totalPremium+=premium;

    }
    function fileClaim(uint256 amount) public {
        require(policies[msg.sender]>0,"must have a valid policy to fiel a claim");
        require(amount>0,"claim amount is greater than 0");
        require(amount<=policies[msg.sender],"claim amount can't exceed policy ");
        claims[msg.sender]+=amount;

    }
    function approveClaim(address policyholder) public{
        require(msg.sender == owner,"only the owner can approve claims");
        require(claims[policyholder] >0,"policyholder has no outstanding claims" );
        claims[policyholder]=0;


    }
    function getPolicy(address policyholder) public view returns (uint256){
        return claims[policyholder];

    }
    function getClass(address policyholder) public view returns(uint256){
        return claims[policyholder];

    }
    function getTotalPremium() public view returns (uint256){
        return totalPremium;

    }
    function grantAccess(address payable user) public{
        require(msg.sender==owner,"only the ownner can grant the access");
        owner = user;
    }
    function revokeAccess(address payable user) public{
        require(msg.sender == owner,"only the owner can revoke access");
        require(user != owner,"cannot revoke access for the current owner");
        owner=payable(msg.sender);
    }
    
}
