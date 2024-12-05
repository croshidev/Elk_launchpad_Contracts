// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IRouter {
    // Common
    function factory() external pure returns (address);
    function WAVAX() external pure returns (address);
    function WETH() external pure returns (address);

    // Liquidity Management
    function addLiquidity(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountAVAXMin,
        address to,
        uint deadline
    ) external payable returns (uint amountA, uint amountB, uint liquidity);

    function addLiquidityAVAX(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountAVAXMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountAVAX, uint liquidity);

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityAVAX(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountAVAXMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountAVAX);

    function removeLiquidityAVAXWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountAVAXMin,
        address to,
        uint deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint amountToken, uint amountAVAX);

    // Swaps
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapExactAVAXForTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts);

    function swapExactTokensForAVAX(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    // Supporting Fee-on-Transfer Tokens
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;

    function swapExactAVAXForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;

    function swapExactTokensForAVAXSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;

    // Utilities
    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

contract SwwapFunctions {

    function addLiquidity(
        address router,
        address token,
        uint256 liquidityTokens,
        uint256 nativeCoinForLiquidity,
        address deadAddress,
        uint256 routerType
    ) internal {
        if (routerType==0)
        {
        IRouter(router).addLiquidity{value: nativeCoinForLiquidity}(
            token,
            liquidityTokens,
            0, 
            0, 
            deadAddress,
            block.timestamp + 3600
        );
        if (routerType==1){
        IRouter(router).addLiquidityAVAX{value: nativeCoinForLiquidity}(
            token,
            liquidityTokens,
            0, 
            0, 
            deadAddress,
            block.timestamp + 3600
        );
    }
        }
}

    function swapTokensForTokens(
        address router,
        address burnToken,
        uint256 burnfee,
        address deadAddress,
        uint256 routerType
    ) internal
    {
        address[] memory path = new address[](2);
        path[0] = IRouter(router).WAVAX(); 
        path[1] = burnToken;  
        
        if (routerType == 0) {
            IRouter(router).swapExactAVAXForTokensSupportingFeeOnTransferTokens{value: burnfee}(
                0, 
                path, 
                deadAddress, 
                block.timestamp + 3600  
            );
        } else if (routerType == 1) {
           
    
            IRouter(router).swapExactAVAXForTokensSupportingFeeOnTransferTokens{value: burnfee}(
                0,  
                path, 
                deadAddress, 
                block.timestamp + 3600 
            );
        }
    }
}
