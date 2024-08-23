// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract TodoList{
    uint256 public _idUser;
    address public ownerOfContract;

    address[] public creators;
    string[] public message;
    uint256[] public messageId;

    struct TodoListApp{
        address account;
        uint256 userId;
        string message;
        bool completed;
    }

    event TodoEvent(
        address indexed account,
        uint256 indexed userId,
        string message,
        bool completed
    );

    mapping (address => TodoListApp) public TodoListApps;
    
    constructor(){
        ownerOfContract = msg.sender;
    }

    function inc() internal {
        _idUser++;
    }

    function createList(string calldata _message) external{
        inc();
        uint256 idNumber = _idUser;
        TodoListApp storage toDo = TodoListApps[msg.sender];
        toDo.account = msg.sender;
        toDo.message = _message;
        toDo.completed = false;
        toDo.userId = idNumber;

        creators.push(msg.sender);
        message.push(_message);
        messageId.push(idNumber);

        emit TodoEvent(msg.sender, toDo.userId, _message, toDo.completed);
    }

    function getCreatorData(address _address) public view returns(address, uint256, string memory, bool){
        TodoListApp memory sigleUserData = TodoListApps[_address];
        return(sigleUserData.account, sigleUserData.userId, sigleUserData.message, sigleUserData.completed);
    }

    function getAddress() external view returns (address[] memory){
        return creators;
    }

    function getMessage() external view returns (string[] memory){
        return message;
    }

    function toggle(address _creator) public {
        TodoListApp storage singleUserData = TodoListApps[_creator];
        singleUserData.completed = !singleUserData.completed;
    }

}