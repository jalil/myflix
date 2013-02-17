class TheQueue
  def rearrange_queue_items(queue_data, user)
    ordered_queue_item_ids = queue_data.to_a.sort {|x,y| x[1]["position"].to_f <=> y[1]["position"].to_f }.map {|element| element[0]}
    ordered_queue_item_ids.each_with_index do |id, index|
    item = QueueItem.find(id)
             item.update_attribute(:position, index+1) if item.user == user
             end
  end
end
