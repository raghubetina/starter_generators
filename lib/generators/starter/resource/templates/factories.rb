class IncreasingRandom
  attr_reader :value

  def initialize(value = rand(1..100))
    @value = value
  end

  def next
    next_value = value + rand(1..100)
    IncreasingRandom.new(next_value)
  end

  def to_s
    value.to_s
  end
end

FactoryGirl.define do
  factory :<%= singular_table_name %> do
    sequence(:id, IncreasingRandom.new) { |n| n.value }
<% attributes.each do |attribute| -%>
    sequence(:<%= attribute.name %>, IncreasingRandom.new) { |n| "Some fake <%= attribute.human_name.downcase %> #{n}" }
<% end -%>
  end
end
