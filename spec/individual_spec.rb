require 'rspec'
require_relative '../lib/individual'

describe Individual do
	it 'mates with another individual' do
		a = Individual.new 'abcdef'
		b = Individual.new '123456'

		child1, child2 = a.mate_with b

		child1.value.should == 'abc456'
		child2.value.should == '123def'
	end

	it 'calculates the cost' do
		Individual.new('AZ').cost('BY').should == 2
		Individual.new('abc').cost('abc').should == 0
	end
end