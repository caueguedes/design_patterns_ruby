class VideoFile
end

class OggCompressionCodec
end

class MPEG4CompressionCodec
end

class CodecFactory
end

class BitrateReader
  def self.read(file_name, source_codec)
    print "Reading #{file_name} with #{source_codec}"
  end

  def self.convert(file_name, destination_codec)
    print "Converting file: #{file_name} with #{destination_codec}"
  end
end

class AudioMixer
  def fix(file)
    "File fixed: #{file}"
  end
end

class VideoConverter
  def convert(filename, format)
    file = VideoFile.new
    source_codec = new CodecFactory.extract(file)
    if format == "mp4"
      destination_codec = MPEG4CompressionCodec.new
    else
      destination_codec = OggCompressionCodec.new
    end

    buffer = BitrateReader.read(filename, source_codec)
    result = BitrateReader.convert(buffer, destination_codec)
    result = AudioMixer.new().fix(result)
    File.new(result)
  end
end

if $PROGRAM_NAME == __FILE__
  convertor = VideoConverter.new
  mp4 = convertor.convert("funny-cats-video.ogg", "mp4")
  mp4.save
end