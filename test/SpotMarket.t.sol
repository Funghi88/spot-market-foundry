// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SpotMarket.sol";

contract SpotMarketTest is Test {
    SpotMarket public spotMarket;

    address public user1;
    address public user2;

    function setUp() public {
        spotMarket = new SpotMarket();
        user1 = address(0x1);
        user2 = address(0x2);
    }

    function testPlaceOrder() public {
        uint price = 100;
        uint quantity = 10;

        vm.prank(user1);
        spotMarket.placeOrder(SpotMarket.OrderType.Buy, price, quantity);

        (address user, SpotMarket.OrderType orderType, uint orderPrice, uint orderQuantity, bool active) = spotMarket.getOrder(1);

        assertEq(user, user1);
        assertEq(uint(orderType), uint(SpotMarket.OrderType.Buy)); // ✅ 转换为 uint
        assertEq(orderPrice, price);
        assertEq(orderQuantity, quantity);
        assertTrue(active, "Order should be active");
    }

    function testCancelOrder() public {
        uint price = 100;
        uint quantity = 10;

        vm.prank(user1);
        spotMarket.placeOrder(SpotMarket.OrderType.Buy, price, quantity);

        vm.prank(user1);
        spotMarket.cancelOrder(1);

        (address user, SpotMarket.OrderType orderType, uint orderPrice, uint orderQuantity, bool active) = spotMarket.getOrder(1);

        assertEq(user, user1);
        assertEq(uint(orderType), uint(SpotMarket.OrderType.Buy)); // ✅ 转换为 uint
        assertEq(orderPrice, price);
        assertEq(orderQuantity, quantity);
        assertFalse(active, "Order should be inactive");
    }
}