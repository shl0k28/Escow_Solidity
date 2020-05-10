pragma solidity ^0.5.0;


contract Escrow {

    address agent;
    mapping(address => uint256) public deposits;

    //only the escrow agent can call the functions
    modifier isAgent(){
        require(msg.sender == agent);
        _;
    }    
    constructor() public {
        agent = msg.sender; //sender is the address that deployed the smart contract
    }
    
    //deposit the funds into the escrow account
    function deposit(address payee) public isAgent payable {
        uint256 amountDeposited = msg.value;
        deposits[payee] = deposits[payee] + amountDeposited;
    }
    
    //withdraw the funds ---> remove the funds from the deposits[payee] 
    //and transfer to the wallet
    
    function withdraw(address payable payee) public isAgent {
        uint256 payment = deposits[payee];
        deposits[payee] = 0;
        payee.transfer(payment);
    }
}