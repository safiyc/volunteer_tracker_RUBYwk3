class Volunteer
  attr_reader(:name, :id, :project_id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @id = attributes.fetch(:project_id)
  end
end
