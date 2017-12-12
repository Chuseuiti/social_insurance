pragma solidity ^0.4.19;

MINIMUM_SCORE_WHITELIST = 11;
PENALTY_WHITELIST = 10;
REWARD BLACKLIST = 1;

contract blacklister {

    struct whitelist{
        bool whitelisted = false;        
        address discoverer;
        bool isValue = false;
    };
    
    struct blacklist{
        bool blacklisted = false;        
        uint number_contributors = 0;
        address discoverer;
        bool isValue = false;
    };

    struct accounts{
        array[] blacklisted; 
        array[] whitelisted;       
        uint score = 0;
        uint ether = 0; // This ether percentage is obtained from the users of the contract not the contributors. This should be an ERC token. 
    };

    mapping(address => whitelist) whitelisted_addresses;
    mapping(address => blacklist) blacklisted_addresses;
    mapping(address => accounts) contributors;

    function secure(address address_request) constant returns (string message){

        if(blacklisted_addresses[address_request].isValue == true){
            address temp_discoverer = blacklisted_addresses[address_request].discoverer;
            // Pay percentage to discoverer
            return 'Cancel transaction';
        }else if(whitelisted_addresses[address_request].isValue == true){
            return 'Approve transaction';     
        }else{
            return 'Address unknown';
        }
    }

    function set_address_blacklist(address blacklisted_address) constant returns(string message){
        addresses[blacklisted_address].blacklisted = true;
        addresses[blacklisted_address].number_contributors += 1; 
        if(addresses[blacklisted_address].isValue == false) {
            addresses[blacklisted_address].isValue = true;
            addresses[blacklisted_address].discoverer = msg.sender;
        }                               
        contributors[msg.sender].score += BLACKLIST;
        contributors[msg.sender].blacklisted = blacklisted_address;         
        return 'Saved blacklisted address';
    }

    function set_address_whitelist(address whitelisted_address) constant returns(string message){
        if(contributors[msg.sender] >= MINIMUM_SCORE_WHITELIST){
            whitelist[whitelisted_address].whitelisted = true;
            if(addresses[whitelisted_address].isValue == false) {
                addresses[whitelisted_address].isValue = true;
                addresses[whitelisted_address].discoverer = msg.sender;
            } 
            contributors[msg.sender].score -= PENALTY_WHITELIST;
            contributors[msg.sender].whitelisted = whitelisted_address;              
        }
        return 'Saved whitelist address';
    }
}



