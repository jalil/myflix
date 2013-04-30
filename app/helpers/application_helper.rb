module ApplicationHelper
  def all_category_options
    options_for_select(Category.all.map {|category| [category.title, category.id]})
  end
end
