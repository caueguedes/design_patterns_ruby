class DataSource
  def write_data(data)
    raise NoMethodError, "#{self.class}, has not implemented method '#{__method__}'"
  end

  def read_data
    raise NoMethodError, "#{self.class}, has not implemented method '#{__method__}'"
  end
end

class FileDataSource < DataSource
  def initialize(filename)
    @filename = filename
  end

  def read_data
    "Reading data from file #{@filename}"
  end

  def write_data(data)
    puts "Writing #{data} from file #{@filename}"
  end
end

class DataSourceDecorator < FileDataSource
  attr_accessor :wrappee

  def initialize(wrappee)
    @wrappee = wrappee
  end

  def read_data
    @wrappee.read_data
  end

  def write_data(data)
    @wrappee.write_data(data)
  end
end

class EncryptionDecorator < DataSourceDecorator
  def read_data
    # 1. Get data from the wrappee's readData method.
    # 2. Try to decrypt it if it's encrypted.
    # 3. Return the result.
    data = "Decrypted Data (#{@wrappee.read_data})"
    data
  end

  def write_data(data)
    # 1. Encrypt passed data.
    # 2. Pass encrypted data to the wrappee's writeData method.
    data = "Encrypted Data #{data}"
    @wrappee.write_data(data)
  end
end

class CompressionDecorator < DataSourceDecorator
  def read_data
    data = "Decompressed data (#{@wrappee.read_data})"
    data
  end

  def write_data(data)
    data = "Compressed Data #{data}"
    @wrappee.write_data(data)
  end
end


if $PROGRAM_NAME == __FILE__
  #  DUMB USAGE
  source = FileDataSource.new('somefile.dat')
  source.write_data('Salary Records')

  puts "\n"

  source = CompressionDecorator.new(source)
  source.write_data('Salary Records')

  puts "\n"

  source = EncryptionDecorator.new(source)
  source.write_data('Salary Records')
end

puts "\n"

if $PROGRAM_NAME == __FILE__
  # Client code that uses an external data source.
  class SalaryManager
    attr_accessor :source

    def initialize(source)
      @source = source
    end

    def load
      source.read_data
    end

    def save(salary_records)
      source.write_data(salary_records)
    end
  end

  enabled_encryption = true
  enabled_compression = true

  source = FileDataSource.new('salary.dat')
  source = EncryptionDecorator.new(source) if enabled_encryption
  source = CompressionDecorator.new(source) if enabled_compression

  logger = SalaryManager.new(source)
  print 'Reading data: '
  puts salary = logger.load
end