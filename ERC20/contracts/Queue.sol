pragma solidity ^0.4.15;

/**
 * @title Queue
 * @dev Data structure contract used in `Crowdsale.sol`
 * Allows buyers to line up on a first-in-first-out basis
 * See this example: http://interactivepython.org/courselib/static/pythonds/BasicDS/ImplementingaQueueinPython.html
 */

contract Queue {
	/* State variables */
	uint8 size = 0;
	address[] addressList;
	mapping (address => uint) startTimes;
	mapping (address => uint) indices;
	uint front = 0;
	uint back = 0;

	/* Add events */
	// YOUR CODE HERE

	/* Add constructor */
	function Queue() payable {
		addressList = new address[](5);
	}

	/* Returns the number of people waiting in line */
	function qsize() constant returns(uint8) {
		return size;
	}

	/* Returns whether the queue is empty or not */
	function empty() constant returns(bool) {
		return (size == 0);
	}
	
	/* Returns the address of the person in the front of the queue */
	function getFirst() constant returns(address) {
		return addressList[front];
	}
	
	/* Allows `msg.sender` to check their position in the queue */
	function checkPlace() constant returns(uint256) {
		return indices[msg.sender] - front;
		
	}
	
	/* Allows anyone to expel the first person in line if their time
	 * limit is up
	 */
	function checkTime() returns (string) {
		if(size == 0) {
		    return "Queue is currently empty";
		}
		
	    if (now - startTimes[addressList[front]] > 300) { //time is up
	    	delete addressList[front];
	    	front += 1;
	    	size -= 1;
	    	return "First person in line has been removed";
	    }
	    
	    return "Cannot remove first person in line";
	}
	
	/* Removes the first person in line; either when their time is up or when
	 * they are done with their purchase
	 */
	function dequeue() returns (string) {
	    if(size == 0) {
	        return "Queue is currently empty";
	    }

	    if (addressList[front] == msg.sender) {
	    	delete addressList[front];
	    	front += 1;
	    	size -= 1;
	    	return "Successfully left queue";
	    }

	    if (now - startTimes[addressList[front]] > 300) { //time is up
	    	delete addressList[front];
	    	front += 1;
	    	size -= 1;
	    	return "First person in line has been removed";
	    }
	    
	    return "Cannot remove first person in line";
	    
	    
		}

	/* Places `addr` in the first empty position in the queue */
	function enqueue(address addr) returns (string) {
		if(size == 5) {
			return "Queue is currently full";
		}
	    back += 1;
	    addressList[back] = addr;
	    indices[addr] = back;
	    startTimes[addr] = now;
	    size += 1;
	    return "Successfully added to queue";
	}

	function getNow() returns (uint) {
		return now;
	}
}
