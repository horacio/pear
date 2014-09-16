module Pear
  class PairingSession
    attr_reader :participants, :runner

    def initialize(participants:,
                   configuration: Pear::Configuration.new,
                   runner: Pear::SystemRunner.new)
      @configuration = configuration
      @runner = runner

      set_session_participants(participants)
    end

    def configure_repository
      if repository_already_configured?
        abort('Already pairing! Run `pear -c` to start over.')
      else
        runner.run("git config --add user.name \'#{git_user_name}\'")
        runner.run("git config --add user.email \'#{git_user_email}\'")
      end
    end

    def git_user_name
      to_sentence(session_participants_names)
    end

    def git_user_email
      to_email(participants)
    end

    private

    def set_session_participants(participants)
      raise ArgumentError, 'Participants must be registered' \
        unless participants.all? { |p| @configuration.authors.key?(p) }
      @participants = participants
    end

    def repository_already_configured?
      runner.run("git config --get-all user.name").split(/\n/).any? do |name|
        name == git_user_name
      end
    end

    def session_participants_names
      participants.map { |p| @configuration.authors[p] }
    end

    def to_sentence(full_names)
      last_name = full_names.pop
      [full_names.join(', '), last_name].join(' and ')
    end

    def to_email(initials)
      team, domain = @configuration.email.split('@')
      "#{team}+#{initials.join('-')}@#{domain}"
    end
  end
end
