package ar.edu.seguidorCarrera.view

import ar.edu.seguidorCarrera.appModel.SeguidorDeCarreraAppModel
import ar.edu.seguidorCarrera.dummyData.DummyData
import ar.edu.seguidorCarrera.view.seguidor.fancy.SeguidorDeCarreraComponentizadoWindow
import org.uqbar.arena.Application

class SeguidorDeCarreraApplication extends Application {

	override protected createMainWindow() {
		val model = new SeguidorDeCarreraAppModel => [
			carrera = new DummyData().crearCarreraDummy
//			materiaSeleccionada = carrera.materias.get(0)
		]
		new SeguidorDeCarreraComponentizadoWindow(this, model)
	}

	def static void main(String[] args) {
		new SeguidorDeCarreraApplication().start
	}

}
