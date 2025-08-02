// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract SpotOrderManager {
    enum OrderType { Buy, Sell }

    struct Order {
        uint256 id;
        address trader;
        OrderType orderType;
        uint256 amount;
        uint256 price;
        bool isActive;
    }

    uint256 public nextOrderId;
    mapping(uint256 => Order) public orders;

    event OrderPlaced(uint256 indexed orderId, address indexed trader, OrderType orderType, uint256 amount, uint256 price);
    event OrderCancelled(uint256 indexed orderId, address indexed trader);

    constructor() {
        nextOrderId = 1;
    }

    function placeOrder(OrderType _orderType, uint256 _amount, uint256 _price) external {
        require(_amount > 0, "Amount must be > 0");
        require(_price > 0, "Price must be > 0");

        orders[nextOrderId] = Order({
            id: nextOrderId,
            trader: msg.sender,
            orderType: _orderType,
            amount: _amount,
            price: _price,
            isActive: true
        });

        emit OrderPlaced(nextOrderId, msg.sender, _orderType, _amount, _price);
        nextOrderId++;
    }

    function cancelOrder(uint256 _orderId) external {
        Order storage order = orders[_orderId];
        require(order.trader == msg.sender, "Not your order");
        require(order.isActive, "Order already cancelled");

        order.isActive = false;

        emit OrderCancelled(_orderId, msg.sender);
    }
}
