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

patch("/projects/:id") do
  title = params.fetch("title")
  @project = Project.find(params.fetch("id").to_i())
  @project.update({:title => title})
  @volunteers = @project.volunteers
  erb(:project)
end

get("/projects/:id/edit") do
  @project =  Project.find(params.fetch("id").to_i())
  erb(:project_edit)
end

delete("/:id") do
  @project = Project.find(params.fetch("id").to_i)
  @project.delete
  @projects = Project.all
  erb(:index)
end
