// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SpotMarket {
    uint public nextOrderId;
    address public owner;

    enum OrderType { Buy, Sell }

    struct Order {
        uint orderId;
        address user;
        OrderType orderType;
        uint price;
        uint quantity;
        bool active;
    }

    mapping(uint => Order) public orders;

    event OrderPlaced(uint orderId, address user, OrderType orderType, uint price, uint quantity);
    event OrderCancelled(uint orderId);

    constructor() {
        owner = msg.sender;
        nextOrderId = 1;
    }

    // 下单
    function placeOrder(OrderType _orderType, uint _price, uint _quantity) external {
        require(_price > 0, "Price must be greater than 0");
        require(_quantity > 0, "Quantity must be greater than 0");

        uint orderId = nextOrderId;
        orders[orderId] = Order({
            orderId: orderId,
            user: msg.sender,
            orderType: _orderType,
            price: _price,
            quantity: _quantity,
            active: true
        });

        nextOrderId++;

        emit OrderPlaced(orderId, msg.sender, _orderType, _price, _quantity);
    }

    // 取消订单
    function cancelOrder(uint _orderId) external {
        Order storage order = orders[_orderId];
        require(order.active, "Order is not active");
        require(order.user == msg.sender, "You can only cancel your own orders");

        order.active = false;

        emit OrderCancelled(_orderId);
    }

    // 获取订单信息
    function getOrder(uint _orderId) external view returns (address user, OrderType orderType, uint price, uint quantity, bool active) {
        Order memory order = orders[_orderId];
        return (order.user, order.orderType, order.price, order.quantity, order.active);
    }
}
