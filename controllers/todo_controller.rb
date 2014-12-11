class TodoController < Rubot::Controller
  command :todo do
    if message.text.split.first == "-new"
	    userIndex = message.text.split.index("-user")
	    taskIndex = message.text.split.index("-task")
        if userIndex && taskIndex
	        user = message.text.split[userIndex + 1]
		      task = message.text.split[(taskIndex + 1)..message.text.split.length - 1].join(' ') if taskIndex > userIndex
		      task = message.text.split[(taskIndex + 1)..(userindex - 1)] if taskIndex < userIndex
	        reply "Task " + Todo.newTask(user, task)
	      else
	        reply "Must specify both -user and -task"
	      end
	    else
	      user = message.from if message.text == ""
	      user = message.text.split.first if message.text.length > 0
	      tasks = Todo.retrieveTasks(user)
	      reply "No tasks assigned to user " + user if tasks.length == 0
	      tasks.each do |task|
		    reply task.assignedTo + " - " + task.task
      end
	  end
  end
  
  on :connect do
    Todo.init
	
	  Scheduler.every "30m" do
	    Todo.persist
	  end
  end
  
  on :quit do
    Todo.persist
  end
end