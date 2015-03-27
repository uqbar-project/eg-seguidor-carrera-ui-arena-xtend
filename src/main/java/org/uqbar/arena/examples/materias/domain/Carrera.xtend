package org.uqbar.arena.examples.materias.domain

import org.uqbar.commons.utils.Observable
import java.util.List
import org.uqbar.commons.model.ObservableUtils

@Observable
class Carrera {
	
	List<Materia> materias
	
	new(){ 
		materias = newArrayList
	}
	
	def agregarMateria(Materia materia){
		this.materias.add(materia)
		ObservableUtils.firePropertyChanged(this,"materias", materias)
	}
	
	def getMaterias(){
		materias
	}
	
}