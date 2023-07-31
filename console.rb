#!/usr/bin/env ruby
require 'json'
require 'uri'
require 'net/http'
require 'highline'
require 'httparty'

# uri = 'https://api.spacetraders.io/v2/' + input

module TradeConsole
    def self.handle_cmds(input) #handle user input
        @input = input
        @cmds = ['help', 'balance', 'location']
        if @cmds.include? @input
            self.public_send(@input)
        else
            puts "Bad input."
        end
    end

    def self.shell #create interactive shell to get user input and provide data
        cli = HighLine.new
        input = cli.ask "> "
        handle_cmds(input)
        shell()
    end

    def self.help
        puts @cmds
    end

    def self.balance
        puts "A million billion dollars"
    end

    def self.location
        puts "A galaxy far, far away"
    end
end

TradeConsole.shell