package org.uqbar.arena.examples.materias.dummyData

import org.uqbar.arena.examples.materias.domain.Carrera
import org.uqbar.arena.examples.materias.domain.Materia
import org.uqbar.arena.examples.materias.domain.Nota
import org.uqbar.arena.examples.materias.domain.Ubicacion

/**
 * Esta clase es simplemente un utils para crear objetos tontos
 * que sirva de ejemplo para mostrar en las ventanas.
 * 
 * NO es ningun patron, NO es una practica recomendada, pero 
 * cuando queremos mostrar un ejemplo nos interesa que tenga datos.
 * 
 * Es solo UNA forma de crearlos.
 * 
 */
class DummyData {
	def crearCarreraDummy(){
		new Carrera => [
			agregarMateria(crearMateria("Matematica Discreta"))
			agregarMateria(crearMateria("Algoritmos"))
			agregarMateria(crearMateria("Análisis I")) 
		]
	}
	
	def Materia crearMateria(String nombreDeLaMateria){
		new Materia() => [
			nombreMateria = nombreDeLaMateria
			anioCursada = 2014
			profesor = '''Jose «nombreDeLaMateria»'''
			ubicacion = Ubicacion.PrimerCuatrimestre
			agregarNota(new Nota => [
				descripcion = "parcial"
			])
			agregarNota(new Nota => [
				descripcion = "tp"
			])
		]
	}
	
}