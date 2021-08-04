pragma solidity ^0.7.0;

import '@openzeppelin/contracts/math/SafeMath.sol';
import './CryptoD10S.sol';

contract ICO {
    using SafeMath for uint;
    struct Sale {
        address investor;
        uint amount;
        bool tokensWithdrawn;
    }
    mapping(address => Sale) public sales;
    address public admin;
    uint public end;
    uint public duration;
    uint public price;
    uint public availableTokens;
    uint public minPurchase;
    uint public maxPurchase;
    CryptoD10S public token;
    
    constructor(
        address tokenAddress,
        uint _duration,
        uint _price,
        uint _minPurchase,
        uint _maxPurchase) {
        token = CryptoD10S(tokenAddress);

        admin = msg.sender;
        availableTokens = token.balanceOf(admin);

        require(_duration > 0, 'duration should be > 0');
        require(_minPurchase > 0, '_minPurchase should > 0');
        require(
          _maxPurchase > 0 && _maxPurchase <= availableTokens,
          '_maxPurchase should be > 0 and <= availableTokens'
        );

        duration = _duration;
        price = _price;
        minPurchase = _minPurchase;
        maxPurchase = _maxPurchase;
    }
    
    function start()
        external
        onlyAdmin() 
        icoNotActive() {
        end = block.timestamp + duration;
    }
    
    function buy(uint usdAmount)
        external
        icoActive() {
        require(
          usdAmount >= minPurchase && usdAmount <= maxPurchase, 
          'have to buy between minPurchase and maxPurchase'
        );
        uint tokenAmount = usdAmount.div(price);
        require(
          tokenAmount <= availableTokens, 
          'Not enough tokens left for sale'
        );

        sales[msg.sender] = Sale(
            msg.sender,
            tokenAmount,
            false
        );
    }
    
    function withdrawTokens()
        external
        icoEnded() {
        Sale storage sale = sales[msg.sender];
        require(sale.amount > 0, 'only investors');
        require(sale.tokensWithdrawn == false, 'tokens were already withdrawn');
        sale.tokensWithdrawn = true;
        token.transferFrom(admin, sale.investor, sale.amount);
    }
    
    modifier icoActive() {
        require(
          end > 0 && block.timestamp < end && availableTokens > 0, 
          'ICO must be active'
        );
        _;
    }
    
    modifier icoNotActive() {
        require(end == 0, 'ICO should not be active');
        _;
    }
    
    modifier icoEnded() {
        require(
          end > 0 && (block.timestamp >= end || availableTokens == 0), 
          'ICO must have ended'
        );
        _;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, 'only admin');
        _;
    }
}
