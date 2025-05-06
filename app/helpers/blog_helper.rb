module BlogHelper
  def category_name(category_id)
    BLOG_CATEGORIES.find { |category| category[:id] == category_id }&.dig(:topic) || "Unknown Category"
  end
end
