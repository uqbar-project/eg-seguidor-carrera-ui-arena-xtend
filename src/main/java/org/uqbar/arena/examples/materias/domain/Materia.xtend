package org.uqbar.arena.examples.materias.domain

import java.util.List
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils

@Observable
class Materia {
	@Property
	String nombreMateria
	
	@Property
	Integer anioCursada
	
	@Property
	String profesor 
	
	@Property
	Ubicacion ubicacion
	
	@Property
	Boolean estaAprobada
	
	@Property
	List<Nota> notas
	
	new(){
		notas = newArrayList
		estaAprobada = false
	}
	
	def agregarNota(Nota nota) {
		this.notas.add(nota)
		ObservableUtils.firePropertyChanged(this,"notas", notas)
	}
	
	def eliminarNota(Nota nota) {
		this.notas.remove(nota)
		ObservableUtils.firePropertyChanged(this,"notas", notas)
	}
	
}