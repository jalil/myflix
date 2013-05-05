module LineItemsHelper
  def rating_dropdown(item)
    select_tag "queue_items[#{item.id}][rating]", options_for_select((5.downto(1).map {|number| ["#{number} Stars", number]}), item.rating), include_blank: true
  end
end
