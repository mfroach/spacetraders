const fs = require('fs').promises;
const Client = require('node-rest-client').Client;
const { exists, chmodSync } = require('fs');
const repl = require('repl');
const srv = 'https://api.spacetraders.io/v2/';

let token; // Declare token at the global level

function makeRequest(opt) {
    const endpoint = `${srv}${opt}`;
    const args = {
        headers: {'Content-Type': 'application/json', 'Authorization': `Bearer ${token}`}
    };

    const client = new Client();
    client.get(`${endpoint}`, args, (data, response) => {
        // Handle the response here
        if (response.statusCode === 200) {
            console.log('Response data:', data);
        } else {
            console.error('Error:', response.statusCode, data);
        }
    });
}

// Read the token asynchronously and set it when available
fs.readFile('secrets/token.txt', 'utf8')
    .then((data) => {
        token = data; // Store the token at the global level
    })
    .catch((err) => {
        console.error(err);
    });

function myEval(cmd, context, filename) {
    var cmds = ('test','test2');
    if(cmds.includes(cmd)); {
        console.log("You just tested");
    }
}

const myRepl = repl.start({
    prompt: '> ',
    eval: (input, context, filename, callback) => { // TODO: implement my eval https://nodejs.dev/en/api/v20/repl/#custom-evaluation-functions
        try {
            const userIn = eval(input);
            callback(null, userIn);
        } catch (err) {
            callback(err);
        }
    }
});