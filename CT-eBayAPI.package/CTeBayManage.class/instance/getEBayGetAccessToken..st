getdata
getEBayGetAccessToken: aScope

	"retrieve an oauth access token - response in the format -> { 'access_token': 'nxnxn....', 'expires_in': 7200, 'token_type': 'Application Access Token' }"

	| accessTokenResponse |

	accessTokenResponse := (ZnClient new)
		url: 'https://api.sandbox.ebay.com/identity/v1/oauth2/token';
		headerAt: 'Content-Type' put: 'application/x-www-form-urlencoded';
		setBasicAuthenticationUsername: ( myEbay credentials at: #appId ) password: ( myEbay credentials at: #certId );
		formAdd: 'grant_type'->'client_credentials';
		post;
		response.

	^ ( NeoJSONReader fromString: accessTokenResponse contents ) t: #access_token.