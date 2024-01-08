// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Lock{
    struct Access{
        address user;
        bool access;
    }
    mapping (address=>string[]) value;
    mapping (address=>Access[]) accessList;
    mapping (address=>mapping (address=>bool)) ownership;
    mapping (address=>mapping (address=>bool)) previousData;
    function add(address _user, string calldata url) external{
        value[_user].push(url);
    }
    function allow(address user) external {
        ownership[msg.sender][user]=true;
        if(previousData[msg.sender][user]){
            for( uint i=0; i<accessList[msg.sender].length;i++){
                if(accessList[msg.sender][i].user==user){
                     accessList[msg.sender][i].access=true;
                }
            }
        }
        else{
            accessList[msg.sender].push(Access(user,true));
            previousData[msg.sender][user]=true;
        }
    }
    function disallow(address user) public {
        ownership[msg.sender][user]=false;
        for( uint i=0; i<accessList[msg.sender].length;i++){
            if(accessList[msg.sender][i].user==user){
                accessList[msg.sender][i].access=false;
            }
        }
    }
    function display(address _user) external view returns(string[] memory){
        require(_user==msg.sender || ownership[_user][msg.sender],"BHai Tere KO KISINEBHI access nhi dia");
        return value[_user];
    }
    function shareAccess() public view returns(Access[] memory){
        return accessList[msg.sender];
    }
}
