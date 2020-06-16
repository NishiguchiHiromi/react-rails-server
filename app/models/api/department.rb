class Api::Department
  attr_accessor :ids, :saved_ids

  def initialize
    @saved_ids = []
    @ids = Department.all.pluck(:id)
  end

  def save!(args)
    ActiveRecord::Base.transaction do
      args.each do |dept|
        save_department(dept)
      end
      delete_departments
    end
  end

  private

  def save_department(dept, parent_id: nil)
    id = dept[:id].is_a?(Numeric) ? dept[:id] : nil
    department = ::Department.find_or_initialize_by(id: id)
    department.update!(dept.except(:id, :children).merge(parent_id: parent_id))
    saved_ids << department.id

    Array(dept[:children]).each do |d|
      save_department(d, parent_id: department.id)
    end
  end

  def delete_departments
    delete_ids = ids - saved_ids
    ::Department.where(id: delete_ids).destroy_all
  end
end