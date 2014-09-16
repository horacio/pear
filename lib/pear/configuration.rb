module Pear
  class Configuration
    CONFIG_FILE = '.pear.yml'

    attr_reader :authors, :email

    def write_sample_configuration
      abort('This doesn\'t look like a Git repository.') \
        unless Dir.exists?('.git')

      abort('Whoa there! A configuration file is already present.') \
        if File.exists?('.pear.yml')

      File.write(CONFIG_FILE, <<-config)
email: team@example.com
authors:
  - ad Alice Doe
  - bd Bob Doe
      config
    end

    def authors
      @authors ||= \
        configuration['authors'].each_with_object({}) do |author_data, hash|
          author = Author.new(author_data)
          hash[author.initials] = author.full_name
      end
    end

    def email
      @email ||= configuration['email']
    end

    private

    def configuration
      @configuration ||= YAML.load(File.open(CONFIG_FILE))
    end
  end

  class Author
    attr_reader :initials, :full_name

    def initialize(author_data)
      @initials, *full_name = author_data.split
      @full_name = full_name.join(' ')
    end
  end
end
