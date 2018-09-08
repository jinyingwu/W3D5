require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    # byebug
    result = []
    keys = DBConnection.execute2(<<-SQL)

    SELECT
      *
    FROM
      #{self.table_name}
    LIMIT
       0
    SQL
    # byebug
    keys[0].each do |key|
      result << key.parameterize.underscore.to_sym
    end
    @columns = result
    # byebug
  end

  def self.finalize!
    self.columns.each do |name|
      define_method(name) do
        self.attributes[name]
      end

      define_method("#{name}=") do |value|
        self.attributes[name] = value
      end
    end

  end

  def self.table_name=(table_name)
    # byebug
    @table_name = table_name
    # byebug

  end

  def self.table_name
    # byebug

    # @table_name || self.name.underscore.pluralize
    @table_name || self.name.tableize
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})

    # byebug
    params.each_key do |attr_name|
      # byebug
      raise_error "unknown attribute #{attr_name}" unless self.class.columns.include?(attr_name)
    end

  end

  def attributes
    @attributes ||= {}

  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
