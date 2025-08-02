// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/SpotMarket.sol";

contract DeploySpotMarket is Script {
    function run() external {
        vm.startBroadcast();

        SpotMarket spotMarket = new SpotMarket();
        console.log("SpotMarket deployed at:", address(spotMarket));

        vm.stopBroadcast();
    }
}