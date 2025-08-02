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

yaml
复制
编辑

---

## ⚙️ 安装

```bash
git clone https://github.com/<YOUR_USERNAME>/spot-market-foundry.git
cd spot-market-foundry
forge install
🧪 本地测试
bash
复制
编辑
forge test
输出示例：

css
复制
编辑
Ran 7 tests for SpotMarket and SpotOrderManager
[PASS] all tests passed
🚀 部署到 Injective 测试网
准备环境变量

在 .env 文件中填入：

bash
复制
编辑
PRIVATE_KEY=<你的钱包私钥>
INJECTIVE_RPC_URL=https://k8s.testnet.json-rpc.injective.network
编译合约

bash
复制
编辑
forge build
部署合约

bash
复制
编辑
cast send \
  --rpc-url $INJECTIVE_RPC_URL \
  --private-key $PRIVATE_KEY \
  --chain-id 1439 \
  --create $(cat out/SpotMarket.sol/SpotMarket.json | jq -r .bytecode.object)
部署成功后返回：

合约地址: 0xb9433ECCf417321198Fd8e9b7639422125bf8BE1

交易哈希: 0xc685d5c308ba5e13f33f728f14e7cc12dedbd95f2f1471442d4bb3f2ebf2f837

🔑 合约交互
1️⃣ 获取 ABI
bash
复制
编辑
cat out/SpotMarket.sol/SpotMarket.json | jq -r .abi > SpotMarket.abi
2️⃣ 下单
bash
复制
编辑
cast send \
  --rpc-url $INJECTIVE_RPC_URL \
  --private-key $PRIVATE_KEY \
  --chain-id 1439 \
  0xb9433ECCf417321198Fd8e9b7639422125bf8BE1 \
  "placeOrder(uint8,uint256,uint256)" 0 1000 5
0 = Buy

1 = Sell

1000 = 价格

5 = 数量

3️⃣ 获取当前订单 ID
bash
复制
编辑
cast call \
  --rpc-url $INJECTIVE_RPC_URL \
  --chain-id 1439 \
  0xb9433ECCf417321198Fd8e9b7639422125bf8BE1 \
  -- "nextOrderId()(uint256)"
4️⃣ 取消订单
bash
复制
编辑
cast send \
  --rpc-url $INJECTIVE_RPC_URL \
  --private-key $PRIVATE_KEY \
  --chain-id 1439 \
  0xb9433ECCf417321198Fd8e9b7639422125bf8BE1 \
  "cancelOrder(uint256)" 1
# Spot Market Foundry

## 交互历史截图

### 下单成功

![Place Order Success](screenshots/place-order-success.png)

### 取消订单成功

![Cancel Order Success](screenshots/cancel-order-success.png)
