function readLocalFile() {
    localFilePlugin.read({"file": "dummy", "ext": "txt"})
    .then(function(result) {
        console.log(result);
        document.getElementById('output').innerHTML = atob(result.data);
    })
    .catch(function(error) {
        console.log(error);
        document.getElementById('output').innerHTML = error.data;
    });
}

function asyncFunc() {
    anotherPlugin.delay()
    .then(function(result) {
        console.log(result);
        document.getElementById('output').innerHTML += result.data;
    })
    .catch(function(error) {
        console.log(error);
        document.getElementById('output').innerHTML += error.data;
    });
}

function invokeFromNative(payload) {
    console.log(payload);
    document.getElementById('output-invoked-by-native').innerHTML = payload;
    return new Promise(function(resolve, reject) {
        setTimeout(function() {
            resolve({"result": "this result comes from web"});
            //reject("error": "this error comes from web"});
        }, 5000);
    });
}