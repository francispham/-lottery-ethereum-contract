pragma solidity ^0.4.17;

// https://docs.soliditylang.org/en/latest/structure-of-a-contract.html
contract Lottery {
    address public  manager;
    address[] public players; //  https://docs.soliditylang.org/en/latest/types.html#arrays
    
    function Lottery() public {
        manager = msg.sender;
    }
    
    function enter() public payable {
        require(msg.value > .01 ether); //  https://docs.soliditylang.org/en/latest/control-structures.html#panic-via-assert-and-error-via-require
        
        players.push(msg.sender);
    }
    
    function random() private view returns(uint) {
        return uint(keccak256(block.difficulty, now, players));
    }
    
    // https://docs.soliditylang.org/en/latest/contracts.html#getter-functions
    function pickWinner() public restricted {
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0);
    }
    
    // https://docs.soliditylang.org/en/latest/structure-of-a-contract.html#function-modifiers
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
    
    function getPlayers() public view returns (address[]) {
        return players;
    }
}