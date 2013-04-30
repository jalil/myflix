class TheQueue

  attr_reader :input_items, :user

  def initialize(queue_data, user)
    @user = user
    @input_items = queue_data.map do |k,v|
      InputItem.new(k, v[:position], v[:rating])
    end
  end

  def update!
    reorder_input_items
    apply_to_queue_items!
  end

  private

  def reorder_input_items
    input_items.sort_by(&:position).each_with_index do |input_item, index|
      input_item.position = index+1
    end
  end

  def apply_to_queue_items!
    input_items.each do |input_item|
      queue_item = QueueItem.find(input_item.id)
      if user == queue_item.user
        queue_item.update_attribute(:position, input_item.position)
        queue_item.update_attribute(:rating, input_item.rating)
      end
    end
  end

  class InputItem < Struct.new(:id, :position, :rating)
  end
end
