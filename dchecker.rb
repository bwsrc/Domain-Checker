#!/usr/bin/env ruby

require 'optparse'

ARGV << '-h' if ARGV.empty?

class DomainChecker
  attr_accessor :outfile

  def initialize
    @outfile = ""
    @file_deleted = false
  end

  def write_result(result)
    if !@outfile.empty?
      if File.exists?(@outfile) && !@file_deleted
        File.delete @outfile
        @file_deleted = true
        file = open(@outfile, 'w')
        file.write("Domain, Status\n")
        file.close
      end
      file = open(@outfile, 'a')
      file.write(result)
      file.close
    end
  end

  def domain_available?(domain)
    output = `whois #{domain}`
    if output.include?("Domain not found") || output.include?("No match for domain")
      return true
    else
      return false
    end
  end

  def check_domain(domain)
    print "#{domain} "
    if domain_available? domain
      puts "[AVAILABLE]"
      write_result "#{domain}, AVAILABLE\n"
    else
      puts "[NOT AVAILABLE]"
      write_result "#{domain}, NOT AVAILABLE\n"
    end
  end

  def check_domain_file(filename)
    file = open(filename, 'r')
    domains = file.readlines.map(&:chomp)
    file.close

    domains.each do |domain|
      check_domain domain
    end
  end
end

dc = DomainChecker.new

OptionParser.new do |opts|
  opts.banner = "Usage: dchecker.rb [options]"

  opts.on_tail("-h", "--help", "Show this help") do
    puts opts
    exit
  end

  opts.on("-cDOMAIN", "--check=DOMAIN", "Check a single domain") do |c|
    dc.check_domain(c)
  end

  opts.on("-fFILENAME", "--file=FILENAME", "Check domains in file") do |f|
    dc.check_domain_file(f)
  end

  opts.on("-oFILENAME", "--outfile=FILENAME", "Save domain check to file. MUST COME BEFORE -f") do |o|
    dc.outfile = o
  end
end.parse!

