class Table
  def initialize(astroid_details)
    @astroid_details = astroid_details
    @column_labels = { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
    @column_data = column_data()
  end

  def column_data
    @column_labels.each_with_object({}) do |(col, label), hash|
      hash[col] = {
        label: label,
        width: [@astroid_details.neos[:astroid_list].map { |astroid| astroid[col].size }.max, label.size].max}
    end
  end

  def header
     "| #{ column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
  end

  def divider
     "+-#{column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+"
  end

  def format_row_data(row_data, column_info)
    row = row_data.keys.map { |key| row_data[key].ljust(column_info[key][:width]) }.join(' | ')
    p "| #{row} |"
  end

  def create_rows
    @astroid_details.neos[:astroid_list].each { |astroid| format_row_data(astroid, @column_data) }
  end

  def make_whole_table
    p divider
    p header
    create_rows
    p divider
  end




end
