# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper.rb"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

def create_file(filename, mode='w')
  @file = File.new(File.dirname(__FILE__) + "/fixtures/#{filename}", mode)
end

def close
  @file.close
  @file = @file.path
end

def open_file(filename, mode='r')
  @file = File.open(File.dirname(__FILE__) + "/fixtures/#{filename}", mode)
end

def write_file(filename, data, mode='wb')
  file = create_file(filename, mode)
  file.write(data)
  file.flush
end

def file_or_path(file)
  file.is_a?(File) ? file.path : file
end

def delete_file
  File.delete file_or_path(@file)
end

def it_should_have_an_extension_of(ext)
  it "should have an extension of #{ext}" do
    File.extname(file_or_path(@file)).should == ".#{ext}"
  end
end

def it_should_have_a_mime_type_of(mimetype)
  it "should have a mime type of #{mimetype}" do
    File.mime_type(@file).should == mimetype
  end
end

module ActionDispatch
  module Http
    module UploadedFile
    end
  end
end
