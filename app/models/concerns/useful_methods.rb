# TODO: Refactoring
module UsefulMethods
  extend ActiveSupport::Concern

  def japanese_date_expression(time_object)
    day_of_the_week = ['日', '月', '火', '水', '木', '金', '土']
    time_object.strftime("%Y/%m/%d(#{day_of_the_week[time_object.wday]}) %H:%M:%S")
  end
end
