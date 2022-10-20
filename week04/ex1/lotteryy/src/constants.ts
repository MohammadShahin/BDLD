export const abi = [
	{
		"inputs": [],
		"name": "enter",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "pickWinner",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [],
		"name": "getPlayers",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "index0xDParticipant",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "index0xFParticipant",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "manager",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "players",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]

export const bytecode = "608060405234801561001057600080fd5b50336000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550611174806100606000396000f3fe6080604052600436106100705760003560e01c80638b5b9ccc1161004e5780638b5b9ccc146100e2578063942e82521461010d578063e97dcb6214610138578063f71d96cb1461014257610070565b8063481c6a751461007557806351427561146100a05780635d495aea146100cb575b600080fd5b34801561008157600080fd5b5061008a61017f565b6040516100979190610bb4565b60405180910390f35b3480156100ac57600080fd5b506100b56101a3565b6040516100c29190610be8565b60405180910390f35b3480156100d757600080fd5b506100e06101a9565b005b3480156100ee57600080fd5b506100f76103bd565b6040516101049190610cc1565b60405180910390f35b34801561011957600080fd5b5061012261044b565b60405161012f9190610be8565b60405180910390f35b610140610451565b005b34801561014e57600080fd5b5061016960048036038101906101649190610d14565b6105af565b6040516101769190610bb4565b60405180910390f35b60008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b60035481565b60008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff161461020157600080fd5b6000806002541415801561021757506000600354145b1561023257600160025461022b9190610d70565b905061027e565b60006002541480156102475750600060035414155b1561026257600160035461025b9190610d70565b905061027d565b6001805490506102706105ee565b61027a9190610dd3565b90505b5b6001818154811061029257610291610e04565b5b9060005260206000200160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166108fc479081150290604051600060405180830381858888f19350505050158015610302573d6000803e3d6000fd5b5061034a6001828154811061031a57610319610e04565b5b9060005260206000200160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16610624565b600067ffffffffffffffff81111561036557610364610e33565b5b6040519080825280602002602001820160405280156103935781602001602082028036833780820191505090505b50600190805190602001906103a9929190610acc565b506000600281905550600060038190555050565b6060600180548060200260200160405190810160405280929190818152602001828054801561044157602002820191906000526020600020905b8160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190600101908083116103f7575b5050505050905090565b60025481565b662386f26fc10000341161046457600080fd5b6001339080600181540180825580915050600190039060005260206000200160009091909190916101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555060006104e83373ffffffffffffffffffffffffffffffffffffffff166106bd565b90506104f781600060036106db565b90506040518060400160405280600381526020017f307864000000000000000000000000000000000000000000000000000000000081525080519060200120818051906020012003610554576001805490506002819055506105ac565b6040518060400160405280600381526020017f3078660000000000000000000000000000000000000000000000000000000000815250805190602001208180519060200120036105ab576001805490506003819055505b5b50565b600181815481106105bf57600080fd5b906000526020600020016000915054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b60004442600160405160200161060693929190610fa1565b6040516020818303038152906040528051906020012060001c905090565b6106ba816040516024016106389190610bb4565b6040516020818303038152906040527f2c2ecbc2000000000000000000000000000000000000000000000000000000007bffffffffffffffffffffffffffffffffffffffffffffffffffffffff19166020820180517bffffffffffffffffffffffffffffffffffffffffffffffffffffffff83818316178352505050506107d7565b50565b60606106d48260016106ce85610800565b01610890565b9050919050565b60606000849050600084846106f09190610d70565b67ffffffffffffffff81111561070957610708610e33565b5b6040519080825280601f01601f19166020018201604052801561073b5781602001600182028036833780820191505090505b50905060008590505b848110156107ca5782818151811061075f5761075e610e04565b5b602001015160f81c60f81b8287836107779190610d70565b8151811061078857610787610e04565b5b60200101907effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916908160001a90535080806107c290610fda565b915050610744565b5080925050509392505050565b60008151905060006a636f6e736f6c652e6c6f679050602083016000808483855afa5050505050565b600080600090506000608084901c111561082257608083901c92506010810190505b6000604084901c111561083d57604083901c92506008810190505b6000602084901c111561085857602083901c92506004810190505b6000601084901c111561087357601083901c92506002810190505b6000600884901c1115610887576001810190505b80915050919050565b6060600060028360026108a39190611022565b6108ad9190611064565b67ffffffffffffffff8111156108c6576108c5610e33565b5b6040519080825280601f01601f1916602001820160405280156108f85781602001600182028036833780820191505090505b5090507f3000000000000000000000000000000000000000000000000000000000000000816000815181106109305761092f610e04565b5b60200101907effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916908160001a9053507f78000000000000000000000000000000000000000000000000000000000000008160018151811061099457610993610e04565b5b60200101907effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916908160001a905350600060018460026109d49190611022565b6109de9190611064565b90505b6001811115610a7e577f3031323334353637383961626364656600000000000000000000000000000000600f861660108110610a2057610a1f610e04565b5b1a60f81b828281518110610a3757610a36610e04565b5b60200101907effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916908160001a905350600485901c945080610a7790611098565b90506109e1565b5060008414610ac2576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610ab99061111e565b60405180910390fd5b8091505092915050565b828054828255906000526020600020908101928215610b45579160200282015b82811115610b445782518260006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555091602001919060010190610aec565b5b509050610b529190610b56565b5090565b5b80821115610b6f576000816000905550600101610b57565b5090565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b6000610b9e82610b73565b9050919050565b610bae81610b93565b82525050565b6000602082019050610bc96000830184610ba5565b92915050565b6000819050919050565b610be281610bcf565b82525050565b6000602082019050610bfd6000830184610bd9565b92915050565b600081519050919050565b600082825260208201905092915050565b6000819050602082019050919050565b610c3881610b93565b82525050565b6000610c4a8383610c2f565b60208301905092915050565b6000602082019050919050565b6000610c6e82610c03565b610c788185610c0e565b9350610c8383610c1f565b8060005b83811015610cb4578151610c9b8882610c3e565b9750610ca683610c56565b925050600181019050610c87565b5085935050505092915050565b60006020820190508181036000830152610cdb8184610c63565b905092915050565b600080fd5b610cf181610bcf565b8114610cfc57600080fd5b50565b600081359050610d0e81610ce8565b92915050565b600060208284031215610d2a57610d29610ce3565b5b6000610d3884828501610cff565b91505092915050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b6000610d7b82610bcf565b9150610d8683610bcf565b9250828203905081811115610d9e57610d9d610d41565b5b92915050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601260045260246000fd5b6000610dde82610bcf565b9150610de983610bcf565b925082610df957610df8610da4565b5b828206905092915050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052604160045260246000fd5b6000819050919050565b610e7d610e7882610bcf565b610e62565b82525050565b600081549050919050565b600081905092915050565b60008190508160005260206000209050919050565b610eb781610b93565b82525050565b6000610ec98383610eae565b60208301905092915050565b60008160001c9050919050565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b6000610f15610f1083610ed5565b610ee2565b9050919050565b6000610f288254610f02565b9050919050565b6000600182019050919050565b6000610f4782610e83565b610f518185610e8e565b9350610f5c83610e99565b8060005b83811015610f9457610f7182610f1c565b610f7b8882610ebd565b9750610f8683610f2f565b925050600181019050610f60565b5085935050505092915050565b6000610fad8286610e6c565b602082019150610fbd8285610e6c565b602082019150610fcd8284610f3c565b9150819050949350505050565b6000610fe582610bcf565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff820361101757611016610d41565b5b600182019050919050565b600061102d82610bcf565b915061103883610bcf565b925082820261104681610bcf565b9150828204841483151761105d5761105c610d41565b5b5092915050565b600061106f82610bcf565b915061107a83610bcf565b925082820190508082111561109257611091610d41565b5b92915050565b60006110a382610bcf565b9150600082036110b6576110b5610d41565b5b600182039050919050565b600082825260208201905092915050565b7f537472696e67733a20686578206c656e67746820696e73756666696369656e74600082015250565b60006111086020836110c1565b9150611113826110d2565b602082019050919050565b60006020820190508181036000830152611137816110fb565b905091905056fea2646970667358221220a6c5a38994f2806b1a10313950b910b9d188fc375dbc44793df712847f38170164736f6c63430008110033"
