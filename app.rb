require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/volunteer')
require('./lib/project')
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker_test"})

get("/") do
  @projects = Project.all()
  erb(:index)
end

post("/") do
  title = params.fetch("title")
  project = Project.new({:title => title, :id => nil})
  project.save
  @projects = Project.all()
  erb(:index)
end

get("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  @volunteers = @project.volunteers
  erb(:project)
end

get("/projects/:id/edit") do
  @project =  Project.find(params.fetch("id").to_i())
  erb(:project_edit)
end

patch("/projects/:id") do
  title = params.fetch("title")
  @project = Project.find(params.fetch("id").to_i())
  @project.update({:title => title})
  @volunteers = @project.volunteers
  erb(:project)
end

delete("/:id") do
  @project = Project.find(params.fetch("id").to_i)
  @project.delete
  @projects = Project.all
  erb(:index)
end

post("/projects/:id") do
  name = params.fetch("name")
  project_id = params.fetch("project_id").to_i()
  # what does this do again? Why not 'params.fetch("id").to_i'?
  @project = Project.find(project_id)
  volunteer = Volunteer.new({:name => name, :id => nil, :project_id => project_id})
  volunteer.save()
  @volunteers = @project.volunteers
  erb(:project)
end

# patch("/volunteers/:id") do
#   name = params.fetch("name")
#   @volunteer = Volunteer.find(params.fetch("id").to_i())
#   @volunteer.update({:name => name})
#   erb(:project)
# end
#
# get("/volunteers/:id/edit") do
#   @volunteer = Volunteer.find(params.fetch("id").to_i())
#   erb(:volunteer_edit)
# end
