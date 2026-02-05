class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Allow Ransack (used by ActiveAdmin) to search all model attributes
  # by default so we don't need to declare `ransackable_attributes` in
  # every model.
  def self.ransackable_attributes(auth_object = nil)
    (column_names + _ransackers.keys.map(&:to_s)).map(&:to_s).uniq
  end

  def self.ransackable_associations(auth_object = nil)
    reflect_on_all_associations.map(&:name).map(&:to_s)
  end

  def self.ransackable_scopes(auth_object = nil)
    []
  end
end
