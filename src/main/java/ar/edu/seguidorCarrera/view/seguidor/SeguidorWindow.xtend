package ar.edu.seguidorCarrera.view.seguidor

import ar.edu.seguidorCarrera.appModel.SeguidorDeCarreraAppModel
import ar.edu.seguidorCarrera.domain.Materia
import ar.edu.seguidorCarrera.domain.Nota
import ar.edu.seguidorCarrera.view.CrearNotaWindow
import ar.edu.seguidorCarrera.view.EditarNotaWindow
import ar.edu.seguidorCarrera.view.NuevaMateriaWindow
import java.text.SimpleDateFormat
import org.uqbar.arena.bindings.PropertyAdapter
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

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

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
			value <=> "materiaSeleccionada"
			(items <=> "carrera.materias").adapter = new PropertyAdapter(Materia, "nombreMateria")
		]
		new Button(owner) =>[
			caption = "Nueva Materia"
			onClick [ | new NuevaMateriaWindow(this, this.modelObject.carrera).open ]
		] 
	}

	def crearEdicionDeMateriaSeleccionada(Panel owner) {
		new Label(owner).value <=> "materiaSeleccionada.nombreMateria"
		
		new Label(owner).text = "Aprobo:"
		new CheckBox(owner).value <=> "materiaSeleccionada.estaAprobada"
		
		new Label(owner).text="Año de cursada:"
		new TextBox(owner).value <=> "materiaSeleccionada.anioCursada"
		
		new Label(owner).text = "Profesor de cursada:"
		new TextBox(owner).value <=> "materiaSeleccionada.profesor"
		
		new Label(owner).text = "Ubicación:"
		new Selector(owner) => [
			items <=> "ubicacionesPosibles"
			value <=> "materiaSeleccionada.ubicacion"
		]
		
		new Label(owner).text = "Notas de Cursada"
		val tablaDeNotas = new Table<Nota>(owner, Nota) => [
			items <=> "materiaSeleccionada.notas"
			value <=> "notaSeleccionada"
		]
		
		new Column(tablaDeNotas)=>[
			title = "Fecha"
			bindContentsToProperty("fecha").transformer = [ fecha | new SimpleDateFormat("dd/MM/YYYY").format(fecha)]
		]
		
		new Column<Nota>(tablaDeNotas)=>[
			title = "Descripción"
			bindContentsToProperty("descripcion")
		]

		new Column(tablaDeNotas) =>[
			title = "Aprobado"
			bindContentsToProperty("estaAprobada").transformer = [ estaAprobada | if (estaAprobada) "Si" else "No"]
		]
		
		new Button(owner) => [
			caption = "Editar"
			onClick [|new EditarNotaWindow(this, this.modelObject.notaSeleccionada).open]
		]
			
		new Button(owner)=>[
			caption = "+"
			onClick [| 
				val nota = this.modelObject.nuevaNota
				new CrearNotaWindow(this, nota).open
			]
		]
		
		new Button(owner) => [
			caption="-"
			onClick [| 
				this.modelObject.eliminarNota
			]
		]
	}
	
}
