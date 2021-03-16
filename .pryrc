def pbcopy(str)
  IO.popen('pbcopy', 'r+') {|io| io.puts str }
  _pry_.output.puts "--- Copy to ClipBoard ---"
  _pry_.output.puts str
end

Pry.config.commands.command "copy-result", "Last result copy to clipboard" do
  pbcopy _pry_.last_result
end

Pry.config.commands.command "copy-output", "Copy to clipboard" do |str|
  unless str
    str = "#{_pry_.input_ring[-1]}#=> #{_pry_.last_result}\n"
  end
  pbcopy str
end

Pry.config.commands.alias_command 'co', 'copy-output'
Pry.config.commands.alias_command 'cr', 'copy-result'
