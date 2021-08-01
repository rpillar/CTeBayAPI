getdata
getEBayXOrdersAll

	| response writer |

	writer := XMLWriter new.
	writer enablePrettyPrinting; xml; comment: 'ebay - get all ebay orders'.
	writer tag name: 'GetOrdersRequest'; xmlns: 'urn:ebay:apis:eBLBaseComponents'; 
		with: [  
			writer 
				tag: 'DetailLevel' with: 'ItemReturnDescription'.	
			writer 
				tag: 'RequesterCredentials' with: [  
					writer tag: 'eBayAuthToken' with: self myEbay token. 
				].
		]. 

	"ebay function ..."
	request headerAt: 'X-EBAY-API-CALL-NAME' add: 'GetOrders'.
	response := self request
		url: self myEbay url; 
		entity: (
			ZnEntity 
				with: writer asString
				type: ZnMimeType applicationXml
		);
		post;
		response.
		
	^ response.