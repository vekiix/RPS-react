// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

enum options {
    EMPTY,
    ROCK,
    PAPER,
    SCISSORS
    }

enum result {
    PLAYER1,
    PLAYER2,
    DRAW
}

contract RPS{
    //INITIALIZATION 
    uint256 public enterPrice;

    options private player1Pick = options.EMPTY;
    options private player2Pick = options.EMPTY;

    result private gameResult = result.DRAW;

    address public owner;
    address private player1Address;
    address private player2Address;
    address public lastGameWinner;

    mapping (options => options) private firstWins;

    constructor(uint256 _enterPrice) {
        enterPrice = _enterPrice;
        owner = msg.sender;

        firstWins[options.ROCK] = options.SCISSORS;
        firstWins[options.PAPER] = options.ROCK;
        firstWins[options.SCISSORS] = options.PAPER;
    }



    //PUBLIC FUNCTIONS FOR USE
    function changeEnterPrice(uint256 _enterPrice) public onlyOwner{
        enterPrice = _enterPrice;
    }

    function enterGame(uint256 input) public payable uniqueEnter validPrice {
        if(player1Pick == options.EMPTY) {
            player1Pick = inputToPick(input);
            player1Address = msg.sender;
        }
        else if(player2Pick == options.EMPTY) {
            player2Pick = inputToPick(input);
            player2Address = msg.sender; 
            pickWinner();
        }
    }




    //ROUND HANDLING FUNCTIONS
    function pickWinner() private bothEnter {
        if(firstWins[player1Pick] == player2Pick) gameResult = result.PLAYER1;
        else if(firstWins[player2Pick] == player1Pick) gameResult = result.PLAYER2;
        else gameResult = result.DRAW;
        sendMoney();
    }

    function sendMoney() private bothEnter {
        uint price = enterPrice;
        if(gameResult == result.PLAYER1){
            payable(player1Address).transfer(price * 2);
            lastGameWinner = player1Address;
        }
        else if(gameResult == result.PLAYER2) {
            payable(player2Address).transfer(price * 2);
            lastGameWinner = player2Address;
        }
        else if(gameResult == result.DRAW)
        {
            payable(player1Address).transfer(price);
            payable(player2Address).transfer(price);
        }
        initValues();
    }




    //HELPER FUNCTIONS
    function inputToPick(uint256 input) private pure returns (options) {
        if(input == 0) return options.ROCK; 
        else if(input == 1) return options.PAPER;
        else return options.SCISSORS;
    }

    function initValues() private {
        player1Address = address(0);
        player2Address = address(0);

        player1Pick = options.EMPTY;
        player2Pick = options.EMPTY;

        gameResult = result.DRAW;
    }


    //MODIFIERS
    modifier validPrice(){
        require(msg.value == enterPrice, 'The sent value has to be exact to the entry price');
        _;
    }
    modifier bothEnter () {
        require(player1Pick != options.EMPTY && player2Pick != options.EMPTY, 'One or more picks are empty');
        require(player1Address != address(0) && player2Address != address(0), 'One or more addresses are empty');
        _;
    }
    modifier uniqueEnter () {
        require(player1Address != msg.sender && player2Address != msg.sender, 'Player already in a game round');
        _;
    }
    modifier onlyOwner () {
        require(msg.sender == owner, 'Only owner privilages');
        _;
    }
}
