pragma solidity >=0.5.0;

contract Payload {
    mapping (address => string[]) incoming_payload;
    mapping (address => string[]) incoming_payload_status;
    mapping (address => string[] ) payload_history;
    
    // post tran from Visa to Bank
    function sendPayloadToBank(address _bank, string memory payload) public returns(string memory){
        incoming_payload[_bank].push(payload);
        return 'Payload sent successfully';
    }

    // bank uses this to get payload data
    function payloadRecievedByBank(address _bankLoad) public returns (string[] memory) {
        string[] memory recieved_payloads = incoming_payload[_bankLoad];

        uint payload_length = recieved_payloads.length;

        for (uint i = 0 ; i<payload_length;i++)
        {
            payload_history[_bankLoad].push(recieved_payloads[i]);
        }
        delete incoming_payload[_bankLoad];
        return recieved_payloads;
    }


    // bank uses this to send payload status
    function payloadStatusByBank(address _visa, string memory status) public returns(string memory)
    {
        incoming_payload_status[_visa].push(status);
        return 'Status sent successfully';
    } 

    // visa uses this to get payment status
    function payloadStatusLoad(address _visaLoad)public returns (string[] memory )
    {
         string[] memory recieved_payloads_statuses = incoming_payload_status[_visaLoad];

        uint status_length = recieved_payloads_statuses.length;

        for (uint i = 0 ; i<status_length;i++)
        {
            payload_history[_visaLoad].push(recieved_payloads_statuses[i]);
        }
        delete incoming_payload_status[_visaLoad];
        return recieved_payloads_statuses;
    }

    // bank or visa can use this to get payload history
    function payloadHistoryOfBank(address _recipient) view public returns (string[] memory)
    {
        return payload_history[_recipient];
    }
    }