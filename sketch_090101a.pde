//code es donde se cargar el codigo que este en el archivo comandos.txt
String [] code;
//el hashMap es el que controla una buena parte del sistema de variables
HashMap<String, Float> variables = new HashMap<String, Float>();
//inicio
void setup(){
  size(500,500);
  background(255);
  //carga comandos.txt en code
  code = loadStrings("comandos.txt");
  //empieza a leer code linea por linea y lo pasa al interprete
  for(String linea : code){
    interprete(linea);
  }
}
//inicio del interprete 
void interprete(String linea){
  //quita los espacios con .trim
  linea = trim(linea);
  //ignora la linea en que este # ya que es un comentario
  if(linea.length() == 0 || linea.startsWith("#")) return;
  //separa con espacio los comando de los argumentos (argumento = partes)
  String[] partes = splitTokens(linea, " ");
  String comando = partes[0].toLowerCase();
  //inicio de estructura condicional que verifica el comando con sus argumentos cada comando requiera mas o menos argumentos
   //comando set es para esablecer una variable sin indentificacion o neutra puede ser boolean int string ect solo se pone set (nombre) valor
    if(comando.equals("set")){
      //verifica el nombre el cual se debe de especificar un espacio despues del set
    String nombre = partes[1];
    //lo mismo que con el nombre solo que este se lee un espacio despues de nombre
    float valor = parseValor(partes[2]);
    //crea la variable y la hace valida 
    variables.put(nombre, valor);
    
    //comando color para el color de lo que se dibuje rect circle ect
  } else if(comando.equals("color")){
    //un espacio luego de color se introduce el valor de rojo
    float r = parseValor(partes[1]);
    //un espacio luego de rojo lee valor para verde
    float g = parseValor(partes[2]);
    //luego de azul lee el valor para azul
    float b = parseValor(partes[3]);
    fill(r, g, b);
  } else if(comando.equals("circle")){
    float x = parseValor(partes[1]);
    float y = parseValor(partes[2]);
    float d = parseValor(partes[3]);
    ellipse(x, y, d, d);
  } else if(comando.equals("rect")){
    float x = parseValor(partes[1]);
    float y = parseValor(partes[2]);
    float w = parseValor(partes[3]);
    float h = parseValor(partes[4]);
    rect(x, y, w, h);
  } else if(comando.equals("random")){
    String nombre = partes[1];
    float min = parseValor(partes[2]);
    float max = parseValor(partes[3]);
    float valor = random(min, max);
    variables.put(nombre, valor);
  }else if (comando.equals("text")){
    String contenido = partes[1];
    float x = parseValor(partes[2]);//
    float y = parseValor(partes[3]);
    
    text(variables.containsKey(contenido) ? str(variables.get(contenido)) : contenido, x, y);
  }else{
    println("Pendejo no sabe ni hacer su propio codigo " + comando);
  }
 }

float parseValor(String token){
  if(variables.containsKey(token)){
    return variables.get(token);
  } else {
    return float(token);
  }
}
