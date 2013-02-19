class TheQueue
  def rearrange_queue_lists(queue_data, user)
    ordered_queue_list_ids = queue_data.to_a.sort {|x,y| x[1]["position"].to_f <=> y[1]["position"].to_f }.map {|element| element[0]}

    ordered_queue_list_ids.each_with_index do |id, index|
        list = LineItem.find(id)
        list.update_attribute(:position, index+1) if list.user == user
    end
  end
end
