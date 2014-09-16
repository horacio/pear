require 'spec_helper'

describe Pear do
  before do
    allow(File).to receive(:open).and_return(<<-config)
email: team@example.com
authors:
  - hb Horacio Bertorello
  - mp Markus Persson
    config
  end

  describe Pear::Configuration do
    subject(:configuration) { Pear::Configuration.new }

    describe '#configuration' do
      it 'contains an Hash of registered authors' do
        expect(configuration.authors).to \
          match('hb' => 'Horacio Bertorello', 'mp' => 'Markus Persson')
      end

      it 'contains a custom team email address' do
        expect(configuration.email).to be_a(String)
      end
    end
  end

  describe Pear::PairingSession do
    describe '.new' do
      it 'fails without a list of initials from registered authors' do
        expect { Pear::PairingSession.new(participants: %w(mm sw)) }.to \
          raise_error(ArgumentError, 'Participants must be registered')
      end
    end

    context 'valid pairing session' do
      subject(:session) do
        Pear::PairingSession.new(participants: %w(hb mp))
      end

      describe '#git_user_name' do
        it 'returns a compound user name for the participants' do
          expect(session.git_user_name).to \
            eq('Horacio Bertorello and Markus Persson')
        end
      end

      describe '#git_user_email' do
        it 'returns a compound user email addres for the participants' do
          expect(session.git_user_email).to \
            eq('team+hb-mp@example.com')
        end
      end

      describe '#configure_repository' do
        subject(:session) do
          Pear::PairingSession.new(
            participants: %w(hb mp),
            runner: instance_double('Pear::SystemRunner')
          )
        end

        it 'configures the repository for a pairing session' do
          expect(session.runner).to receive(:run)
            .with("git config --get-all user.name")
            .and_return("Horacio Bertorello\n")

          expect(session.runner).to receive(:run).with \
            "git config --add user.name 'Horacio Bertorello and Markus Persson'"

          expect(session.runner).to receive(:run).with \
            "git config --add user.email 'team+hb-mp@example.com'"

          session.configure_repository
        end
      end
    end
  end
end
