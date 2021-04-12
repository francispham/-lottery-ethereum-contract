require('dotenv').config();
const HDWalletProvider = require('truffle-hdwallet-provider');  // https://github.com/trufflesuite/truffle-hdwallet-provider
const Web3 = require('web3');

const { interface, bytecode } = require('./compile');

const provider = new HDWalletProvider(
  process.env.PHRASE,
  process.env.RINKEBY_ENDPOINT
);
const web3 = new Web3(provider);

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();
  console.log('Test Account:', accounts[0]);

  const results = await new web3.eth.Contract(JSON.parse(interface))
  .deploy({ data: bytecode })
  .send({ from: accounts[0], gas: '1000000' });
  
  console.log('Contract deployed to:', results.options.address);
};
deploy();

/* More Infor: https://www.udemy.com/course/ethereum-and-solidity-the-complete-developers-guide/learn/lecture/9020560#overview */ 