
class Band {
  String id;
  String name;
  int votos;

  Band({
    this.id,
    this.name,
    this.votos
  });

  factory Band.fromMap(Map <String, dynamic> obj)=> Band(
    id: obj['id'] ,
    name:obj['name'],
    votos:obj['votos']
    
  );







}