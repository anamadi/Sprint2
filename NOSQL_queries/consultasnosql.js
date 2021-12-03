use restaurantes;
//Consulta 1
db.getCollection("restaurantes").find().pretty();
db.restaurantes.find().pretty();
//Consulta 2 No incluyo el id en la consulta, porque lo saca por defecto.
db.restaurantes.find({},{"restaurant_id":1,"name":1,"borough":1,"cuisine":1}).pretty();
//Consulta 3
db.restaurantes.find({},{"restaurant_id":1,"name":1,"borough":1,"cuisine":1,"_id":false}).pretty();
//Consulta 4
db.restaurantes.find({},{"restaurant_id":1,"name":1,"borough":1,"cuisine":1,"address.zipcode":1,"_id":0}).pretty();
//Consulta 5
db.restaurantes.find({"borough":"Bronx"});
//Consulta 6
db.restaurantes.find({"borough":"Bronx"}).limit(5);
//Consulta 7
db.restaurantes.find({"borough":"Bronx"}).limit(5).skip(5);
//Consulta 8
db.restaurantes.find({"grades.score":{$gt:90}});
//Consulta 9 
db.restaurantes.find({$and:[{"grades.score":{$gt:80}},{"grades.score":{$lt:100}}]});
//Consulta 10
db.restaurantes.find({"address.coord.0":{$lt:-95.754168}});
//Consulta 11
db.restaurantes.find({$and:[{"cuisine":{$ne:'American '}},{"grades.score":{$gt: 70}},{"address.coord.0":{$lt: -65.754168}}]});
//Consulta 12 
db.restaurantes.find({"cuisine":{$ne:'American '},"grades.score":{$gt:70},"address.coord.1":{$lt: -65.754168}});
//Consulta 13 
db.restaurantes.find({$and:[{"cuisine":{$ne:'American '}},{"grades.grade":"A"},{"borough":{$ne:"Brooklin"}}]}).sort({"cuisine":-1});
//Consulta 14
db.restaurantes.find({name:/^Wil/},{restaurant_id:1,name:1,borough:1,cuisine:1,_id:0});
//Consulta 15
db.restaurantes.find({name:/ces$/},{restaurant_id:1,name:1,borough:1,cuisine:1,_id:0});
//Consulta 16
db.restaurantes.find({name:/Reg/},{restaurant_id:1,name:1,borough:1,cuisine:1,_id:0});
//Consulta 17
db.restaurantes.find({$and:[{"borough":"Bronx"},{$or:[{"cuisine":"American "},{"cuisine":"Chinese"}]}]});
//Consulta 18
db.restaurantes.find({$or:[{"borough":"Staten Island"},{"borough":"Queens"},{"borough":"Bronx"},{"borough":"Brooklin"}]},{restaurant_id:1,name:1,borough:1,cuisine:1,_id:false});
db.restaurantes.find({"borough" :{$in :["Staten Island","Queens","Bronx","Brooklyn"]}},{"restaurant_id" :1,"name":1,"borough":1,"cuisine" :1,"_id":false});
//Consulta 19
db.restaurantes.find({"borough" :{$nin :["Staten Island","Queens","Bronx","Brooklyn"]}},{"restaurant_id" :1,"name":1,"borough":1,"cuisine" :1,"_id":false});
//Consulta 20
db.restaurantes.find({"grades.score" :{$not:{$gt:10}}},{"restaurant_id" :1,"name":1,"borough":1,"cuisine" :1,"_id":false});
//Consulta 21 
db.restaurantes.find({$or:[{"cuisine":"seafood"},{"name":/^Wil/i}]});
//Consulta 22 La primera consulta no funciona bien,como un and, sino más bien como un or,es la segunda consulta la que te tiene en cuenta los tres campos en un mismo elemento del array y la tercera también.
db.restaurantes.find({$and:[{"grades.date" :ISODate("2014-08-11T00:00:00Z")},{"grades.grade":"A"},{"grades.score":11}]},{"restaurant_id" :1,"name":1,"grades":1,"_id":false});
db.restaurantes.find({ "grades": { $elemMatch: { "date" : ISODate( "2014-08-11T00:00:00Z"), "grade": "A","score":11}}},{restaurant_id:true,name:true,grades:true,_id:false});
db.restaurants.find({grades:{date:ISODate("2014-08-11T00:00:00Z"), grade: "A", score: 11}},{"restaurant_id" : 1,"name":1,"grades":1});
//Consulta 23 
db.restaurantes.find({$and:[{"grades.1.date" :ISODate("2014-08-11T00:00:00Z")},{"grades.1.grade":"A"},{"grades.1.score":9}]},{"restaurant_id" :1,"name":1,"grades":1,"_id":false});
//Consulta 24
db.restaurantes.find({"address.coord.1":{$gt:42,$lte:52}},{restaurant_id:1, name:1, address:1,_id:false});
//Consulta 25
db.restaurantes.find().sort({name:1});
//Consulta 26
db.restaurantes.find().sort({name:-1});
//Consulta 27
db.restaurantes.find().sort({"cuisine":1,"borough":-1});
//Consulta 28 
//Con el false, me doy cuenta que no existen direcciones sin calle, con el true saco el listado de todas las direcciones con sus calles.
db.restaurantes.find({"address.street":{$exists:false}});
db.restaurantes.find({"address.street":{$exists:true}});
//Consulta 29
db.restaurantes.find({"address.coord" : { $type : "double" } });
//Consulta 30
db.restaurantes.find({ "grades.score": {$mod: [ 7, 0 ]}},{restaurant_id:1,name:1,grades:1});
//Consulta 31
db.restaurantes.find({"name":/mon/i},{name:1,borough:1,"address.coord":1,cuisine:1});
//Consulta 32
db.restaurantes.find({"name":/^Mad/i},{name:1,borough:1,"address.coord":1,cuisine:1});
