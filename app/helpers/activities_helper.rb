module ActivitiesHelper
  def activities
    Activity.all.collect{|a| [a.name, a.id]}
  end
end
