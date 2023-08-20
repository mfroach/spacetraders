#!/usr/bin/env ruby
require 'json'
require 'uri'
require 'highline'
require 'httparty'

# uri = 'https://api.spacetraders.io/v2/' + input

module TradeConsole

    @base_uri = 'https://api.spacetraders.io/v2/'
    token_file = File.open('token.txt')
    @token = token_file.read
    include HTTParty

    def self.handle_cmds(input) #handle user input
        @input = input
        @cmds = ['help', 'balance', 'location', 'contracts', 'quit']
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

    def self.contracts
        sub_uri = '/my/contracts'
        response = HTTParty.get @base_uri << sub_uri, {
            headers: {"Authorization" => "Bearer #{@token}"}
        }
        responseHash = JSON.parse(response.body)
        puts responseHash # clearly i need to learn how JSON works.
    end

    def self.quit
        abort "quitting"
    end
end

TradeConsole.shell