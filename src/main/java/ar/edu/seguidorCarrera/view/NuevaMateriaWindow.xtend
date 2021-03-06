package ar.edu.seguidorCarrera.view

import ar.edu.seguidorCarrera.appModel.CrearMateriaAppModel
import ar.edu.seguidorCarrera.domain.Carrera
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class NuevaMateriaWindow extends Dialog<CrearMateriaAppModel> {
	
	new(WindowOwner owner, Carrera model) {
		super(owner, new CrearMateriaAppModel(model))
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "Nueva Materia"
		mainPanel.layout = new VerticalLayout 
		
		new Label(mainPanel).text = "Nombre:"
		new TextBox(mainPanel) => [
			value <=> "materia.nombreMateria"
			width = 200
		]
		new Button(mainPanel)=>[
			caption = "Aceptar"
			onClick [ |
				this.modelObject.agregarMateria
				this.close
			]
		]
	}
	
}