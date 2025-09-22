object tito {
    var cantidad = 0
    var bebida = cianuro
    method peso() = 70
    method inerciaBase() = 490
    method consumir(unaCantidad,unaBebida) {
        bebida = unaBebida
        cantidad = unaCantidad
    }
    method bebida() = bebida

    method velocidad() {
        return bebida.rendimiento(cantidad)
        * self.inerciaBase() / self.peso()
    }
}

object wisky {
    method rendimiento(cantidad) = 0.9 ** cantidad
}
object cianuro {
    method rendimiento(cantidad) = 0
}

object terere {
    method rendimiento(cantidad) {
        return 1.max(cantidad * 0.1)
        //tambien (cantidad * 0.1).max(1)
    }
}

object licuado{
    //nutrientes es una referencia y la lista es el objeto
    //si le pongo const a nutrientes, hago que nunca cambie la referencia de lista, siempre va a apuntar a la misma lista
    const nutrientes = []
    method agregarNutrientes(valorDelNutriente){
        nutrientes.add(valorDelNutriente)
    }
    method nutrientes(){
        return nutrientes
    }
    method rendimiento(cantidad){
        //la cantidad de litros tomados por la suma de los nutrientes
        return cantidad * nutrientes.sum()
    }
}

object aguaSaborizada{
    const composicion = [agua]
    method saborizar(bebida){
        //hago esto para que el agua saborizada solo quede con el agua y la bebida que le agregue, no se van a acumular las bebidas agregadas
        composicion.clear()
        composicion.add(agua)
        composicion.add(bebida)
    }
    method rendimiento(cantidad){
        //el rendimiento es 1/4 de la bebida agregada + el rendimiento del agua--> rendimiento de la bebida * 0.25 
        // composicion.first().rendimiento(cantidad) -> al primer elemento de la composicion le pido su rendimiento
        return agua.rendimiento(cantidad) + composicion.last().rendimiento(cantidad) * 0.25
    }
}

object agua{
    method rendimiento(cantidad){
        return 1
    }
}

object coctel{
    //el coctel tiene una lista de bebidas
    const bebidas = []
    method agregarBebida(unaBebida){
        bebidas.add(unaBebida)
    }
    method rendimiento(cantidad){
        //no puedo sumar porque estoy haciendo una suma de objetos, no de numeros
        //para poder sumar debo meter un closure dentro de la lista, para eso debo transformar cada elemento en un numero
        // por cada elemento de la lista bebidas le voy a pedir el rendimiento, es un transformer que transforma cada elemento de la lista bebidas en numeros(rendimiento)
        //bebida --> se le llama asi a cada elemento (recorrido)
        //return bebidas.sum({bebida => bebida.rendimiento(cantidad)})
        //el 1 es el valor inicial por el que se empieza a multiplicar
        return bebidas.fold(1,{acum,bebida => bebida.rendimiento(cantidad)* acum})
    }
}