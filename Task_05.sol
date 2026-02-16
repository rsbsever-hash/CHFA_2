pragma solidity ^0.8.0;

contract Task_05 {
   // SPDX-License-Identifier: GPL-3.0
    //  ДИНАМИЧЕСКИЙ МАССИВ для хранения нескольких температур в Цельсия
    uint256[] public celsiusTemperatures; // storage

    //  Функция для добавления температуры в градусах Цельсия
    function setCelsiusTemperature(uint256 temperature) public {
        celsiusTemperatures.push(temperature); // добавляем в массив
    }

    //  Функция для конвертации градусов Цельсия в Фаренгейт
    function convertToFahrenheit(uint256 temperature) public pure returns (uint256) {
        // Формула: (°C × 9/5) + 32 = °F
        uint256 fahrenheitTemperature = (temperature * 9 / 5) + 32;
        return fahrenheitTemperature;
    }

    //  Функция для получения КОНКРЕТНОЙ температуры в Фаренгейтах по индексу
    function getFahrenheitTemperature(uint256 index) public view returns (uint256) {
        require(index < celsiusTemperatures.length, "Index out of bounds");
        return convertToFahrenheit(celsiusTemperatures[index]);
    }

    //  Функция для получения ВСЕХ температур в Фаренгейтах (НОВЫЙ МАССИВ)
    function getAllFahrenheitTemperatures() public view returns (uint256[] memory) {
        uint256 length = celsiusTemperatures.length;
        uint256[] memory fahrenheitArray = new uint256[](length);
        
        for (uint256 i = 0; i < length; i++) {
            fahrenheitArray[i] = convertToFahrenheit(celsiusTemperatures[i]);
        }
        
        return fahrenheitArray;
    }
    
    //  Вспомогательная функция: получить количество записей
    function getTemperaturesCount() public view returns (uint256) {
        return celsiusTemperatures.length;
    }
    
    // 🧹 Вспомогательная функция: очистить все записи
    function clearAllTemperatures() public {
        delete celsiusTemperatures;
    }
}
