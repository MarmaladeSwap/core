pragma solidity >=0.5.0;

/*
 * MarmaladeSwapFinance 
 * App:             https://marmaladeswap.finance/ 
 * Twitter:         https://twitter.com/MarmaladeSwap
 * Facebook:    	https://www.facebook.com/groups/MarmaladeSwap
 * Telegram:        https://t.me/MarmaladeSwap
 * Telegram chat:   https://t.me/MarmaladeSwapFinance
 * GitHub:          https://github.com/MarmaladeSwap
 */

interface IMrmFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}
