PEAR(1) -- pair-programming tool for Git

SYNOPSIS

    pear -i, --init
    pear -s, --start-session [initials ...]
    pear -c, --clean

DESCRIPTION

    Pear helps you set pair-programming sessions with your co-workers.

EXAMPLES

    pear --init
    pear --start-session hb,np
    pear --clean

OPTIONS

    -i, --init
          This command initializes Pear in your working directory (that must
          be a Git repository), writing a sample configuration file named
          `.pear.yml` on it. Of course, you can provide this configuration
          file manually and skip this command.

    -s, --start-session [initials ...]
          This command starts the pair-programming session setting your
          `user.name` and `user.email` Git configuration variables to
          display properly all collaborators working on subsequent commits.

          On the latest version, you must provide a list of registered
          authors initials separated by commas. See EXAMPLES to check out
          how this works.

    -c, --clean
          This commands removes the `user` section added by Pear from your
          local Git repository configuration. It doesn't remove any global
          configuration. Please, remember to re-set your local Git repository
          configuration if you had one before running Pear.

HISTORY

    I wanted to design and build a tool that would help me do what I found
    most exciting to do while working in teams: pair programming. So I started
    pronouncing 'pair programming' a lot, specially 'pair'. Like, /peə(r)/.

    Well, that's pretty much it.
