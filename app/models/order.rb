class Order < ActiveRecord::Base
	has_many :order_items
	has_many :items, through: :order_items
  attr_writer :current_step

  accepts_nested_attributes_for :order_items

	def current_step
		@current_step || steps.first
	end

	def steps
		%w[consult delivery confirm]
	end

	def next_step
		self.current_step = steps[steps.index(current_step)+1]
	end

	def previous_step
		self.current_step = steps[steps.index(current_step)-1]
	end

	def first_step?
		current_step == steps.first
	end

	def last_step?
		current_step == steps.last
	end
end
