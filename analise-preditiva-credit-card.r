library("RCurl")
library("rjson")

# Accept SSL certificates issued by public Certificate Authorities
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

h = basicTextGatherer()
hdr = basicHeaderGatherer()


req = list(
  
  Inputs = list(
    
    
    "input1" = list(
      "ColumnNames" = list("Col1", "Col2", "Col3", "Col4", "Col5", "Col6", "Col7", "Col8", "Col9", "Col10", "Col11", "Col12", "Col13", "Col14", "Col15", "Col16", "Col17", "Col18", "Col19", "Col20", "Col21"),
      "Values" = list( list( "A11",	"6",	"A34",	"A43",	"1169",	"A65",	"A75",	"4",	"A93",	"A101",	"4",	"A121",	"67",	"A143",	"A152",	"2",	"A173",	"1",	"A192",	"A201",	"1" ),  list( "A11",	"6",	"A34",	"A43",	"1169",	"A65",	"A75",	"4",	"A93",	"A101",	"4",	"A121",	"67",	"A143",	"A152",	"2",	"A173",	"1",	"A192",	"A201",	"1" )  )
    )                ),
  GlobalParameters = setNames(fromJSON('{}'), character(0))
)

body = enc2utf8(toJSON(req))
api_key = "vLwltwL06uyeCcREsvzohAFJyMmnanSvShhJDaAoM2QSmCIZ9LlMtZXM19K6EzridYbQMrIRh9BNfqnuxc2Q5g==" # Replace this with the API key for the web service
authz_hdr = paste('Bearer', api_key, sep=' ')

h$reset()
curlPerform(url = "https://ussouthcentral.services.azureml.net/workspaces/244cb34e3a684e3392e20fadd97fa92a/services/ae662f8f66a9464ebaf78e1a8c68f94c/execute?api-version=2.0&details=true",
            httpheader=c('Content-Type' = "application/json", 'Authorization' = authz_hdr),
            postfields=body,
            writefunction = h$update,
            headerfunction = hdr$update,
            verbose = TRUE
)

headers = hdr$value()
httpStatus = headers["status"]
if (httpStatus >= 400)
{
  print(paste("The request failed with status code:", httpStatus, sep=" "))
  
  # Print the headers - they include the requert ID and the timestamp, which are useful for debugging the failure
  print(headers)
}

print("Result:")
result = h$value()
print(fromJSON(result))

