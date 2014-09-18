module Pear
  class Configuration
    CONFIG_FILE = '.pear.yml'

    attr_reader :authors, :email

    def write_sample_configuration
      ensure_git_repository_exists

      safeguard_pre_existing_configuration

      File.write(CONFIG_FILE, sample_configuration)
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

    def sample_configuration
      {
        email: 'team@example.com',
        authors: [
          'ad Alice Doe',
          'bd Bob Doe'
        ]
      }.to_yaml
    end

    def ensure_git_repository_exists
      Dir.exists?('.git') or abort('This doesn\'t look like a Git repository.')
    end

    def safeguard_pre_existing_configuration
      File.exists?('.pear.yml') and abort('Configuration file already exists!')
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
