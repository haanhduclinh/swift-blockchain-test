// Demo mining on bitcoin use swift
// swiftc main.swift -o app

import Foundation

struct Block {
	var index: Int
	var prevHash: String
	var createdAt: Int
	var receiverAddress: String
	var senderAddress: String
	var amount: Int
	var proofOfWork: String
	var description: String
}

class BlockChain {
	var chain: String = ""
	var difficuty: Int = 10000000

	init(){
		print("Sytem start!")
	}

	func addBlock(_ newBlock: Block){
		var blockStr = "Index: \(newBlock.index) | prevHash: \(newBlock.prevHash) | createdAt: \(newBlock.createdAt) | receiverAddress: \(newBlock.receiverAddress) | senderAddress: \(newBlock.senderAddress) | amount: \(newBlock.amount) | proofOfWork: \(newBlock.proofOfWork) | description: \(newBlock.description)"

		let data = Data(blockStr.utf8)
		let blockEncode = (data.map{ String(format:"%02x", $0) }.joined())

		self.chain += blockEncode
		print("Add new block: \(blockEncode)")
	}

	func validBlock(testBlock: Block) -> Bool{
		return true
	}

	func mining() -> (String){
		var result = "["

		for index in (1...8){
			result += String(job())
		}
		
		result += "]"

		return (result)
	}

	private func job() -> Int {
		var sum: Int = 0

		for index in (1...difficuty){
			sum += index
		}

		var strText = String(sum)
		let data = Data(strText.utf8)
		print(data.map{ String(format:"%02x", $0) }.joined())

		return sum
	}
}

class Log {

	init(){
	}

	func printLog(message: String) -> String {
		let msg = "INFO | \(message) | at: \(getCurrentTime())"
		print(msg)
		return(msg)
	}

	func getCurrentTime() -> Date {
		return Date()
	}
}

class Address {
	init(){}

	func createAdress() -> String {
		let prefixName = "HADL"
		let intTimeNow = Int(Date().timeIntervalSince1970)
		let addressTxt = "\(prefixName)_\(intTimeNow)"

		let data = Data(addressTxt.utf8)
		return data.map{ String(format:"%02x", $0) }.joined()
	}
}

enum CoinNetworkError: Error {
	case notConnectToServer
	case authenFailed
}

// main block

do {
	let log = Log()
	let bc = BlockChain.init()


	let address = Address.init()
	let yourAddress = address.createAdress()
	let _ = log.printLog(message: "Your wallet is \(yourAddress)")
	var index = 0
	var initPow = "[00000000|00000000|00000000|00000000|00000000|00000000|00000000|00000000]"
	var prevHash = "0"

	let receiverAddress = Address.init()
	let yourReceiverAddress = receiverAddress.createAdress()

	let timeNow = Int(Date().timeIntervalSince1970)
	var block = Block(
		index: index,
		prevHash: prevHash,
		createdAt: timeNow,
		receiverAddress: yourReceiverAddress,
		senderAddress: yourAddress,
		amount: 5,
		proofOfWork: initPow,
		description: "Legal block"
	)

	for _ in (1...10){
		let (newPow) = bc.mining()
		prevHash = String(index)

		index += 1

		initPow += newPow

		var newBlock = Block(
			index: index,
			prevHash: String(0),
			createdAt: timeNow,
			receiverAddress: yourReceiverAddress,
			senderAddress: yourAddress,
			amount: 5,
			proofOfWork: initPow,
			description: "Mining block"
		)

		let _ = log.printLog(message: "Found block. It weight: \(newBlock.amount)")
		bc.addBlock(newBlock)
	}

} catch {
	print(error)
}





