// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


contract Task_02 {
    // Функция для генерации массива квадратов чисел от 1 до n
    function generateSquares(uint256 n) public pure returns (uint256[] memory) {
        uint256[] memory squares = new uint256[](n); // создаем массив для хранения квадратов
        for (uint256 i = 1; i <= n; i++) {
            squares[i - 1] = i * i; // записываем квадрат числа в массив
        }


       
        return squares; // возвращаем массив квадратов
    }
}