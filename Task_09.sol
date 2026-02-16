// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


contract Task_09 {
    mapping(uint256 => string) public users;
    uint256 public userCount;

    // 📢 ПРОСТЫЕ СОБЫТИЯ
    event UserAdded(uint256 indexed userId, string message);
    event UserRemoved(uint256 indexed userId, string message);

    // ➕ ДОБАВИТЬ ПОЛЬЗОВАТЕЛЯ
    function addUser(string memory name) external {
        userCount++;
        users[userCount] = name;
        emit UserAdded(userCount, "User added");
    }

    // ➖ УДАЛИТЬ ПОЛЬЗОВАТЕЛЯ
    function removeUser(uint256 userId) external {
        require(bytes(users[userId]).length != 0, "User does not exist");
        delete users[userId];
        emit UserRemoved(userId, "User removed");
    }
}
