//
//  TaskDetailView.swift
//  App06
//
//  Created by Alumno on 07/10/21.
//

import SwiftUI

struct TaskDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var taskModel: TaskModel
    @State var task: Task
    var mode: Mode
    @State var showError: Bool = false
    
    var dateFormat: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MMM/dd"
        return formatter
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Datos Generales")) {
                    TextField("Tarea", text: $task.task).font(.title).textFieldStyle(RoundedBorderTextFieldStyle())
                    Toggle("Tarea completada", isOn: $task.is_completed)
                        .font(.title)
                }
                Section(header: Text("Categoria")) {
                    CategoryView(taskModel: taskModel, task: $task)
                }
                Section(header: Text("Prioridad")) {
                    PriorityView(taskModel: taskModel, task: $task)
                }
                Section(header: Text("Fecha de entrega")) {
                    DatePicker(selection: $task.due_date, displayedComponents: .date){
                        Text("\(dateFormat.string(from: task.due_date))")
                            .font(.title)
                    }
                }
            }
            Spacer()
            Button {
                if task.task != ""{
                    if mode == .add {
                        addTask()
                    }else{
                        editTask()
                    }
                }else{
                    showError.toggle()
                }
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack{
                    Image(systemName: mode == .add ? "square.and.arrow.down":"pencil.circle")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text(mode == .add ? "Agregar":"Editar")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                .padding()
                .cornerRadius(40)
                .clipShape(RoundedRectangle(cornerRadius:20))
                .background(Color.green)
                
            }
        }
        .onAppear{
            print(Int(task.due_date - Date())/86400)
        }
        .alert(isPresented: $showError){
            Alert(title: Text("Error en la tarea"), message: Text("Falta capturar la tarea"), dismissButton: .default(
                    Text("VA!")
            ))
        }
    }
    
    func addTask() {
        
        
        
        taskModel.addData(task: task)
        
    }
    
    func editTask(){
        
        taskModel.updateData(task: task)
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        TaskDetailView(taskModel: TaskModel(), task: Task(task: "Tarea 3", category_id: "03", priority_id: "03", is_completed: false, date_created: Date(), due_date: Date()), mode: .add)
    }
}
