## 部署
```sh
➜  openspace_ctf git:(main) ✗ forge script script/Vault.s.sol --rpc-url http://127.0.0.1:8545 --broadcast

== Logs ==
  Vault deployed on 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512

##### anvil-hardhat
✅  [Success]Hash: 0x568c165af7e2b1100243fed9e700bc62ca0651f93d373bd71cbe5adc64a9462e
Block: 2
Paid: 0.000038123606480414 ETH (43498 gas * 0.876445043 gwei)

##### anvil-hardhat
✅  [Success]Hash: 0xc3b0b9a63fd8d84f33b55d64da2af1f4d5d79194cea11e5f0180373c9e390982
Contract Address: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Block: 1
Paid: 0.000173405000173405 ETH (173405 gas * 1.000000001 gwei)


##### anvil-hardhat
✅  [Success]Hash: 0x81850ff27278a1e5f1898deab41dc50d9296f03618a30fc6fcc81f9bd1964fb9
Contract Address: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
Block: 2
Paid: 0.000238606904286492 ETH (272244 gas * 0.876445043 gwei)

✅ Sequence #1 on anvil-hardhat | Total Paid: 0.000450135510940311 ETH (489147 gas * avg 0.917630029 gwei)
                                                                                                                                                
```
- VaultLogic address: `0x5FbDB2315678afecb367f032d93F642f64180aa3`
- Vault address: `0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512`

## 查看solt 1 的内容
```sh

➜  openspace_ctf git:(main) ✗ cast rpc "eth_getStorageAt" 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 0x1 latest                                
"0x0000000000000000000000005fbdb2315678afecb367f032d93f642f64180aa3"
```
存储的是`VaultLogic address`。

## 注意
在`Attacker`合约中的`attack()`函数，转入到`vault`合约中的钱不能大于`vault`合约拥有的钱，否则会因为这行代码报错`(bool result, ) = msg.sender.call{value: deposites[msg.sender]}("");`。原因是因为会vault合约第二次转钱时，它剩余的钱小于`deposites[msg.sender]`，那么最后`vault`合约就还有剩余。