require_relative 'individual'

class Population
	attr_reader :gen

	def initialize(size, target)
		@individuals = size.times.map do
			Individual.rand target.size
		end
		@gen = 0
		@target = target
		@size = size
	end

	def generation
		self.sort
		self.mate
		self.sort
		self.purge
		self.age
	end

	def age
		@gen = @gen + 1
	end

	def sort
		@individuals = @individuals.sort{|a, b| a.cost(@target) <=> b.cost(@target) }
	end

	def purge
		@individuals = @individuals.take @size
	end

	def mate
		limit = (@individuals.length / 4).round(0) * 2
		most_fit = @individuals.take limit
		babies = most_fit.each_slice(2).map{|a, b| a.mate_with b }.flatten
		@individuals.concat babies
	end

	def done?
		@individuals.first.cost(@target) == 0
	end

	def to_s
		"Gen: ##{@gen} -> #{@individuals.first.value} (cost: #{@individuals.first.cost @target})"
	end
end