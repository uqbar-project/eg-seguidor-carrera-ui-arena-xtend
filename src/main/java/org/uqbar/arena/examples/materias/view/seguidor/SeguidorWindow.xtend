package org.uqbar.arena.examples.materias.view.seguidor

import java.text.SimpleDateFormat
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.examples.materias.domain.Materia
import org.uqbar.arena.examples.materias.domain.Nota
import org.uqbar.arena.examples.materias.domain.appModel.SeguidorDeCarreraAppModel
import org.uqbar.arena.examples.materias.view.CrearNotaWindow
import org.uqbar.arena.examples.materias.view.EditarNotaWindow
import org.uqbar.arena.examples.materias.view.NuevaMateriaWindow
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class SeguidorWindow extends SimpleWindow<SeguidorDeCarreraAppModel> {

	new(WindowOwner parent, SeguidorDeCarreraAppModel model) {
		super(parent, model)
	}

	override protected addActions(Panel actionsPanel) {
		//no queremos usar este template default
	}

	override protected createFormPanel(Panel mainPanel) {
		//no queremos usar este template default
	} 

	override createMainTemplate(Panel mainPanel) {
		this.title = "Seguidor de carrera"

		new Label(mainPanel).text = "Seguidor de Carrera"

		this.crearListadoDeMaterias(mainPanel)
		this.crearEdicionDeMateriaSeleccionada(mainPanel)
	}

	def crearListadoDeMaterias(Panel owner) {
		new Label(owner).text = "Materias"
		new List<Materia>(owner)=>[
			bindValueToProperty("materiaSeleccionada")
			bindItemsToProperty("carrera.materias").adapter = new PropertyAdapter(Materia, "nombreMateria")
		]
		new Button(owner) =>[
			caption = "Nueva Materia"
			onClick = [ | new NuevaMateriaWindow(this, this.modelObject.carrera).open ]
		] 
	}

	def crearEdicionDeMateriaSeleccionada(Panel owner) {
		new Label(owner).bindValueToProperty("materiaSeleccionada.nombreMateria")
		
		new Label(owner).text="Aprobo:"
		new CheckBox(owner).bindValueToProperty("materiaSeleccionada.estaAprobada")
		
		new Label(owner).text="Año de cursada:"
		new TextBox(owner).bindValueToProperty("materiaSeleccionada.anioCursada")
		
		new Label(owner).text="Profesor de cursada:"
		new TextBox(owner).bindValueToProperty("materiaSeleccionada.profesor")
		
		new Label(owner).text = "Ubicación:"
		new Selector(owner) => [
			bindItemsToProperty("ubicacionesPosibles")
			bindValueToProperty("materiaSeleccionada.ubicacion")
		]
		
		new Label(owner).text = "Notas de Cursada"
		var tablaDeNotas = new Table<Nota>(owner, Nota)
		tablaDeNotas.bindItemsToProperty("materiaSeleccionada.notas")
		tablaDeNotas.bindValueToProperty("notaSeleccionada")
		
		new Column(tablaDeNotas)=>[
			title = "Fecha"
			bindContentsToTransformer([ nota | new SimpleDateFormat("dd/MM/YYYY").format(nota.fecha)])
		]
		
		new Column<Nota>(tablaDeNotas)=>[
			title = "Descripción"
			bindContentsToProperty("descripcion")
		]

		new Column(tablaDeNotas) =>[
			title = "Aprobado"
//			bindContentsToTransformer([ nota | if(nota.estaAprobada) "Si" else "No"])
			bindContentsToProperty("estaAprobada")
		]
		
		new Button(owner)=>[
			caption="Editar"
			onClick = [|new EditarNotaWindow(this, this.modelObject.notaSeleccionada).open]
		]
			
		new Button(owner)=>[
			caption="+"
			onClick = [| 
				val nota = this.modelObject.nuevaNota
				new CrearNotaWindow(this, nota).open
			]
		]
		
		new Button(owner)=>[
			caption="-"
			onClick = [| 
				this.modelObject.eliminarNota
			]
		]
	}
	
}
