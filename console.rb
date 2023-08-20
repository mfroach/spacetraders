#!/usr/bin/env ruby
require 'json'
require 'uri'
require 'highline'
require 'httparty'

module TradeConsole

    @base_uri = 'https://api.spacetraders.io/v2/'
    token_file = File.open('token.txt')
    @token = token_file.read
    include HTTParty

    def self.request(sub_uri)
        response = HTTParty.get @base_uri << sub_uri, {
            headers: {"Authorization" => "Bearer #{@token}"}
        }
        return response
    end
    def self.handle_cmds(input) #handle user input
        @input = input
        @cmds = ['help', 'balance', 'location', 'contracts', 'quit']
        if @cmds.include? @input
            self.public_send(@input)
        else
            puts "Bad input."
        end
    end

    def self.shell # create interactive shell to get user input and provide data
        cli = HighLine.new
        input = cli.ask "> "
        handle_cmds(input)
        shell() # magic REPL (this is probably bad, do it better)
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

    def self.contracts # check for available contracts
        sub_uri = '/my/contracts'
        responseHash = JSON.parse(request(sub_uri).body) # todo: make an actual parser
        puts responseHash.dig("data", 0, "id")
    end

    def self.quit
        abort "quitting"
    end
end

TradeConsole.shell