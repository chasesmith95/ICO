var Queue = artifacts.require("./Queue.sol");

contract('Queue', function(accounts) {
  it("~Creating queue", function() {
    var queue;
    return Queue.deployed().then(function(instance) {
      queue = instance;
      return queue.qsize.call()
     
    }).then(function(size) {
      assert.equal(size.toNumber(), 0, "Queue size should be zero");
      return queue.empty.call()
    }).then(function(isempty) {
      assert.equal(isempty, true, "Queue should be empty");
    })
  });

  it("~Enqueue/dequeue", function() {
    var queue;
    var acc1 = accounts[0];
    var acc2 = accounts[1];
    var acc3 = accounts[2];
    var acc4 = accounts[3];
    var acc5 = accounts[4];
    var acc6 = accounts[5];

    return Queue.deployed().then(function(instance) {
      queue = instance;
      queue.enqueue(acc1);
      return queue.qsize.call()
    }).then(function(size) {
      assert.equal(size.toNumber(), 1, "Queue size should be one");
      queue.dequeue();
      return queue.qsize.call()
    }).then(function(size) {
      assert.equal(size.toNumber(), 0, "Queue size should zero");
      queue.enqueue(acc1);
      queue.enqueue(acc2);
      queue.enqueue(acc3);
      queue.enqueue(acc4);
      queue.enqueue(acc5);
      return queue.qsize.call()
    }).then(function(size) {
      assert.equal(size.toNumber(), 5, "Queue size should be five");
      queue.enqueue(acc6);
      return queue.qsize.call()
    }).then(function(size) {
      assert.equal(size.toNumber(), 5, "Queue size cannot go past five");
      queue.checkTime();
      return queue.qsize.call()
    }).then(function(size) {
      assert.equal(size.toNumber(), 5, "Cannot remove using checkTime()");
      queue.dequeue();
      return queue.qsize.call()
    }).then(function(size) {
      assert.equal(size.toNumber(), 4, "Queue size should be four");
    })
  });
})
