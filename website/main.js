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