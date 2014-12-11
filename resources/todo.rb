class Todo
  class List < Sequel::Model(:todo)
  end
  
  def self.init
    @list = List.all
  end
  
  def self.persist
    DB.transaction do
	    @list.select(&:modified?).each(&:save)
	  end
  end
  
  def self.newTask(user, task)
    user = user.downcase
	  listItem = @list.find { |l| l.assignedTo == user && l.task == task }
	  unless listItem
	    listItem = List.new :assignedTo => user, :task => task, :completed => 0
	    @list << listItem
	    return "created"
	  end
	  return "already exists"
  end
  
  def self.markCompleted(user, task)
	  user = user.downcase
	  listItem = @list.find { |l| l.assignedTo == user && l.task == task }
	  listitem.completed = 1 if listItem != nil
  end
  
  def self.retrieveTasks(user)
    user = user.downcase
	  return @list if user.downcase == "all"
	  tasks = @list.select { |l| l.assignedTo == user && l.completed == 0}
	  return tasks
  end
end