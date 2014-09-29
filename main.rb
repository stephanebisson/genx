require_relative 'lib/population'

def main
	p = Population.new 20, "il etait une fois..."

	begin 
		p.generation
		puts p.to_s
	end until p.done?

end

main()
