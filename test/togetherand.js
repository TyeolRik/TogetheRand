// npm install --save-dev @openzeppelin/test-helpers
const { time } = require("@openzeppelin/test-helpers");

const TogetheRand = artifacts.require("TogetheRand")

contract("TogetheRand", async accounts => {
    describe("Participate 12", () => {
        it("Block 0", async () => {
            const instance = await TogetheRand.deployed();
            await console.log("Block 0", new Date().toLocaleString());
            await Promise.all([
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000011", {from: accounts[0]}),
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000022", {from: accounts[1]})
            ]);
        });
        it("Block 1", async () => {
            const instance = await TogetheRand.deployed();
            await console.log("Block 1", new Date().toLocaleString());
            await Promise.all([
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000033", {from: accounts[2]}),
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000044", {from: accounts[3]})
            ]);
        });
        it("Block 2", async () => {
            const instance = await TogetheRand.deployed();
            await console.log("Block 2", new Date().toLocaleString());
            await Promise.all([
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000055", {from: accounts[4]}),
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000066", {from: accounts[5]})
            ]);
        });
        it("Block 3", async () => {
            const instance = await TogetheRand.deployed();
            await console.log("Block 3", new Date().toLocaleString());
            await Promise.all([
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000077", {from: accounts[6]}),
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000088", {from: accounts[7]})
            ]);
        });
        it("Block 4", async () => {
            const instance = await TogetheRand.deployed();
            await console.log("Block 4", new Date().toLocaleString());
            await Promise.all([
                instance.Participate("0x0000000000000000000000000000000000000000000000000000000000000099", {from: accounts[8]}),
                instance.Participate("0x00000000000000000000000000000000000000000000000000000000000000AA", {from: accounts[9]})
            ]);
        });
        it("Block 5", async () => {
            const instance = await TogetheRand.deployed();
            await console.log("Block 5", new Date().toLocaleString());
            await Promise.all([
                instance.Participate("0x00000000000000000000000000000000000000000000000000000000000000BB", {from: accounts[10]}),
                instance.Participate("0x00000000000000000000000000000000000000000000000000000000000000CC", {from: accounts[11]})
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