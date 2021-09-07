/** First Wollok example */
import wollok.game.*


object pantalla {
	
	
	method iniciar() {

		game.title("explosiones")
		game.height(10)		
		game.addVisual(wollok)
		game.addVisual(cachito)
		game.addVisual(extra)
		keyboard.enter().onPressDo(  {wollok.explotar()} )
		keyboard.right().onPressDo(  {cachito.derecha()} )
		keyboard.left().onPressDo(  {cachito.izquierda()} )
		keyboard.space().onPressDo(  {cachito.pasaronCosas(100)} )
		
		game.onCollideDo(cachito, {obstaculo  =>  obstaculo.explotar()} )
		
		
		game.start()
		
	}
}


object extra{
	
	
	method image() { return "jugadorDerecha.png"}
	method explotar(){
		cachito.pasaronCosas(100)
		game.schedule(1000, {cachito.izquierda()})		
	}
	
	method position() = game.at(4,5)
}

object wollok {
	
	var image = "bomba.png"
	
	method howAreYou() {
		return 'I am Wolloktastic!'
	}
	method position() {
		return game.center()
	}
	
	method image() {
		return image
	}
	method explotar() {
		image = "explosion.png"
		game.schedule(2000,{self.regenerarse()})
	}
	
	method borrar() {
		game.removeVisual(self)
	}
	
	method saludar(){
		game.say(self , self.howAreYou())
	}
	method regenerarse() {
		image = "bomba.png"
	}
}

object cachito{
	var position = game.at(2,5)
	var vida = 100
	method position() = position
	
	method image() {
		return "enemigo" + (if(vida > 10) "Vivo" else "Muerto") + ".png"
	}
    method pasaronCosas(cosas){
    	vida -= cosas
    }
    
    method derecha(){
    	position = position.right(1)
    }
    method izquierda(){
    	position = position.left(1)
    }
    method moverse(){
    	game.onTick(1000,"derecha",{self.derecha()})
    }
    method detenerse(){
    	game.removeTickEvent("derecha")
    	position = game.at(1,1)
    }
}
