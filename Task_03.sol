// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


contract Task_03 {
    function generateFactorial(uint256 n) public pure returns (uint256) {
        require(n <= 20, "n too large - risk of overflow"); // защита от переполнения
        
        uint256 result = 1;  // начинаем с 1 (0! = 1, 1! = 1)
        uint256 i = 1;       // счетчик для цикла
        
        // ЦИКЛ WHILE: пока i <= n
        while (i <= n) {
            result *= i;     // result = result * i
            i++;             // увеличиваем счетчик
        }
        
        return result;       // возвращаем факториал
    }
}