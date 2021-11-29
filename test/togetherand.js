// npm install --save-dev @openzeppelin/test-helpers
// truffle test --show-events
const { time } = require("@openzeppelin/test-helpers");

const TogetheRand = artifacts.require("TogetheRand")

contract("TogetheRand", async accounts => {
    describe("Participate 12", () => {
        it("Block 0", async () => {
            const instance = await TogetheRand.deployed();
            await console.log("Block 0", new Date().toLocaleString());
            await Promise.all([
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000012", {from: accounts[0]}),
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000034", {from: accounts[1]})
            ]);
        });
        it("Block 1", async () => {
            const instance = await TogetheRand.deployed();
            await console.log("Block 1", new Date().toLocaleString());
            await Promise.all([
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000056", {from: accounts[2]}),
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000078", {from: accounts[3]})
            ]);
        });
        it("Block 2", async () => {
            const instance = await TogetheRand.deployed();
            await console.log("Block 2", new Date().toLocaleString());
            await Promise.all([
                instance.Participate("0x000000000000000000000000000000000000000000000000000000000000009A", {from: accounts[4]}),
                instance.Participate("0x00000000000000000000000000000000000000000000000000000000000000BC", {from: accounts[5]})
            ]);
        });
        it("Block 3", async () => {
            const instance = await TogetheRand.deployed();
            await console.log("Block 3", new Date().toLocaleString());
            await Promise.all([
                instance.Participate("0x00000000000000000000000000000000000000000000000000000000000000DE", {from: accounts[6]}),
                instance.Participate("0x00000000000000000000000000000000000000000000000000000000000000F1", {from: accounts[7]})
            ]);
        });
        it("Block 4", async () => {
            const instance = await TogetheRand.deployed();
            await console.log("Block 4", new Date().toLocaleString());
            await Promise.all([
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000023", {from: accounts[8]}),
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000045", {from: accounts[9]})
            ]);
        });
        it("Block 5", async () => {
            const instance = await TogetheRand.deployed();
            await console.log("Block 5", new Date().toLocaleString());
            await Promise.all([
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000067", {from: accounts[10]}),
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000089", {from: accounts[11]})
            ]);
        });

        it("END", async () => {
            const instance = await TogetheRand.deployed();
            await instance.END({from: accounts[12]});
        });
    
        it("GetRandomNumbers", async () => {
            const instance = await TogetheRand.deployed();
            // GetRandomNumbers
            var acc;
            for (acc = 0; acc < 12; acc++) {
                let rand = await instance.GETmyRandomNumber.call(accounts[acc]);
                console.log('Account', acc, '\t: ', rand);
            }
        });
    });
});