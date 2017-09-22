class Volunteer
  attr_reader(:name, :id, :project_id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @project_id = attributes.fetch(:project_id)
  end

  def ==(another_volunteer)
    self.name().==(another_volunteer.name()).&(self.project_id().== (another_volunteer.project_id()))
  end
end
