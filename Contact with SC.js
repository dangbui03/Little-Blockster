const Web3 = require("web3");
const web3 = new Web3("YOUR_PROVIDER_URL");

const contractAddress = "CONTRACT_ADDRESS";
const contractABI = []; // ABI của smart contract

const contractInstance = new web3.eth.Contract(contractABI, contractAddress);

// Gửi Ether vào hợp đồng
const amountToSend = web3.utils.toWei("1", "ether");
contractInstance.methods
  .sendPayment()
  .send({ from: "SENDER_ADDRESS", value: amountToSend });

// Rút số tiền từ hợp đồng
contractInstance.methods.withdraw().send({ from: "OWNER_ADDRESS" });
