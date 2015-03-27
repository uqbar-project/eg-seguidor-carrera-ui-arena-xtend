package org.uqbar.arena.examples.materias.view

import org.uqbar.arena.Application
import org.uqbar.arena.examples.materias.domain.appModel.SeguidorDeCarreraAppModel
import org.uqbar.arena.examples.materias.dummyData.DummyData
import org.uqbar.arena.examples.materias.view.seguidor.fancy.SeguidorDeCarreraComponentizadoWindow

class SeguidorDeCarreraApplication extends Application {
	
	override protected createMainWindow() {
		var model = new SeguidorDeCarreraAppModel
		model.carrera = new DummyData().crearCarreraDummy
		model.materiaSeleccionada = model.carrera.materias.get(0)
		new SeguidorDeCarreraComponentizadoWindow(this, model) 
	}
	
	def static void main(String[] args) {
		new SeguidorDeCarreraApplication().start()
	}
	
}