require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/volunteer')
require('./lib/project')
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker_test"})

# get('/') do
#   @blank_field_error = ""
#   @projects = Project.all
#   erb(:index)
# end
#
# post('/') do
#   title = params["title"]
#   @blank_field_error = ""
#   if (title == "")
#     @blank_field_error = "Please enter a project."
#   else
#     project = Project.new({:title => title, :id => nil}).save
#   end
#   @projects = Project.all
#   erb(:index)
# end

# ------------

get('/') do
  erb(:index)
end

post("/") do
  title= params.fetch("title")
  project = Project.new({:title => title, :id => nil})
  project.save
  erb(:index)
end

get('/') do
  @projects = Project.all()
  erb(:index)
end

get('/:id') do
  @project = Project.find(params.fetch("id").to_i())
  erb(:index)
end

get("/:id/edit") do
  @project = Project.find(params.fetch("id").to_i())
  erb(:project_edit)
end

post("/:id/edit") do
  name = params.fetch("name")
  project_id = params.fetch("project_id").to_i()
  @project = Project.find(project_id)
  @volunteer = Volunteer.new({:name => name, :id => nil, :project_id => project_id})
  @volunteer.save()
  erb(:project_edit)
end

get("/:id/edit") do
  @project =  Project.find(params.fetch("id").to_i())
  erb(:project_edit)
end

patch("/:id") do
  title = params.fetch("title")
  @project = Project.find(params.fetch("id").to_i())
  @project.update({:title => title})
  erb(:volunteer_edit)
end

delete("/:id") do
  @project = Project.find(params.fetch("id").to_i)
  @project.delete
  @projectss = List.all
  erb(:index)
end
