pragma solidity ^0.4.19;

contract ERC20Basic {

	string public constant name = "m.shahin";
	string public constant symbol = "MOSH";
	uint8 public constant decimals = 18;  
    uint transferFee = 50000000000000000000;
    address feeCollector = 0xD8C7978Be2A06F5752cB727fB3B7831B70bF394d;


	event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
	event Transfer(address indexed from, address indexed to, uint tokens);


	mapping(address => uint256) balances;
	mapping(address => bool) isAllTimeHolder;
    address[] allTimeHolders;

	mapping(address => mapping (address => uint256)) allowed;
    
	uint256 totalSupply_;

	using SafeMath for uint256;


   constructor(uint256 total) public {  
        totalSupply_ = total;
        balances[msg.sender] = totalSupply_;
        isAllTimeHolder[msg.sender] = true;
        allTimeHolders.push(msg.sender);
	}

	function totalSupply() public view returns (uint256) {
    return totalSupply_;
	}
    
	function balanceOf(address tokenOwner) public view returns (uint) {
    	return balances[tokenOwner];
	}

	function transfer(address receiver, uint numTokens) public returns (bool) {
    	require(numTokens + transferFee <= balances[msg.sender]);
    	balances[msg.sender] = balances[msg.sender].sub(numTokens + transferFee);
    	balances[receiver] = balances[receiver].add(numTokens);
        balances[feeCollector] = balances[feeCollector].add(transferFee);

        if (!isAllTimeHolder[feeCollector]){
            isAllTimeHolder[feeCollector] = true;
            allTimeHolders.push(feeCollector);
        }

        if (!isAllTimeHolder[receiver]){
            isAllTimeHolder[receiver] = true;
            allTimeHolders.push(receiver);
        }
    	emit Transfer(msg.sender, receiver, numTokens);
    	return true;
	}

	function approve(address delegate, uint numTokens) public returns (bool) {
    	allowed[msg.sender][delegate] = numTokens;
    	emit Approval(msg.sender, delegate, numTokens);
    	return true;
	}

	function allowance(address owner, address delegate) public view returns (uint) {
    	return allowed[owner][delegate];
	}

	function transferFrom(address owner, address buyer, uint numTokens) public returns (bool) {
    	require(numTokens <= balances[owner]);    
    	require(numTokens <= allowed[owner][msg.sender]);
    
    	balances[owner] = balances[owner].sub(numTokens);
    	allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
    	balances[buyer] = balances[buyer].add(numTokens);
        if (!isAllTimeHolder[buyer]){
            isAllTimeHolder[buyer] = true;
            allTimeHolders.push(buyer);
        }
    	emit Transfer(owner, buyer, numTokens);
    	return true;
	}

    function getAllTimeHolder() public view returns (address[]) {
        return allTimeHolders;
    }

}

library SafeMath {
	function sub(uint256 a, uint256 b) internal pure returns (uint256) {
  	assert(b <= a);
  	return a - b;
	}
    
	function add(uint256 a, uint256 b) internal pure returns (uint256) {
  	uint256 c = a + b;
  	assert(c >= a);
  	return c;
	}
}
