
require "active_support"

require "tab_log/version"
require "logger"

class TabLog
  class TabLogDevice < Logger::LogDevice
    def add_log_header(file)
    end
  end

  attr_reader :id

  def new_record?
    true
  end

  def self.path
    "#{RAILS_ROOT}/log/#{name.tableize}.log"
  end

  def self.size
    File.readlines(path).size rescue 0
  end

  def self.count
    size
  end

  def self.last
    Array(open(path).lines).last
  end

  def initialize(values = {})
    @id = rand 2 ** 32

    @values = {}
    @values = values.symbolize_keys if values

    @logger = Logger.new(TabLogDevice.new(self.class.path, :shift_age => 0, :shift_size => 1048576))
  end

  def method_missing(method_id, *args)
    field_id = method_id.to_s.gsub(/=$|\?$/, "").to_sym

    if fields.include? field_id
      return @values[field_id] = args.first if method_id.to_s =~ (/=$/)
      return @values[field_id]
    end

    super
  end

  def default_values
    []
  end

  def escape_value(value)
    value.to_s.gsub(/\n/, "\\n").gsub(/\r/, "\\r").gsub(/\t/, "\\t")
  end

  def save
    before_save

    record = default_values

    fields.each do |field|
      record << escape_value(@values[field])
    end
    
    @logger << record.join("\t")
    @logger << "\n"

    after_save
  end

  def fields
    {}
  end

  def before_save
  end

  def after_save
  end

  protected

  def [](key)
    @values[key]
  end

  def []=(key, value)
    @values[key] = value
  end
end

