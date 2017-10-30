var Crowdsale = artifacts.require("./Crowdsale.sol");

contract('CrowdSaleTest', function(accounts) {
    let crowdsale;

	beforeEach(async function() {
		let instantiatian = await Crowdsale.new(
			100,
			1000,
			10,
			{from: accounts[0]},
			);
		crowdsale = instantiatian;
	});

	describe('Initialize', function() {
		it("TestValuesOnInitialize", async function() {
			let owner = await crowdsale.owner.call();
			let fundsRaised = await crowdsale.fundsRaised.call();
			let startSale = await crowdsale.startSale.call();
			let endSale = await crowdsale.endSale.call();
			assert.equal(0x0, owner.valueOf(), "nobody created anythingyet");
			assert.equal(0, fundsRaised.valueOf(), "amount raised starts at 0");
			assert.isAtMost(startSale.valueOf(), endSale.valueOf(), "endSale should be past startSale")
		});
	});
});