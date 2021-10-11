//
//  PriorityView.swift
//  App06-TODO-Firebase
//
//  Created by Alumno on 11/10/21.
//

import SwiftUI

struct PriorityView: View {
    
    @StateObject var taskModel: TaskModel
    @Binding var task : Task
    
    var body: some View {
        VStack{
            Text(priorityName(task.priority_id))
            HStack(spacing: 10){
                Spacer()
                ForEach(taskModel.priorities){ priority in
                    
                    Image(systemName: priority.image)
                        .resizable()
                        .frame(width:60, height:60)
                        .opacity(priority.priority_id == task.priority_id ? 0.0 : 1.0)
                        .onTapGesture {
                            print(priority.priority)
                            task.priority_id = priority.priority_id
                        }
                }
                Spacer()
            }
        }
    }
    
    func priorityName(_ priority_id:String)->String{
        if let index = taskModel.priorities.firstIndex(where: {
            $0.priority_id == priority_id
        }){
            return taskModel.priorities[index].priority
        }
        return ""

    }
}

struct PriorityView_Previews: PreviewProvider {
    
    @State static var task = Task(task: "Tarea 3", category_id: "03", priority_id: "03", is_completed: false, date_created: Date(), due_date: Date())
    
    static var previews: some View {
        PriorityView(taskModel: TaskModel(), task: $task)
    }
}
