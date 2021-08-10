Before do
  $stdin = ->(klass) { klass.new }
end

After do |scenario|
  exception_message(scenario)
end

def exception_message(scenario)
  scene = scenario.failed?
  return unless scene == true

  response = @result.parsed_response
  puts "\n-------------------------------------------- LOG ----------------------------------------------"
  puts "\nREQUEST"
  puts "\n-------"
  puts "\nurl....: #{@result.request.http_method.to_s.gsub('Net::HTTP::', '').upcase} -> #{@result.request.last_uri}"
  puts "\nparams.: #{@result.request.options[:params].to_json}"
  puts "\nheader.: #{@result.request.options[:headers].to_json}"
  puts "\nbody...: \n#{JSON.pretty_generate(JSON.parse(@result.request.options[:body]))}"
  puts "\n--------"
  puts "\nRESPONSE"
  puts "\n--------"
  puts "\ncode.: #{@result.response.code}"
  puts "\nbody.: \n#{response.is_a?(Hash) ? JSON.pretty_generate(response) : JSON.pretty_generate(JSON.parse(response))}"
  puts "\n-------------"
  puts "\nINCONSISTENCY"
  puts "\n-------------"
  puts "\n🔥🔥🔥 #{scenario.exception.message.split('(')[0]}"
end

AfterConfiguration do |config|
  config.on_event(:test_case_finished) do |event|
    puts "\n--------------------------------------------------------------------------------------------------"
    puts 'Results:'
    puts " - Scenario......: #{event.test_case.name}"
    puts " - The results is: #{event.result} 👍🏻"
    puts "--------------------------------------------------------------------------------------------------\n"
  end
end

at_exit do
  ReportBuilder.configure do |config|
    config.input_path = 'report/report.json'
    config.report_path = 'report/report'
    config.report_types = [:html]
    config.report_title = 'FakeRESTApi.Web V1'
    config.color = 'navy blue'
  end
  ReportBuilder.build_report
end
