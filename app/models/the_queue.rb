class TheQueue
  attr_reader :queue_data, :user

  def initialize(queue_data, user)
    @user = user
    @queue_data = queue_data.each  do |key, value|
      InputItem.new(key, value[:position], value[:rating])
    end
  end

  def update
    reorder_items
    update_queue_item
  end

  private
  def reorder_items
    queue_data.sort_by(&:position).each_with_index do |item, index|
      item.position = index + 1
    end
  end

  def update_queue_item
    queue_data.each do |item|
      queue_item = QueueItem.find(item.id)
      if user == queue_item.user
        queue_item.update_attribute(:position, item.position)
        queue_item.update_attribute(:rating, item.rating)
      end
    end
  end

  class InputItem < Struct.new(:id, :position, :rating)
  end
end
