# Spot Market Foundry

使用 Solidity 和 Foundry 开发的现货市场合约，支持下单和取消订单功能，已部署到 Injective EVM 测试网。

---

## 📦 项目结构
spot-market-foundry/
├── lib/ # 依赖库 (forge-std, openzeppelin)
├── out/ # 编译输出
├── script/ # 部署脚本
│ └── DeploySpotMarket.s.sol
├── src/ # 合约源码
│ ├── SpotMarket.sol
│ └── SpotOrderManager.sol
├── test/ # 测试文件
│ ├── SpotMarket.t.sol
│ └── SpotOrderManager.t.sol
├── .env # 环境变量
├── foundry.toml # Foundry 配置
└── README.md


---

## 🚀 部署步骤

1. **安装依赖**
   ```bash
   forge install

2.编译并测试
forge build
forge test

3. 部署合约
cast send \
  --rpc-url https://k8s.testnet.json-rpc.injective.network \
  --private-key $PRIVATE_KEY \
  --chain-id 1439 \
  --create $(cat SpotMarket.bin)

部署成功后会返回合约地址，例如：
contractAddress  0xb9433ECCf417321198Fd8e9b7639422125bf8BE1

🛠️ 合约交互
1️⃣ Place Order
cast send \
  --rpc-url https://k8s.testnet.json-rpc.injective.network \
  --private-key $PRIVATE_KEY \
  --chain-id 1439 \
  0xb9433ECCf417321198Fd8e9b7639422125bf8BE1 \
  "placeOrder(uint8,uint256,uint256)" 0 1000 5

2️⃣ 获取最新订单 ID
cast call \
  --rpc-url https://k8s.testnet.json-rpc.injective.network \
  --chain-id 1439 \
  0xb9433ECCf417321198Fd8e9b7639422125bf8BE1 \
  -- "nextOrderId()(uint256)"

输出 2 表示上一次下单的订单 ID 为 1

3️⃣ Cancel Order
cast send \
  --rpc-url https://k8s.testnet.json-rpc.injective.network \
  --private-key $PRIVATE_KEY \
  --chain-id 1439 \
  0xb9433ECCf417321198Fd8e9b7639422125bf8BE1 \
  "cancelOrder(uint256)" 1

📝 部署信息
合约地址: 0xb9433ECCf417321198Fd8e9b7639422125bf8BE1

测试网链 ID: 1439

RPC: https://k8s.testnet.json-rpc.injective.network

区块浏览器: BlockScout

📸 交互历史截图
✅ Place Order 成功
✅ Cancel Order 成功
# Spot Market Foundry

## 交互历史截图

### 下单成功

![Place Order Success](screenshots/place-order-success.png)

### 取消订单成功

![Cancel Order Success](screenshots/cancel-order-success.png)


✅ 测试状态
通过 Foundry 测试：
Ran 7 tests: all passed


---

你只需要：  
1. 在本地创建 `screenshots/` 文件夹，放入 `place-order-success.png` 和 `cancel-order-success.png`。  
2. 运行：
   ```bash
   git add screenshots/ README.md
   git commit -m "add screenshots to README"
   git push

