PATH_TO_RSPEC_SPEC_FOLDER = 'spec/'
PATH_TO_INTEGRATION_TESTS_FOLDER = 'integration/'
PATH_TO_UNIT_TESTS_FOLDER = 'unit/'

class RakeTaskManager

  attr_accessor :rspec_test_name
  attr_accessor :failed_tests
  attr_accessor :cmd
  attr_accessor :silent
  attr_accessor :tests_counter

  @@failed_tests = Array.new
  @@tests_counter = 0
  @@failed_tests_counter = 0

  def initialize(task_name)
    @silent = ENV['SILENT']
    if @silent.nil? || @silent == 'true'
      @silent = true
    elsif @silent == 'false'
      @silent = false
    end
    @rspec_test_name = task_name.to_s.split('_', 2)[1] + '_spec.rb'
    @@tests_counter += 1
  end

  def generate_and_expand_output
    match_regular_expression = 'Failed examples:'
    match_line_found = false
    @cmd.each_line do |line|
      if !match_line_found
        if line =~ /#{match_regular_expression}/
          match_line_found = true
        end
      else
        unless line == "\n"
          @@failed_tests.push(line)
        end
      end
    end
  end

  # executing rspec test, with cutting stderr application output
  def run
    @rspec_test_name = PATH_TO_RSPEC_SPEC_FOLDER + @rspec_test_name
    @cmd = `rspec #{@rspec_test_name}`
    describe_test(@rspec_test_name, @cmd, $?.exitstatus)
    generate_and_expand_output
  end

  def describe_test(test_name, output, exit_code)
    status = '...OK'
    if exit_code != 0
      status = '...FAILED'
      @@failed_tests_counter += 1
    end
    puts "Running test: #{test_name} " + status
    if !@silent || status == '...FAILED'
      describe_test_output output
    end
  end

  def describe_test_output(output)
    match_regular_expression = 'Finished in'
    lines_counter = 0
    if output.include? match_regular_expression
      output.each_line do |line|
        if line =~ /#{match_regular_expression}/
          break
        end
        lines_counter += 1
      end
      puts output.split("\n")[0..lines_counter-1]
    end
  end
  # creating parameters for rspec test
  # run tests
  # generating output of failed tests
  # removing parameters, test is over
  def run_parametrized(arguments)
    # Strange, but arguments variable is not Hash
    # so it needs to be converted...
    if !Hash.try_convert(arguments).empty?
      arguments.each { |key, value| ENV[key.to_s] = value }
      run
      arguments.each { |key, _| ENV.delete(key.to_s) }
    else
      raise "No arguments provided for #{@rspec_test_name}, fix and try again."
    end
  end

  def run_unit
    @rspec_test_name = PATH_TO_UNIT_TESTS_FOLDER + @rspec_test_name
    run
  end

  def run_unit_parametrized(arguments)
    @rspec_test_name = PATH_TO_UNIT_TESTS_FOLDER + @rspec_test_name
    run_parametrized arguments
  end

  def run_integration
    @rspec_test_name = PATH_TO_INTEGRATION_TESTS_FOLDER + @rspec_test_name
    run
  end

  def run_integration_parametrized(arguments)
    @rspec_test_name = PATH_TO_INTEGRATION_TESTS_FOLDER + @rspec_test_name
    run_parametrized arguments
  end

  def self.get_failed_tests_info
    if @@failed_tests.length == 0
      puts "\nAll tests passed #{@@tests_counter}/#{@@tests_counter}"
      exit 0
    else
      puts "\nFailed tests #{@@failed_tests_counter}/#{@@tests_counter}:"
      @@failed_tests.each { |line| puts line}
      exit 1
    end
  end

end