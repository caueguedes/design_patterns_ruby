class Database
  @instance = new

  private_class_method :new

  def self.instance
    @instance
  end

  def query(query_string)
    puts "Searching in database for : #{query_string}"
  end
end

if $PROGRAM_NAME == __FILE__
  database = Database.instance
  database.query('SELECT * FROM ...')

  database2 = Database.instance
  database2.query('SELECT * FROM ...')

  puts database.equal?(database2)
end