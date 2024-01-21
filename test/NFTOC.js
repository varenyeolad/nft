// Import necessary modules
const { expect, assert } = require("chai");
const { BigNumber, utils } = require("ethers");
const { ethers } = require("hardhat");

// Import the testing library from hardhat-toolbox
const { expectEvent } = require("@nomicfoundation/hardhat-toolbox");

describe("NFToc", function () {
  let nftContract;

  this.beforeAll(async function () {
    const NFTcontract = await ethers.getContractFactory("NFToc");
    nftContract = await NFTcontract.deploy();
  });

  it("should set sale status active", async function () {
    // Assuming the actual function name in your contract is 'setSaleStatus'
    await nftContract.setSaleStatus(true);
    expect(await nftContract.saleIsActive()).to.equal(true);

    // Use expectEvent to capture events emitted during function calls
    await expectEvent.inTransaction(nftContract.interface, "SaleStatusUpdated", {
      isSaleActive: true,
    });
  });

  it("mint", async function () {
    await nftContract.mint();
  });

  it("get metadata", async function () {
    console.log(await nftContract.tokenURI(1));
  });
});
