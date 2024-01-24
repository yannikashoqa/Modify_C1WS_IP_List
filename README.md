# Cloud One Workload Security IP List Manager

AUTHOR		: Yanni Kashoqa

TITLE		: Cloud One Workload Security IP List Management

DESCRIPTION	: These Powershell scripts will allow you to overwrite the cotent of an existing IP List in Workload Security using C1 WS APIs.


REQUIRMENTS
- Tested with PowerShell 7+ Core
- Populate the CSV file: IP_List.csv
    - File Content Header:  IP
    - One item per line
    - Supported formats: X.X.X.X/1-32, X.X.X.X/Y.Y.Y.Y, X.X.X.X
    - Examples: 192.168.2.0/24, 192.168.2.0/255.255.255.0, 192.168.2.33
- Create a C1WS-Config.json in the same folder as this script with the following content:

~~~~JSON
{
    "MANAGER": "workload.us-1.cloudone.trendmicro.com",
    "APIKEY" : "ApiKey YourC1APIKey"
}
~~~~

- APIKEY must be in the format of "ApiKey YourC1APIKey"
- YourC1APIKey is created in your Cloud One console > Administration > API Keys
- MANAGER: For non US regions, change the us-1 in the URL to match with your region


