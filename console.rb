#!/usr/bin/env ruby

require 'json'
require 'uri'
require 'net/http'
require 'highline'

# uri = 'https://api.spacetraders.io/v2/' + input

module TradeConsole
    def self.handle_cmds(input)
        cmds = ['balance', 'location']
        @input = input
        if input == 'balance'
            print "A million billion dollars"
        end
    end
    def self.shell
        cli = HighLine.new
        input = cli.ask ">"
        handle_cmds(input)
    end
end

TradeConsole.shell