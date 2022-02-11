// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

enum options {
    EMPTY,
    ROCK,
    PAPER,
    SCISSORS
    }

contract RPS{
    //INITIALIZATION 
    uint256 public enterPrice;

    address public player1Address;
    address public player2Address;
    
    options private player1Pick = options.EMPTY;
    options private player2Pick = options.EMPTY;


    address public owner;



    mapping (options => options) private firstWins;

    constructor(uint256 _enterPrice) {
        enterPrice = _enterPrice ;
        owner = msg.sender;

        firstWins[options.ROCK] = options.SCISSORS;
        firstWins[options.PAPER] = options.ROCK;
        firstWins[options.SCISSORS] = options.PAPER;
    }



    //PUBLIC FUNCTIONS FOR USE
    function changeEnterPrice(uint256 _enterPrice) public onlyOwner{
        enterPrice = _enterPrice * 1000000000000000000;
    }

    function enterGame(uint256 input) public payable uniqueEnter validPrice notFull{
        if(player1Pick == options.EMPTY) {
            player1Pick = inputToPick(input);
            player1Address = msg.sender;
        }
        else if(player2Pick == options.EMPTY) {
            player2Pick = inputToPick(input);
            player2Address = msg.sender; 
        }
    }

    function pickWinner() public bothEnter initAfter returns(address){
        if(firstWins[player1Pick] == player2Pick) return handlePlayer1Win();
        else if(firstWins[player2Pick] == player1Pick) return handlePlayer2Win();
        else return handleDraw();
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
    }

    function handlePlayer1Win () private returns(address) {
        payable(player1Address).transfer(enterPrice * 2 - enterPrice / 100);
        return player1Address;
    }

    function handlePlayer2Win () private returns (address) {
        payable(player2Address).transfer(enterPrice * 2 - enterPrice / 100);
        return player2Address;
    }

    function handleDraw()private returns (address)  {
        payable(player1Address).transfer(enterPrice);
        payable(player2Address).transfer(enterPrice);
        return address(0);
    }


    //MODIFIERS
    modifier initAfter() {
        _;
        initValues();
    }
    modifier empty() {
        require(player2Address == address(0) && player2Address == address(0), 'Round  not empty');
        _;
    }
    modifier notFull() {
        require(player1Address == address(0) || player2Address == address(0),'Round  full');
        _;
    }
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
