class Individual
	attr_reader :value

	def self.rand(size)
		value = size.times.map{ random_char }.join
		Individual.new value
	end

	def initialize(value, should_mutate=false)
		@value = should_mutate ? mutate(value) : value
	end

	def cost(ideal)
		char_values(@value).zip(char_values(ideal)).each.map{|a, b| (a-b) ** 2 }.flatten.inject(&:+)
	end

	def mate_with(other_individual)
		[child_from(self, other_individual), child_from(other_individual, self)]
	end

	def mutate!
		@value = mutate @value
	end

	private

	def child_from(parent1, parent2)
		mid = Random.rand(parent1.value.size)+1
		child = parent1.value[0..(mid-1)] + parent2.value[mid..(parent2.value.length-1)]
		Individual.new child, should_mutate?
	end

	def self.random_char
		Random.rand(255).chr
	end

	def should_mutate?
		Random.rand < 0.5
	end

	def permutate(value)
		permutations = value.chars.to_a.permutation.map(&:join)
		index = Random.rand permutations.size
		permutations[index]
	end

	def mutate(value)
		index = Random.rand value.length
		delta = Random.rand >= 0.5 ? 1 : -1;
		new_char_code = (char_value(value[index]) + delta)
		new_char_code = 255 if new_char_code < 0
		new_char_code = 0 if new_char_code > 255
		value[index] = new_char_code.chr
		value
	end

	def char_value(char)
		char.codepoints.first
	end

	def char_values(str)
		str.each_char.map{|a| char_value a }
	end

end