package ar.edu.seguidorCarrera.view.seguidor.fancy

import ar.edu.seguidorCarrera.appModel.SeguidorDeCarreraAppModel
import ar.edu.seguidorCarrera.domain.Materia
import ar.edu.seguidorCarrera.domain.Nota
import ar.edu.seguidorCarrera.view.CrearNotaWindow
import ar.edu.seguidorCarrera.view.EditarNotaWindow
import ar.edu.seguidorCarrera.view.NuevaMateriaWindow
import java.text.SimpleDateFormat
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
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

class SeguidorDeCarreraWindow extends SimpleWindow<SeguidorDeCarreraAppModel> {

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

		mainPanel.layout = new VerticalLayout 
		//Agregamos el titulo
		new Label(mainPanel) => [
			text = "Seguidor de Carrera"
			fontSize = 20
		]

		//Agregamos el contenido
		val Panel contentPanel = new Panel(mainPanel)
		contentPanel.layout = new ColumnLayout(2)
		this.crearListadoDeMaterias(contentPanel)
		this.crearEdicionDeMateriaSeleccionada(contentPanel)
	}

	def crearListadoDeMaterias(Panel owner) {
		val Panel panelDeListadoDeMaterias = new Panel(owner)
		panelDeListadoDeMaterias.layout = new VerticalLayout

		new Label(panelDeListadoDeMaterias).text = "Materias"
		new List<Materia>(panelDeListadoDeMaterias) => [
				(items <=> "carrera.materias").adapter = new PropertyAdapter(Materia, "nombreMateria")
				height = 150
				width = 130
				value <=> "materiaSeleccionada"
			]
		new Button(panelDeListadoDeMaterias) =>[
			caption = "Nueva Materia"
			onClick [ | new NuevaMateriaWindow(this, this.modelObject.carrera).open ]
		] 
	}

	def crearEdicionDeMateriaSeleccionada(Panel owner) {
		val Panel materiaCompletaPanel = new Panel(owner)
		materiaCompletaPanel.layout = new VerticalLayout

		new Label(materiaCompletaPanel)=>[
			value <=> "materiaSeleccionada.nombreMateria"
			fontSize = 13
		]
		
		val Panel panelDeEdicionDeMateria = new Panel(materiaCompletaPanel)
		panelDeEdicionDeMateria.layout = new ColumnLayout(2)
		
		new Label(panelDeEdicionDeMateria).text = "Aprobo:"
		new CheckBox(panelDeEdicionDeMateria).value <=> "materiaSeleccionada.estaAprobada"
		
		new Label(panelDeEdicionDeMateria).text = "Año de cursada:"
		new TextBox(panelDeEdicionDeMateria) => [
			value <=> "materiaSeleccionada.anioCursada"
			width = 200
		]
		
		new Label(panelDeEdicionDeMateria).text = "Profesor de cursada:"
		new TextBox(panelDeEdicionDeMateria) => [
			value <=> "materiaSeleccionada.profesor"
			width = 200
		]
		
		new Label(panelDeEdicionDeMateria).text = "Ubicación:"
		new Selector(panelDeEdicionDeMateria) => [
			items <=> "ubicacionesPosibles"
			value <=> "materiaSeleccionada.ubicacion"
			width = 200
		]
		
		new Label(panelDeEdicionDeMateria).text = "Notas de Cursada"
		val tablaDeNotas = new Table<Nota>(panelDeEdicionDeMateria, Nota) => [
			items <=> "materiaSeleccionada.notas"
			value <=> "notaSeleccionada"
		]
		
		new Column(tablaDeNotas) =>[
			title = "Fecha"
			bindContentsToProperty("nota").transformer = [ Nota nota | new SimpleDateFormat("dd/MM/YYYY").format(nota.fecha)]
		]
		
		new Column<Nota>(tablaDeNotas)=>[
			bindContentsToProperty("descripcion")
			title = "Descripción"
		]

		new Column(tablaDeNotas) =>[
			title = "Aprobado"
			bindContentsToProperty("estaAprobada").transformer = [ Boolean estaAprobada |  
				if (estaAprobada) "Si" else "No"
			]
		]
		
		val botoneraPanel = new Panel(materiaCompletaPanel)
		botoneraPanel.layout = new HorizontalLayout
		
		new Button(botoneraPanel) => [
			caption = "Editar"
			width = 100
			onClick [|new EditarNotaWindow(this, this.modelObject.notaSeleccionada).open]
		]
			
		new Button(botoneraPanel) => [
			caption = "+"
			width = 100
			onClick [| 
				val nota = this.modelObject.nuevaNota
				new CrearNotaWindow(this, nota).open
			]
		]
		
		new Button(botoneraPanel)=>[
			caption = "-"
			width = 100
			onClick [| 
				this.modelObject.eliminarNota
			]
		]
	}
	
}
