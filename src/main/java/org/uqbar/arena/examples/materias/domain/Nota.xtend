package org.uqbar.arena.examples.materias.domain

import java.util.Date
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils

@Observable
class Nota {
	
	@Property
	String descripcion
	
	@Property
	Date fecha 
	
	@Property
	Boolean estaAprobada
	
	new(){
		fecha = new Date()
		estaAprobada = false
	}
	
	def void setEstaAprobada(Boolean aprobo){
		_estaAprobada = aprobo
		ObservableUtils.firePropertyChanged(this,"estaAprobada", aprobo)
	}
	
	
}