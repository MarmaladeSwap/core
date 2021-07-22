pragma solidity >=0.5.0;

/*
 * MarmaladeSwapFinance 
 * App:             https://marmaladeswap.finance/ 
 * Twitter:         https://twitter.com/MarmaladeSwap
 * Facebook:  		https://www.facebook.com/groups/MarmaladeSwap
 * Telegram:        https://t.me/MarmaladeSwap
 * Telegram chat:   https://t.me/MarmaladeSwapFinance
 * GitHub:          https://github.com/MarmaladeSwap
 */

interface IMrmCallee {
    function mrmCall(address sender, uint amount0, uint amount1, bytes calldata data) external;
}
