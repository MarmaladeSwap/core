pragma solidity =0.5.16;

/*
 * MarmaladeSwapFinance 
 * App:             https://marmaladeswap.finance/ 
 * Twitter:         https://twitter.com/MarmaladeSwap
 * Facebook:    	https://www.facebook.com/groups/MarmaladeSwap
 * Telegram:        https://t.me/MarmaladeSwap
 * Telegram chat:   https://t.me/MarmaladeSwapFinance
 * GitHub:          https://github.com/MarmaladeSwap
 */

import './interfaces/IMrmFactory.sol';
import './MrmPair.sol';

contract MrmFactory is IMrmFactory {
    bytes32 public constant INIT_CODE_PAIR_HASH = keccak256(abi.encodePacked(type(MrmPair).creationCode));

    address public feeTo;
    address public feeToSetter;

    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    constructor(address _feeToSetter) public {
        feeToSetter = _feeToSetter;
    }

    function allPairsLength() external view returns (uint) {
        return allPairs.length;
    }

    function createPair(address tokenA, address tokenB) external returns (address pair) {
        require(tokenA != tokenB, 'MarmaladeSwap: IDENTICAL_ADDRESSES');
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'MarmaladeSwap: ZERO_ADDRESS');
        require(getPair[token0][token1] == address(0), 'MarmaladeSwap: PAIR_EXISTS'); // single check is sufficient
        bytes memory bytecode = type(MrmPair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        IMrmPair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external {
        require(msg.sender == feeToSetter, 'MarmaladeSwap: FORBIDDEN');
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external {
        require(msg.sender == feeToSetter, 'MarmaladeSwap: FORBIDDEN');
        feeToSetter = _feeToSetter;
    }
}
