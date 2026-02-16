// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_07 {
    mapping(uint => string) public athletes;
    address public owner;
    uint public constant MAX_ATHLETES = 100;  // Разумное ограничение

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
        addAthlete(0, "John Doe");
        addAthlete(1, "Jane Smith");
        addAthlete(2, "Mike Johnson");
    }

    // 1️⃣ ДОБАВЛЕНИЕ спортсмена - ТОЛЬКО ВЛАДЕЛЕЦ
    function addAthlete(uint index, string memory athlete) public onlyOwner {
        athletes[index] = athlete;
    }

    // 2️⃣ ПОЛУЧЕНИЕ спортсмена по индексу
    function getAthlete(uint index) public view returns (string memory) {
        require(athleteExists(index), "Athlete does not exist");
        return athletes[index];
    }

    // 3️⃣ ПОЛУЧЕНИЕ ВСЕХ спортсменов (динамически)
    function getAllAthletes() public view returns (string[] memory) {
        // Подсчитываем количество существующих спортсменов
        uint count = 0;
        for (uint i = 0; i < MAX_ATHLETES; i++) {
            if (bytes(athletes[i]).length > 0) {
                count++;
            }
        }
        
        // Создаем массив точного размера
        string[] memory allAthletes = new string[](count);
        uint index = 0;
        
        // Заполняем массив
        for (uint i = 0; i < MAX_ATHLETES; i++) {
            if (bytes(athletes[i]).length > 0) {
                allAthletes[index] = athletes[i];
                index++;
            }
        }
        
        return allAthletes;
    }

    // 4️⃣ ОБНОВЛЕНИЕ спортсмена - ТОЛЬКО ВЛАДЕЛЕЦ
    function updateAthlete(uint index, string memory newAthlete) public onlyOwner {
        require(athleteExists(index), "Athlete does not exist");
        athletes[index] = newAthlete;
    }

    // 5️⃣ ПРОВЕРКА существования спортсмена
    function athleteExists(uint index) public view returns (bool) {
        return bytes(athletes[index]).length > 0;
    }

    // 6️⃣ УДАЛЕНИЕ спортсмена - ТОЛЬКО ВЛАДЕЛЕЦ
    function removeAthlete(uint index) public onlyOwner {
        require(athleteExists(index), "Athlete does not exist");
        delete athletes[index];
    }

    // 7️⃣ ЗАМЕНА ВСЕХ спортсменов - ТОЛЬКО ВЛАДЕЛЕЦ
    function replaceAllAthletes(string[] memory newAthletes) public onlyOwner {
        // Опционально: проверяем, что массив не пустой
        require(newAthletes.length > 0, "Must provide at least one athlete");
        
        // Очищаем всех существующих спортсменов
        for (uint i = 0; i < MAX_ATHLETES; i++) {
            if (bytes(athletes[i]).length > 0) {
                delete athletes[i];
            }
        }
        
        // Добавляем новых
        for (uint i = 0; i < newAthletes.length; i++) {
            athletes[i] = newAthletes[i];
        }
    }
}