require_relative 'helpers/require'
Require.require_all('../data')
Require.require_all('../lib')

Atm.new(Prompter.new).init
