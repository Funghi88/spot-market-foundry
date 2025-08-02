// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/SpotOrderManager.sol";

contract SpotOrderManagerTest is Test {
    SpotOrderManager public manager;
    address trader = address(0x123);

    function setUp() public {
        manager = new SpotOrderManager();
        vm.startPrank(trader); // 模拟 trader 账号
    }

    function testPlaceBuyOrder() public {
        manager.placeOrder(SpotOrderManager.OrderType.Buy, 10 ether, 1 ether);

        (uint256 id, address orderTrader, SpotOrderManager.OrderType orderType, uint256 amount, uint256 price, bool isActive) = manager.orders(1);

        assertEq(id, 1);
        assertEq(orderTrader, trader);
        assertEq(uint(orderType), uint(SpotOrderManager.OrderType.Buy));
        assertEq(amount, 10 ether);
        assertEq(price, 1 ether);
        assertTrue(isActive);
    }

    function testPlaceSellOrder() public {
        manager.placeOrder(SpotOrderManager.OrderType.Sell, 5 ether, 2 ether);

        (, , SpotOrderManager.OrderType orderType, , , bool isActive) = manager.orders(1);

        assertEq(uint(orderType), uint(SpotOrderManager.OrderType.Sell));
        assertTrue(isActive);
    }

    function testCancelOrder() public {
        manager.placeOrder(SpotOrderManager.OrderType.Buy, 10 ether, 1 ether);
        manager.cancelOrder(1);

        (, , , , , bool isActive) = manager.orders(1);
        assertFalse(isActive);
    }
}
