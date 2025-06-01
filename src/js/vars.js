var jsonObject = {
                   "items": [
                     {
                       "fname": "rafael",
                       "lname": "marques",
                       "age": "19"},
                     {
                       "fname": "daniel",
                       "lname": "marques",
                       "age": "19"
                     }]
                 };

var jsonObject1 = fetch('/data/data.json')
                      .then((response) => response.json())
                      .then((json) => console.log(json));