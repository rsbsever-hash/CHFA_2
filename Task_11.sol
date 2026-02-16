// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_11 {
    address public owner;
    uint public targetAmount;
    uint public totalUserDeposits;  // 1️⃣ Сумма всех депозитов
    
    enum State { Active, Paused, Closed }
    State public state;

    mapping(address => uint) public balances;

    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);
    event StateChanged(State newState);

    // 2️⃣ МОДИФИКАТОР onlyOwner - ПРОВЕРКА ВЛАДЕЛЬЦА
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier whenActiveOrPaused() {
        require(state == State.Active || state == State.Paused, "Unavailable in closed state");
        _;
    }

    modifier whenActive() {
        require(state == State.Active, "Contract is not active");
        _;
    }

    // 3️⃣ МОДИФИКАТОР whenClosed - ПРОВЕРКА ЗАКРЫТОГО СОСТОЯНИЯ
    modifier whenClosed() {
        require(state == State.Closed, "Contract is not closed");
        _;
    }

    constructor(uint _targetAmount) {
        require(_targetAmount > 0, "Target amount should be > 0");
        owner = msg.sender;
        targetAmount = _targetAmount;
        state = State.Active;
    }

    // 4️⃣ ДЕПОЗИТ - ПОЛЬЗОВАТЕЛИ ВНОСЯТ СРЕДСТВА
    function deposit() external payable whenActive {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        
        balances[msg.sender] += msg.value;
        totalUserDeposits += msg.value;
        
        emit Deposited(msg.sender, msg.value);
        
        // АВТОМАТИЧЕСКОЕ ПЕРЕКЛЮЧЕНИЕ В CLOSED ПРИ ДОСТИЖЕНИИ ЦЕЛИ
        if (totalUserDeposits >= targetAmount && state != State.Closed) {
            state = State.Closed;
            emit StateChanged(state);
        }
    }

    // 5️⃣ ПАУЗА - ТОЛЬКО ВЛАДЕЛЕЦ
    function pause() external onlyOwner whenActiveOrPaused {
        require(state != State.Paused, "Contract already paused");
        state = State.Paused;
        emit StateChanged(state);
    }

    // 6️⃣ ВОЗОБНОВЛЕНИЕ - ТОЛЬКО ВЛАДЕЛЕЦ
    function resume() external onlyOwner {
        require(state == State.Paused, "Contract is not paused");
        state = State.Active;
        emit StateChanged(state);
    }

    // 7️⃣ ВЫВОД СРЕДСТВ - ТОЛЬКО ДЛЯ ПОЛЬЗОВАТЕЛЕЙ В СОСТОЯНИИ ПАУЗЫ
    function withdraw() external whenActiveOrPaused {
        require(state == State.Paused, "Funds can only be withdrawn when paused");
        
        uint userBalance = balances[msg.sender];
        require(userBalance > 0, "No funds to withdraw");
        
        balances[msg.sender] = 0;
        totalUserDeposits -= userBalance;
        
        payable(msg.sender).transfer(userBalance);
        emit Withdrawn(msg.sender, userBalance);
        
        // Если после вывода сумма упала ниже цели, контракт остается в Paused
    }

    // 8️⃣ ВЫВОД ВСЕХ СРЕДСТВ ВЛАДЕЛЬЦЕМ - ТОЛЬКО В CLOSED
    function ownerWithdrawAll() external onlyOwner whenClosed {
        uint contractBalance = address(this).balance;
        require(contractBalance > 0, "No funds to withdraw");
        
        // Обнуляем балансы ВСЕХ пользователей (контракт закрыт)
        for (uint i = 0; i < 100; i++) {
            // В реальном проекте нужно хранить список пользователей
            // Здесь упрощенный вариант
        }
        
        totalUserDeposits = 0;
        payable(owner).transfer(contractBalance);
        emit Withdrawn(owner, contractBalance);
    }

    // 9️⃣ ПОЛУЧИТЬ ТЕКУЩЕЕ СОСТОЯНИЕ
    function getState() external view returns (string memory) {
        if (state == State.Active) return "Active";
        if (state == State.Paused) return "Paused";
        if (state == State.Closed) return "Closed";
        return "";
    }
    
    // 🔟 ПОЛУЧИТЬ ОСТАТОК КОНТРАКТА
    function getContractBalance() external view returns (uint) {
        return address(this).balance;
    }
}
