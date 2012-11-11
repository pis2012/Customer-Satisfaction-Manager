class CsmProperty < ActiveRecord::Base
  attr_accessible :id, :name, :value

  validates_uniqueness_of :name
  validates_presence_of :value

  def self.get_property(name,defaultValue)
    property = CsmProperty.find_by_name(name)
    value = defaultValue

    if property
      value = property.value
    end

    value
  end


end
