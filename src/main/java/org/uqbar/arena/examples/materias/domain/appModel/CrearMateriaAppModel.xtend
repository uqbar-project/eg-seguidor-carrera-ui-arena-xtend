package org.uqbar.arena.examples.materias.domain.appModel

import org.uqbar.commons.utils.Observable
import org.uqbar.arena.examples.materias.domain.Materia
import org.uqbar.arena.examples.materias.domain.Carrera

@Observable
class CrearMateriaAppModel {
	@Property
	Materia materia
	
	Carrera carrera 
	
	new(Carrera carrera){
		this.carrera = carrera
		materia = new Materia
	}
	
	def agregarMateria(){
		carrera.agregarMateria(materia)
	}
	
}