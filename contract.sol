pragma solidity ^0.4.19;


contract blacklister {

    mapping(address => bool) blacklist;

    function secure(address address_request) public returns (string message){
        if(blacklist[address_request] == false){ 
            return 'Cancel transaction';
        }else if(blacklist[address_request] == true){
            return 'Approve transaction';     
        }else{
            return 'Value unknown';
        }
    }

    function set_address_blacklist(address blacklisted) public returns(string message){
        blacklist[blacklisted] = false;
        return 'Saved blacklisted address';
    }

    function set_address_whitelist(address whitelisted_address) public returns(string message){
        blacklist[whitelisted_address] = true;
        return 'Saved whitelist address';
    }
}



