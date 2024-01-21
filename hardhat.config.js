require("@nomicfoundation/hardhat-toolbox");
require("hardhat-deploy");
require("dotenv").config();


const BSCSCAN_API_KEY = process.env.BSCSCAN_API_KEY || "";
const PRIVATE_KEY = process.env.PRIVATE_KEY || "";


module.exports = {
    solidity: "0.8.21",
    networks: {
        bsctestnet: {
        url: process.env.TESTNET_RPC,
        accounts: [process.env.PRIVATE_KEY],
        gasPrice: 30000000000,
      },
    },
    etherscan: {
      apiKey: process.env.BSCSCAN_API_KEY
    }
  };
