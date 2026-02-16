// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Task_06 {

    // Маппинг для хранения 7 цветов радуги
    mapping(uint => string) private colors;
    address public owner;

    // Модификатор доступа только для владельца
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // Конструктор - инициализируем 7 цветов радуги при создании контракта
    constructor() {
        owner = msg.sender;
        colors[0] = "Red";
        colors[1] = "Orange";
        colors[2] = "Yellow";
        colors[3] = "Green";
        colors[4] = "Blue";
        colors[5] = "Indigo";
        colors[6] = "Violet";
    }

    // 1️⃣ ФУНКЦИЯ addColor - добавляет/изменяет цвет по индексу (ТОЛЬКО ДЛЯ ВЛАДЕЛЬЦА)
    function addColor(uint index, string memory color) public onlyOwner {
        require(index >= 0 && index <= 6, "Index must be between 0 and 6");
        colors[index] = color;
    }

    // 2️⃣ ФУНКЦИЯ getColor - возвращает цвет по индексу
    function getColor(uint index) public view returns (string memory) {
        require(index >= 0 && index <= 6, "Index must be between 0 and 6");
        return colors[index];
    }

    // 3️⃣ ФУНКЦИЯ getAllColors - возвращает массив ВСЕХ 7 цветов радуги
    function getAllColors() public view returns (string[] memory) {
        string[] memory allColors = new string[](7);
        for (uint i = 0; i < 7; i++) {
            allColors[i] = colors[i];
        }
        return allColors;
    }

    // 4️⃣ ФУНКЦИЯ colorExists - проверяет, существует ли цвет по индексу
    function colorExists(uint index) public view returns (bool) {
        if (index > 6) return false;
        return bytes(colors[index]).length > 0;
    }

    // 5️⃣ ФУНКЦИЯ removeColor - удаляет цвет по индексу (ТОЛЬКО ДЛЯ ВЛАДЕЛЬЦА)
    function removeColor(uint index) public onlyOwner {
        require(index >= 0 && index <= 6, "Index must be between 0 and 6");
        delete colors[index];
    }
    
    // Вспомогательная функция: получить владельца контракта
    function getOwner() public view returns (address) {
        return owner;
    }
}

