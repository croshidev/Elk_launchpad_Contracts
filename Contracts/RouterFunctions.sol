// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://raw.githubusercontent.com/croshidev/Elk_launchpad_Contracts/main/Contracts/IRouter.sol";

contract RouterFunctions {

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