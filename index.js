const fs = require('fs');
const Client = require('node-rest-client').Client;
const client = new Client();
const srv = 'https://api.spacetraders.io/v2/';

fs.readFile('secrets/token.txt', 'utf8', (err, data) => {
    if (err) {
        console.error(err);
        return;
    }

    const token = data; // Store the token in a variable

    function makeRequest(opt) {
        const endpoint = `${srv}${opt}`;
        const args = {
            headers: {'Content-Type': 'application/json', 'Authorization': `Bearer ${token}`}
        };

        client.get(`${endpoint}`, args, (data, response) => {
            // Handle the response here
            if (response.statusCode === 200) {
                console.log('Response data:', data);
            } else {
                console.error('Error:', response.statusCode, data);
            }
        });
    }

    makeRequest('my/agent');
});
