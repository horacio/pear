module Pear
  class SystemRunner
    def run(command)
      %x(#{command}).strip
    end
  end
end
