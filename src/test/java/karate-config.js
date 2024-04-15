function fn(){

var config = {
        baseUrl : "http://makeup-api.herokuapp.com/api/v1/products.json?"
        }
var env = karate.env
karate.log('Env is: ', env)

karate.configure('connectTimeout', 5000);
karate.configure('readTimeout',5000);
return config;
}